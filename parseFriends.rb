require 'csv'
friends = []
CSV.open('friends.csv').to_a.each do |row|
  name, party_mates = row[0], row[1]
  first, last = name.split(' ')
  id = [first, last].map { |n| n.downcase.gsub(/[^a-z]/, '') }.join('-')
  friends << { 
    first_name: first, last_name: last, id: id, party_mate_indexes: party_mates 
  }
end
friends.each_with_index do |friend, index|
  friend[:party_mates] = []
  if friend[:party_mate_indexes]
    friend[:party_mate_indexes].split(',').each do |i|
      friend[:party_mates] << friends[(index + i.to_i)][:id]
    end
  end
end