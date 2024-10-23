#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 21 16:41:00 2024

@author: root
"""

from airflow.decorators import dag,task
from datetime import datetime, timedelta


@dag(dag_id='parent',
     schedule='* */2 * * *',
     start_date=datetime(2024,10,19),
     is_paused_upon_creation=True, catchup = False,)
def test_one():
    
    
    for i in range(3):
        minute = 10 + 2*i
        @dag(
            dag_id=f'child_{datetime.now().microsecond}',
            schedule= f'{minute} 20 * * *',
            start_date=datetime(2024,10,19),
            end_date =  datetime(2024,10,23),
            is_paused_upon_creation=False,
            catchup = False,
            
            )
        def make_it():
            @task()
            def do_it():
                print(f'i am child_{datetime.now().microsecond}')
            
            do_it() 

        make_it()   
        
test_one()        
    