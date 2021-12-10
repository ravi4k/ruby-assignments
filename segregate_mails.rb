# frozen_string_literal: true

require 'faker'
require 'csv'

class CSVInfo
  ROWS = 5000
  POSSIBLE_STATES = %w[delivered bounced sent opened failed].freeze
  FILE_PATH = 'random_mails.csv'
  OUTPUT_FOLDER = 'output'
  OUTPUT_PATHS = POSSIBLE_STATES.map do |state|
    "#{OUTPUT_FOLDER}/result_#{state}.csv"
  end
end

def generate_random_data
  CSV.open(CSVInfo::FILE_PATH, 'w') do |csv|
    CSVInfo::ROWS.times do
      mail = Faker::Internet.email
      state = CSVInfo::POSSIBLE_STATES.sample
      csv << [mail, state]
    end
  end
end

def refresh_list
  generate_random_data
end

def segregate_mails
  refresh_list unless File.exist?(CSVInfo::FILE_PATH)
  Dir.mkdir(CSVInfo::OUTPUT_FOLDER) unless Dir.exist?(CSVInfo::OUTPUT_FOLDER)

  csv_file = CSV.open(CSVInfo::FILE_PATH, 'r')
  result_files = CSVInfo::OUTPUT_PATHS.map do |path|
    CSV.open(path, 'w')
  end

  csv_file.each do |line|
    state = line[1]

    CSVInfo::POSSIBLE_STATES.each_index do |idx|
      result_files[idx] << line if state == CSVInfo::POSSIBLE_STATES[idx]
    end
  end

  csv_file.close
  result_files.each(&:close)
end

segregate_mails
