#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct 22 17:59:30 2024

@author: root
"""

from airflow import DAG
from airflow.decorators import dag,task
from airflow.operators.subdag import SubDagOperator
from datetime import datetime, timedelta
import psycopg2 as psg
from twilio.rest import Client
import json
import time


schedulerss = [
    '20 16 * * *',
    '30 16 * * *',
    '40 16 * * *',
    
    ]

starts = [
    datetime(2024,10,22,16,15),
    datetime(2024,10,22,16,25),
    datetime(2024,10,22,16,35),
    
    ]

conn = psg.connect(
    host='192.168.2.104',
    database='mucho',
    user='postgres',
    password='1728',    
    )
curr  = conn.cursor()
query = "select * from public.forms where motivo!='vazio' limit 3"
curr.execute(query)
rows = curr.fetchall()

# Configuração do Twilio
TWILIO_SID               = 'AC069f1485becb681509aa3ea0b36dec02'
TWILIO_AUTH_TOKEN        = 'f7549c468985f8ece064b4dee44e8924'
TWILIO_PHONE_NUMBER      = 'whatsapp:+553299696625'
DESTINATION_PHONE_NUMBER = 'whatsapp:+553285140754' #whatsapp:+553199795243
TEMPLATE_ID              = 'HX4f923bef0faec67a03763c10c9c88e3a'
WEB_HOOK                 = 'https://8808-186-233-35-132.ngrok-free.app/whatsapp/webhook/'


# Define the SubDAG for sending messages
def send_message_subdag(parent_dag_name, child_dag_name, start_date, schedule_interval, row):
    
    @dag(
        dag_id=f"{parent_dag_name}.{child_dag_name}",
        start_date=start_date,
        end_date  = start_date + timedelta(days=2, minutes=10),
        schedule=schedule_interval,
        is_paused_upon_creation=True,
        catchup=False
    )
    def subdag():
        
        @task
        def do_template():
            client = Client(TWILIO_SID, TWILIO_AUTH_TOKEN)
            message = client.messages.create(
                content_sid=TEMPLATE_ID,
                status_callback=WEB_HOOK,
                from_=TWILIO_PHONE_NUMBER,
                to=DESTINATION_PHONE_NUMBER,
            )

        @task(trigger_rule="all_done")
        def after_template():
            client = Client(TWILIO_SID, TWILIO_AUTH_TOKEN)
            fulano, dital, _, date, motivo, obs = row
            mess = f"""Boa tarde _{fulano}_!
Estou passando para te lembrar da visita ao _{dital}_ no dia _{date}_.
O motivo pelo qual não efetuou o pedido foi:
    
_{motivo}_

E seu registro: 

_{obs}_
            """
            message = client.messages.create(
                body=mess,
                status_callback=WEB_HOOK,
                from_=TWILIO_PHONE_NUMBER,
                to=DESTINATION_PHONE_NUMBER,
            )
            
        @task(trigger_rule="all_done")
        def delayers():
            time.sleep(15)
            
        send_1 = do_template()
        dlay   = delayers()
        send_2 = after_template()
        send_1 >> dlay >> send_2
        
    
    return subdag()

# Main DAG definition
dag_one = DAG(
    dag_id='psg_11',
    schedule='0 16 * * *',
    start_date=datetime(2024, 10, 21, 15,30),
    is_paused_upon_creation=True,
    catchup=False
)


for i in range(len(rows)):
    row = rows[i]
    
    # Creating a subDAG task for each row
    subdag_task = SubDagOperator(
        task_id=f'conversation_{i}',
        subdag=send_message_subdag('psg_9', f'conversation_{i}', starts[i], schedulerss[i], row),
        dag=dag_one
    )
    


