module ApplicationHelper
	def self.create_application user
	auth = { username: ENV['user'], password:  ENV['pwd']}
	body = { 
		"id": user.id, 
		"name": user.name,
		"surname": user.surname,
		"patronymic": user.patronymic, 
		"passport": user.passport_code,
		"passport_date": user.passport_date,
		"mobile_phone": user.mobile_phone,
		"email": user.email, 
		"locality_name": user.reg_city,
		"locality": user.locality_id,
		"street": user.reg_street, 
		"house": user.reg_house,
		"apartment": user.reg_flat,
		"fact_locality": user.fact_locality_id, 
		# "fact_region": 46,
		"fact_street": user.fact_street, 
		"fact_house": user.fact_house, 
		"birth_date": user.birth_date, 
		"birth_place": user.birth_place, 
		"credit_sum": user.desired_amount
	} 
	url_send_all = "https://unicom24.ru/api/partners/qiwi/v1/create_send_all/"
	url_create = "https://unicom24.ru/api/partners/requests/v1/create/"
	result = HTTParty.post(
	  url_send_all, 
	  basic_auth: auth,
      body: body
	)

	user.update :app_id => result.parsed_response['id'],
				:response =>  result.parsed_response,
				:status => result.parsed_response['status']
	puts " "	
	puts "<<<<<<<<<<<<<<<<<<<<<<"			
	puts "<<<<<<<<<<<<<<<<<<<<<<"
	puts user.response
	puts "  "
	puts "<<<<<<<<<<<<<<<<<<<<<<"
	puts "<<<<<<<<<<<<<<<<<<<<<<"

	end

	def self.find_location fact_city
		
		auth = { username: ENV['user'], password:  ENV['pwd']}
		url = "https://unicom24.ru/api/partners/requests/v1/locality_search/?term=" + fact_city
		url = URI.encode url
		result = HTTParty.get(url, basic_auth: auth)
		puts " "	
		puts "<<<<<<<<<<<<<<<<<<<<<<"			
		puts "<<<<<<<<<<<<<<<<<<<<<<"
		puts result.parsed_response
		puts "  "
		puts "<<<<<<<<<<<<<<<<<<<<<<"
		puts "<<<<<<<<<<<<<<<<<<<<<<"		
		if !result.parsed_response.blank?
			return result.parsed_response[0]['id']
		end
	end

	def self.get_regions
		url = "https://unicom24.ru/api/partners/requests/v1/region/" 
		auth = { username: ENV['user'], password:  ENV['pwd']}	
		result = HTTParty.get(url, basic_auth: auth)
		result.parsed_response
	end
end
