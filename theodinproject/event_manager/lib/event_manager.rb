require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(number)
  phone_number = number.gsub(/\D/, '') #replace everything, that is not a number with ""
  digits = phone_number.size
  if digits > 11 || digits < 10
    'Bad number'
  elsif digits == 11
    phone_number[0] != '1' ? 'Bad number' : phone_number[1..10]
  end
  phone_number
end

def most_frequent(data_hash)
  max_value = data_hash.max_by { |key, value| value }[1]
  data_hash.select { |key, value| value == max_value}.keys
end

def find_active_hours(registration_hours)
  most_frequent(registration_hours)
end

def find_active_days(registration_days)
  day_numbers = most_frequent(registration_days)
  day_names = []
  day_numbers.each do |nr|
    case nr
    when 0
      day_names << 'Monday'
    when 1
      day_names << 'Tuesday'
    when 2
      day_names << 'Wednesday'
    when 3
      day_names << 'Thursday'
    when 4
      day_names << 'Friday'
    when 5
      day_names << 'Saturday'
    when 6
      day_names << 'Sunday'
    end
  end
  day_names
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') { |file| file.puts form_letter }
end

puts 'EventManager initialized.'

contents =
  CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

registration_hours = Hash.new(0)
registration_days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_number(row[:homephone])
  registration_time = Time.strptime(row[:regdate], '%m/%d/%y %H:%M')
  registration_hours[registration_time.hour] += 1
  registration_days[registration_time.wday] += 1

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

active_hours = find_active_hours(registration_hours)
active_days = find_active_days(registration_days)

puts "Active hours: #{active_hours.map { |h| h.to_s + ':00' }.join(', ')}."
puts "Active days: #{active_days.join(', ')}."
