puts 'Seeding metrics...'

seed_json_file = 'db/seeds/metrics.json'
raise "File #{seed_json_file} does not exist" unless File.exist?(seed_json_file)
raise 'Could not seed, table metrics is not empty' if Metric.first

json_file = File.open(seed_json_file, 'r') do |f|
  f.each_line do |line|
    next if line.chop.empty?
    json_obj = JSON.parse(line)
    object = Metric.new(json_obj)
    unless object.save
      puts object.errors.messages
      return
    end
  end
end

puts 'Metrics seeded successfully'
