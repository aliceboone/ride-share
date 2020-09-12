########################################################
# Step 1: Establish the layers
# In this section of the file, as a series of comments,
# create a list of the layers you identify.

# 1 - driver_id 
# 2 - trips - created by me 
# 3 - date 
# 4 - details - created by me
# 5 - ride_id
# 6 - cost 
# 7 - rating

# Which layers are nested in each other?
# drive_id and trips is nestes in a array named drivers
# date, details are nested in trips
# ride_id, cost, rating is nested details

# Which layers of data "have" within it a different layer? Which layers are "next" to each other?

# 1-  For my data structure, I created variable named drivers, used the drive_id as a key and 
# 2 - I created a layer name trip to nest the value of drivers, then I used the date as a trip key and 
# 3 - I created another layer named details to nest the trip value, and a layer detail, and inside the detail 
# 4 - I put the ridw_id, cost and rating.

# drivers [{
#      driver_id: 'DR0001',
#      trips: [{
#                  date: '3rd Feb 2016',
#                  details: [{
#                                ride_id: 'RD0003',
#                                cost: 10,
#                                rating: 3
#                            },...]

########################################################
# Step 2: Assign a data structure to each layer
# Copy your list from above, and in this section
# determine what data structure each layer should have

# 1 - driver_id - is a key of a hash, the data assign to the key is string.
# 2 -  trip - is a array os hashes.
# 3 - date - is a key of a hash, the data assign to the key is string.
# 4 - details - array of hashes.
# 5 - ride_id - is inside a hash as a key of a trip detail, the value give to this key is string.
# 6 - cost - is inside a hash as a key of a trip detail, the value give to this key is integer.
# 7 - rating - is inside a hash as a key of a trip detail, the value give to this key is integer.

########################################################
# Step 3: Make the data structure!

# Setup the entire data structure:
# based off of the notes you have above, create the
# and manually write in data presented in rides.csv
# You should be copying and pasting the literal data
# into this data structure, such as "DR0004"
# and "3rd Feb 2016" and "RD0022"

drivers = [{
  driver_id: 'DR0001',
  trips: [{
    date: '3rd Feb 2016',
    details: [{
      ride_id: 'RD0003',
      cost: 10,
      rating: 3
    },
              {
                ride_id: 'RD0015',
                cost: 30,
                rating: 4
              }]
  },
          {
            date: '5rd Feb 2016',
            details: [{
              ride_id: 'RD0003',
              cost: 45,
              rating: 2
            }]
          }]
},

           {
             driver_id: 'DR0002',
             trips: [{
               date: '3rd Feb 2016',
               details: [{
                 ride_id: 'RD0073',
                 cost: 25,
                 rating: 5
               }]
             },
                     {
                       date: '4rd Feb 2016',
                       details: [{
                         ride_id: 'RD0013',
                         cost: 15,
                         rating: 1
                       }]
                     },
                     {
                       date: '5rd Feb 2016',
                       details: [{
                         ride_id: 'RD0066',
                         cost: 35,
                         rating: 3
                       }]
                     }]
           },
           {
             driver_id: 'DR0003',
             trips: [{
               date: '4rd Feb 2016',
               details: [{
                 ride_id: 'RD0066',
                 cost: 5,
                 rating: 5
               }]
             },
                     {
                       date: '5rd Feb 2016',
                       details: [{
                         ride_id: 'RD0003',
                         cost: 50,
                         rating: 2
                       }]
                     }]
           },

           {
             driver_id: 'DR0004',
             trips: [{
               date: '3rd Feb 2016',
               details: [{
                 ride_id: 'RD0022',
                 cost: 5,
                 rating: 5
               }]
             },
                     {
                       date: '4rd Feb 2016',
                       details: [{
                         ride_id: 'RD0022',
                         cost: 10,
                         rating: 4
                       }]
                     },
                     {
                       date: '5rd Feb 2016',
                       details: [{
                         ride_id: 'RD0073',
                         cost: 20,
                         rating: 5
                       }]
                     }]
           }]


########################################################
# Step 4: Total Driver's Earnings and Number of Rides

# 1 - The number of rides each driver has given?
# Get the number of trip each driver did
def number_of_rides(drivers)
  driver_list = []
  drivers.each do |driver|
    result = 0
    driver[:trips].each do |trip|
      details = trip[:details]
      result += details.length
    end
    driver_list << { driver_id: driver[:driver_id], count: result }
  end
  return driver_list
end
ride_count_data = number_of_rides(drivers)
ride_count_data.each do |drive_data|
  puts "The number of ride driver #{drive_data[:driver_id]} has given was #{drive_data[:count]}."
end
puts

# 2 - The total amount of money each driver has made?
# Sum the cost of all trip by driver to get the amount of momey each driver got.
def amount_of_money(drivers)
  amount_list = []
  drivers.each do |driver|
    result = 0
    driver[:trips].each do |trip|
      trip[:details].each do |detail|
        result += detail[:cost]
      end
    end
    amount_list << { driver_id: driver[:driver_id], amount: result }
  end
  return amount_list
end
amount_count_data = amount_of_money(drivers)
amount_count_data.each do |amount_data|
  puts "The amount of money the driver #{amount_data[:driver_id]} has made was $#{amount_data[:amount]}."
end
puts

# 3 - The average rating for each driver
# Sum the rating and divide by the number of trip the driver had and find the average.
def average_rating(drivers)
  average_rate = []
  drivers.each do |driver|
    result = 0.0
    length = 0
    driver[:trips].each do |trip|
      length += trip[:details].length
      trip[:details].each do |detail|
        result = (result + detail[:rating])
      end
    end
    result /= length
    average_rate << { driver_id: driver[:driver_id], average: result.round(2)}
  end
  return average_rate
end
average_count_data = average_rating(drivers)
average_count_data.each do |average_data|
  puts "The average rating for the driver #{average_data[:driver_id]} is #{average_data[:average]}."
end
puts

# 4 - Which driver made the most money?
# Use max to define which driver has Which driver made the most money.
amount_count_data = amount_of_money(drivers)
max_amount = amount_count_data.max_by do |amount_data|
  amount_data[:amount]
end
puts "The driver #{max_amount[:driver_id]} has made the most money $#{max_amount[:amount]}."

puts
#  5 - Which driver has the highest average rating?
#  Use max to define which driver has the highest average rating.
average_count_data = average_rating(drivers)
max_average = average_count_data.max_by do |average_data|
  average_data[:average]
end
puts "The driver #{max_average[:driver_id]} has score highest rating #{max_average[:average]}."
