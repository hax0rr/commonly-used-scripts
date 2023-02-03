require 'net/http'
require 'json'
require 'uri'
require 'csv'

# Script which calls API and exports the required fields in the CSV
class Utility
	def self.export_to_csv
		count = 0
		user_ids = [54,12,3,4123,4,124,41,12]
		CSV.open("result.csv", "w") do |csv|
			csv << ["User id", "Current tier","Last tier change at", "Tier change type"]

			for user_id in user_ids do
				res = self.get_api_response(user_id)

				if res["data"] == nil
					puts "Invalid user #{user_id}"
					next
				end

				curr_tier = res["data"]["current_tier"]["name"]
				last_tier_change_at = res["data"]["last_tier_change"]["at"]
				last_tier_change_type = res["data"]["last_tier_change"]["change"]

				csv << [user_id, curr_tier, last_tier_change_at, last_tier_change_type]
				count += 1
				if count % 50 == 0
					puts "Processed #{count}"
				end
			end
		end
	end

	def self.get_api_response(user_id)
		url = "http://localhost/admin/users/#{user_id}"
		uri = URI.parse(url)

		request = Net::HTTP::Get.new(uri.request_uri)
		request['Content-Type'] = 'application/json' 
		request['Authorization'] = 'XXXX' 

		http = Net::HTTP.new(uri.host, uri.port)

		res = http.request(request)
		JSON.parse(res.body)
	end
end

Utility.export_to_csv
