#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct 22 13:15:26 2024

@author: root
"""

from airflow.decorators import dag,task
from datetime import datetime, timedelta
import psycopg2 as psg
from twilio.rest import Client
import json

conn = psg.connect(
    host='192.168.2.104',
    database='mucho',
    user='postgres',
    password='1728',    
    )
curr  = conn.cursor()
query = "select * from public.forms limit 3"
curr.execute(query)
rows = curr.fetchall()

# Configuração do Twilio
TWILIO_SID               = 'AC069f1485becb681509aa3ea0b36dec02'
TWILIO_AUTH_TOKEN        = 'f7549c468985f8ece064b4dee44e8924'
TWILIO_PHONE_NUMBER      = 'whatsapp:+553299696625'
DESTINATION_PHONE_NUMBER = 'whatsapp:+553285140754'
TEMPLATE_ID              = 'HX4f923bef0faec67a03763c10c9c88e3a'
WEB_HOOK                 = 'https://8808-186-233-35-132.ngrok-free.app/whatsapp/webhook/'





@dag(dag_id='psg',
     schedule='10 17 * * *',
     start_date=datetime(2024,10,20),
     is_paused_upon_creation=True, catchup = False,)
def test_one():
    
    
    for i in range(3):
        minute = 20 + 2*i
        @dag(
            dag_id=f'conversation_{datetime.now().microsecond}',
            schedule= f'{minute} 17 * * *',
            start_date=datetime(2024,10,19),
            end_date =  datetime(2024,10,23),
            is_paused_upon_creation=False,
            #catchup = False,
            
            )
        def make_it():
            @task
            def do_template():
                
                client = Client(TWILIO_SID, TWILIO_AUTH_TOKEN)
                message = client.messages.create(
                    content_sid=TEMPLATE_ID,
                    status_callback=WEB_HOOK,
                    # body=message,
                    from_=TWILIO_PHONE_NUMBER,
                    to=DESTINATION_PHONE_NUMBER,
                )
            @task(trigger_rule="all_done")
            def after_template():
                
                client = Client(TWILIO_SID, TWILIO_AUTH_TOKEN)
                fulano ,dital,_,_,motivo,obs = rows[i]
                mess = f""""
                Boa tarde {fulano}!
                Estou passando para te lembrar da visita ao {dital}.
                O motivo pelo qual não efetuou o pedido foi:
                    {motivo}
                
                E seu registro:
                    {obs}
            
                """
                message = client.messages.create(
                    #content_sid=TEMPLATE_ID,
                    status_callback=WEB_HOOK,
                    body=mess,
                    from_=TWILIO_PHONE_NUMBER,
                    to=DESTINATION_PHONE_NUMBER,
                )   
                       
            do_template() >> after_template()

        make_it()   
        
test_one()        
    