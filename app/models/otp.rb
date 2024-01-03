class Otp < ApplicationRecord
  OTP_CHARS = 6
  EXPIRY_MINS = 5

  # TODO: move to OtpGenerator
  def self.generate(mobile_number:)
    # move to OTP model
    deactivate_existing_otps(mobile_number: mobile_number)
    otp = Otp.new(
      code: generate_uniq_code, mobile_number: mobile_number, expired_at: Time.now + EXPIRY_MINS.minutes,
      status: 'generate'
    )
    otp.save
    otp.deliver_sms

    { 
      status: 'success',
      message: "Successfully generated OTP for #{mobile_number}"
    }
  rescue => e
    Rails.logger.debug("OTP generate error: #{e}")
    {
      status: 'failure',
      message: 'Something went wrong with OTP generation'
    }
  end

  # move to OtpGenerator
  def self.generate_code
    (1..OTP_CHARS).to_a.map {|_number| SecureRandom.random_number(9) }.join('')
  end

  # move to OtpGenerator
  def self.generate_uniq_code
    loop do
      new_code = generate_code
      existing_otp = Otp.find_by(code: new_code)

      return new_code if existing_otp.nil?
    end
  end

  # move to OtpDelivery(type: 'sms')
  def deliver_sms
    # code to DeliverSms.call()
    update_columns(status: 'delivered')
  end

  
  def self.deactivate_existing_otps(mobile_number:)
    Otp.where(mobile_number: mobile_number, status: 'delivered').update_all(status: 'de-activated')
  end
end
