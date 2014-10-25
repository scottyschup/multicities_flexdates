# search kayak.com with multiple cities and flexible dates

class Trip
  attr_accessor :num_legs, :flights
  
  def initialize(num_legs)
    @num_legs = num_legs
    @flights = []
    @num_legs.times do |i|
      puts "Enter the origin airport code for leg ##{i+1}:"
      origin = gets.chomp
      
      puts "Enter the destination airport code for leg ##{i+1}:"
      dest = gets.chomp
      
      puts "Enter the earliest departure date for for leg ##{i+1}:"
      date = gets.chomp
      
      puts "Enter the # of flexible days after departure date for leg ##{i+1}:"
      flex = gets.chomp.to_i
      
<<<<<<< HEAD
      puts 'Check nearby airports as well (y/n)?'
      nearby = gets.chomp
      
      if nearby == 'y' || nearby == 'Y'
        origin += ",nearby"
        dest += ",nearby"
      end
      
      leg_num = i + 1
      
=======
      leg_num = i + 1

>>>>>>> b0a6a0e09788b6a8c33c2a8b3a63bc705c83b34d
      @flights << Flight.new(origin, dest, date, flex, leg_num)
    end
    return permutations
  end
  
  def cities
    cities = []
    @flights.each do |flight|
      cities << flight.origin unless cities.include? flight.origin
      cities << flight.destination unless cities.include? flight.destination
    end
    return cities
  end
  
  def permutations
    perms = 1
    @flights.each do |flight|
      perms *= ( flight.flexibility + 1 )
    end
    perms
  end
  
  
  class Flight
    attr_accessor :origin, :destination, :leg_number, :date_range
      
    def date
      @date
    end
    
    def date=(val)
      @date = convert_to_date val
      @date_range = create_range  # updates date_range if date changed
    end
    
    def convert_to_date date
      # date should be a Date object 
      #    or a string with year, month, and day delineated by '-'
      #    e.g. '2014-10-23'
      if date.class == Date
        return date
      else
        d = date.split('-').map! { |str| str.to_i }
        return Date.new(d[0], d[1], d[2])
      end
      
    end
    
    def date_range
      @date_range = create_range
    end
    
    def flexibility
      @flexibility
    end
    
    def flexibility=(val)
      @flexibility = val.to_i
      @date_range = create_range  # updates date_range if flex changed
    end
    
    def initialize(origin, destination, date, flex, leg_num)
      @origin = origin
      @destination = destination
      @date = convert_to_date(date)
      @flexibility = flex
      @date_range = create_range
      @leg_number = leg_num
      puts "#{@origin} #{@destination} #{@date.to_s} #{@flexibility}"
    end
    
    def create_range
      range = [@date]
      @flexibility.times do |i|
        range << @date + ( i + 1 )
      end
      return range
    end
    
    def url_segments
      @date_range = create_range
      url_segments = []
      @date_range.each do |date|
        url_segments << "/#{@origin}-#{@destination}/#{date.to_s}"
      end
      return url_segments
    end
    
  end  # of Flight class
  
  
  def search
    generate_urls.each do |url|
      system("open", url)
    end
  end
  
  def generate_urls
    urls = []
    url = "http://www.kayak.com/flights"
    
    arr_product = @flights[0].url_segments
    
    @flights[1..-1].each do |flight|
      arr_product = arr_product.product flight.url_segments
    end
    
    arr_product.each do |arr| 
      urls << url + arr.join('') 
    end
    urls
  end
 
end
