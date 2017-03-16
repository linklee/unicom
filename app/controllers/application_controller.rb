class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  require 'httparty'
  include ApplicationHelper

  def index 
	render 'templates/index'
  end
  def frame 
  	@click_id = params['click_id']
  	@sub_id = params['sub_id']

	render 'templates/frame'
  end
  def step2 
	render 'templates/step2'
  end
  def thnx 
	render 'templates/thanks'
  end
  
  def send_app 
  	@user = User.new   
  	#locality fact  
	@user.fact_city = params[:fact_city]
    @user.fact_street = params[:fact_street]
	@user.fact_house = params[:fact_house]
	@user.fact_flat = params[:fact_flat]

	#reg locality
	@user.reg_locality_name = params[:reg_locality_name]
	@user.reg_city = params[:reg_city]
	@user.reg_street = params[:reg_street]
	@user.reg_house = params[:reg_house]
	@user.reg_flat = params[:reg_flat]
	
	#names
	@user.surname = params[:surname]
	@user.name = params[:name]
	@user.patronymic = params[:patronymic]
	@user.mobile_phone = params[:mobile_phone]
	@user.email = params[:email]
	@user.desired_amount =  params[:desired_amount]
	@user.agree_rules = params[:agree_rules]
	@user.same_address = params[:same_address]
	#passport
	@user.passport_code = params[:passport_code]
	@user.passport_date = params[:passport_date]
	@user.birth_date = params[:birth_date]
	@user.birth_place = params[:birth_place]
	@user.locality_id = ApplicationHelper.find_location @user.reg_city
	@user.fact_locality_id = ApplicationHelper.find_location @user.fact_city
	@user.partner_id = params[:partner_id]
	@user.save	
	render 'templates/thanks'
	ApplicationHelper.create_application @user
  end

  def offer
	  click_id = params[:click_id]
	  status = params[:status]
	  old_status = status
	  # spam - Ошибка/Спам/Дубль
	  # return - Возврат
	  # canceled - Отменен
	  # processing - Обработка
	  # accepted - Принят
	  # paid - Оплачен

	  case status
		  when 'spam' 
		    status = 3
		  when 'canceled'
		    status = 3
	      when 'return'
		    status = 3
		  when 'processing'
		    status = 2 
		  when 'accepted'
		    status = 1
		  when 'paid'
		    status = 1
		  #funcpa Статус заявки (waiting - создана, approved - подтверждена, decline - отменена)
		  when 'approved'
		    status = 1
		  when 'waiting'
		    status = 2
		  when 'decline'
		    status = 3
		  else
		    status = 2
	  end
	  test_url = "http://xxx.requestcatcher.com/?clickid=#{click_id}&goal=1&status=#{status}&old_status=#{old_status}"
	  ok_test_url = URI.parse(URI.encode(test_url))
	  puts "хуйпизда"
	  url = "http://offers.atgmedia.affise.com/postback?clickid=#{click_id}&goal=1&status=#{status}" 
	  encoded_url = URI.encode(url)
	  ok_url = URI.parse(encoded_url)
	  HTTParty.get ok_url
	  HTTParty.get ok_test_url
	  render html: "ok #{status} old status: #{old_status} click_id: #{click_id} <br> atg_url: #{ok_url}"
  end

  def mediaoffers
	click_id = params[:click_id]
	status = Integer params[:status]
    old_status = status

	#ожидание
	if status < 5
		status = 2
	end 

	#отказ
	if status == 5 or status == 12
		status = 3
	end

	#принят
	if status == 5 && status < 12
		status = 1
	end
	test_url = "http://xxx.requestcatcher.com/?clickid=#{click_id}&goal=1&status=#{status}"
	ok_test_url = URI.parse(URI.encode(test_url))

	url = "http://offers.atgmedia.affise.com/postback?clickid=#{click_id}&goal=1&status=#{status}" 
	encoded_url = URI.encode(url)
	ok_url = URI.parse(encoded_url)
	HTTParty.get ok_url
	HTTParty.get ok_test_url
	render html: "ok #{status} old status: #{old_status} click_id: #{click_id} <br> atg_url: #{ok_url}"
  end

end
