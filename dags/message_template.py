from twilio.rest import Client
import json

# Configuração do Twilio
TWILIO_SID               = 'AC069f1485becb681509aa3ea0b36dec02'
TWILIO_AUTH_TOKEN        = 'f7549c468985f8ece064b4dee44e8924'
TWILIO_PHONE_NUMBER      = 'whatsapp:+553299696625'
DESTINATION_PHONE_NUMBER = 'whatsapp:+553285140754'
TEMPLATE_ID              = 'HX4f923bef0faec67a03763c10c9c88e3a'
WEB_HOOK                 = 'https://8808-186-233-35-132.ngrok-free.app/whatsapp/webhook/'

client = Client(TWILIO_SID, TWILIO_AUTH_TOKEN)
message = client.messages.create(
    content_sid=TEMPLATE_ID,
    #status_callback=WEB_HOOK,
    # body=message,
    from_=TWILIO_PHONE_NUMBER,
    to=DESTINATION_PHONE_NUMBER,
)

