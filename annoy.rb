require 'byebug'
require 'dotenv/load'
require 'twilio-ruby'

SSID = ENV['TWILIO_SSID']
TOKEN = ENV['TWILIO_TOKEN']
FROM = ENV['TWILIO_FROM']
MSID = ENV['TWILIO_MESSAGING_SERVICE_ID']
NUMBERS_FILE = ENV['PHONE_NUMBERS_FILE']

numbers = `cat #{NUMBERS_FILE}`.split

client = Twilio::REST::Client.new(SSID, TOKEN)

puts "What message would you like to send?"
message = gets

for num in numbers
  client.account.messages.create({
    messaging_service_id: MSID,
    to: num,
    from: FROM,
    body: message
  })
end
