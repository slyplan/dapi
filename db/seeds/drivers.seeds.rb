puts 'Seeding drivers...'

seed_json_file = 'db/seeds/drivers.json'
raise "File #{seed_json_file} does not exist" unless File.exist?(seed_json_file)
raise 'Could not seed, table drivers is not empty' if Driver.first

json_string = File.read(seed_json_file)
json = JSON.parse(json_string)

json.each do |driver|
  Driver.create(driver)
end

puts 'Drivers seeded successfully'
