from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
from twilio.rest import Client

# Definindo as variáveis do Twilio
TWILIO_SID = 'AC069f1485becb681509aa3ea0b36dec02'
TWILIO_AUTH_TOKEN = 'f7549c468985f8ece064b4dee44e8924'
TWILIO_PHONE_NUMBER = 'whatsapp:+553299696625'    #3299696625
DESTINATION_PHONE_NUMBER = 'whatsapp:+553285140754' #3285140754 #3199795243


def send_whatsapp_message():
    # Inicializando o cliente do Twilio
    client = Client(TWILIO_SID, TWILIO_AUTH_TOKEN)

    # Enviando a mensagem de WhatsApp
    message = client.messages.create(
        from_=TWILIO_PHONE_NUMBER,
        body='Esta é uma mensagem automatizada do Airflow!',
        to= DESTINATION_PHONE_NUMBER
    )

    # Log da mensagem
    print(f"Mensagem enviada: {message.sid}")


# Configurando a DAG
default_args = {
    'owner': 'arth_brave',
    'depends_on_past': False,
    'start_date': datetime(2024,10,16) + timedelta(hours=17, minutes=5),#datetime.now() + timedelta(minutes=5),
    'end_date': datetime(2024,10,24) + timedelta(hours=17, minutes=5),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'send_whatsapp_message_dag_19',
    default_args=default_args,
    description='Uma DAG simples para enviar mensagens WhatsApp com Twilio',
    schedule_interval= '5 17 * * *',#'@daily',#None,#'*/15 * * * *', #'@daily',  # Agendado para rodar manualmente
    catchup=False,
    is_paused_upon_creation=False,
    max_active_runs=1,
)

# Tarefa que enviará a mensagem
send_message_task = PythonOperator(
    task_id='send_whatsapp_message',
    python_callable=send_whatsapp_message,
    dag=dag,
)

# Definindo a DAG para rodar após 10 minutos da criação
send_message_task.execution_timeout = timedelta(minutes=10)
