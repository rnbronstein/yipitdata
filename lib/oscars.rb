require 'json'
require 'open-uri'

class OscarData
  attr_reader :data

  def initialize
    @data = JSON.parse(RestClient.get('oscars.yipitdata.com'))
  end

  def results
    array = []
    data['results'].each do |year_information|
      year_information['films'].each do |film|
        year = format_year(year_information['year'])
        film_obj = Film.new(film) #call for film details by instantiating a film object
        if film_obj.winner?
          array << {
            year: year,
            title: film_obj.title,
            budget: film_obj.budget
          }
        end
      end
    end
    array
  end

  private
  def format_year(year)
    year.gsub(/(\[).*(\w|\d).*?(\])/, '').gsub(/\s/, '') #this removes the footnotes and blank spaces so it looks nicer
  end
end

class Film

  attr_accessor :film, :film_url

  def initialize(film)
    @film = film
    @film_url = film['Detail URL']
  end

  def film_details
    JSON.parse(RestClient.get(film_url))
  end

  def title
    film_title = film['Film']
    film_title.gsub(/(\[\w\])/, '').gsub(/\s\s/,'')
  end

  def budget
    film_details['Budget'] ? Budget.new(film_details['Budget']).reformat : 'Budget not available'
  end

  def winner?
    film['Winner'] == true
  end

end

class Budget
  attr_accessor :budget

  def initialize(budget)
    @budget = budget
  end

  def reformat
    until formatted?
      @budget = self.convert_millions if budget =~ /\bmillion\b/
      @budget = self.strip_footnotes if budget =~ /\D/
      # this reformatting ignores the difference between euros and USD; because this exchange rate has varied, it is programatically expensive to calculate the exact USD of a budget in euros for a given year
      #while it is inaccurate to assume a 1:1 exchange between the euro and the dollar, doing so allows the script to run without including a library of exchange rates or scraping a historical conversion tool online
    end
    @budget
  end

  def convert_millions
    strip_beginning_chars
    budget.match(/-/) ? budget_calc = average_from_range : budget_calc = budget
    match_data = budget_calc.match(/(\d)(?:\.)?(\d)?(\d)?(\d)?/) #this returns a MatchData object comprised of the full matched value and each matched group
    #this way, I can replace decimal places with digits by iterating through the values of the MatchData object
    digits = Array.new(7, 0)
    digits.map.with_index(1) do |num, index|
      match_data[index] ? digits[index - 1] = match_data[index].to_i : digits[index - 1] = 0
    end
    digits.join.to_i
  end

  def strip_footnotes
    budget.gsub(/(\[\s\d\s\])|\D|\W/, '').to_i
  end


  private
  def formatted?
    true if budget !~ /\D/
  end

  def strip_beginning_chars
    budget.gsub(/\b\d.*/, '')
  end

  def average_from_range
    match_data = budget.match(/(\d)-(\d)/) #select the beginning and end of the range
    avg = (match_data[1].to_f + match_data[2].to_f).to_f / 2 #in one case, the start of the budget range is a float
    avg.to_s
  end
end

class Result
  attr_accessor :results

  def initialize(results)
    @results = results
  end

  def average
    budgets = results.select{ |hash| hash[:budget].is_a?(Integer) }.map{|hash| hash[:budget]}
    avg = budgets.inject{ |sum, num| sum + num }.to_f / budgets.size
    format_budget(avg.round)
  end

  def print_results
    puts 'Year-Title-Budget'
    results.each do |hash|
      puts "#{hash[:year]}-#{hash[:title]}-#{format_budget(hash[:budget])}"
    end
  end

  private
  def format_budget(budget)
    "$#{budget.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}" #to make things more human-readable
  end
end
