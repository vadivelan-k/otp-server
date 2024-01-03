class Api::V1::OtpsController < ApplicationController
  before_action :permit_generate_params, :required_generated_params, only: [:generate]

  def generate
    # otp record,
    permitted_params = permit_generate_params
    puts permitted_params.inspect
    response = Otp.generate(mobile_number: permitted_params[:mobile_number])


    render json: response.to_json
  end

  def verify
  end

  def permit_generate_params
    params.permit(:mobile_number)
  end

  def required_generated_params
    params.require(:mobile_number)
  rescue ActionController::ParameterMissing
    render json: { status: 'failure', message: 'Invalid input' }
  end
end
