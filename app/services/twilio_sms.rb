class TwilioSms
  attr_reader :message, :media_url

  def initialize(message, media_url=nil)
    @message = message
    @media_url = media_url
  end

  def send(phone)
    client = Twilio::REST::Client.new

    if media_url.nil? 
      client.messages.create({
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone,
        body: message
      })
    else
      client.messages.create({
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: phone,
        body: message,
        media_url: [media_url]
      })
    end
  end
end