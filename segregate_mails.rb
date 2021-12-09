# frozen_string_literal: true

require 'faker'
require 'csv'

def generate_random_data
  possible_states = %w[delivered bounced sent opened failed]
  rows = 5000
  file_path = 'random_mails.csv'

  CSV.open(file_path, 'w') do |csv|
    rows.times do
      mail = Faker::Internet.email
      state = possible_states.sample
      csv << [mail, state]
    end
  end
end

def refresh_list
  generate_random_data
end
