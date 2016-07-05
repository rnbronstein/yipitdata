  #The challenge is to write a script to go the main API page, follow the “Detail URL” link for each year’s winner, grab the budget, and print out each Year-Title-Budget combination. After printing each combination, it should print the average budget of all the winners at the end.

require 'json'
require 'open-uri'

class Scraper
  attr_reader :data

  def initialize
    @data = JSON.parse(RestClient.get('oscars.yipitdata.com'))
  end

  def winner_hash
    hash = {}
    data['results'].each do |year_information|
      year_information['films'].collect do |film|
        winner_hash[year_information['year']] = film if winner?(film)
      end
    end
    hash
  end

  #visit page
  #each year has the following structure:
    # {year: [films: {url, film, producer, wiki, winner?}, film:...]}
    #for each year, iterate through array
    #visit detail url for each object if it has "winner" status
      # detail url looks like: {......."budget": 'budget'....}
  # iterate through all years to retrieve all information
  #create new hash: {year: {title: 'title', budget: 'budget'}, ...}
end

class Film
  attr_accessor :film, :film_url

  def initialize(film)
    @film = film
    @film_url = film['Detail Url']
  end

  def film_details
    JSON.parse(RestClient.get(film_url))
  end

  def winner?
    self['Winner'] == true
  end

  def budget
    if budget_information
      if budget_information =~ /\D/
        budget_information
      else
        reformat_budget
      end
    end
  end

  private

  def budget_information
    film_details['Budget']
  end

  def reformat_budget
    case budget_information
    when this
      that
    when this
      that
    end
  end

end

  # for each object in hash, print Year-Title-Budget

  #collect all budgets
  #return avg of collection
