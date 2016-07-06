  #The challenge is to write a script to go the main API page, follow the “Detail URL” link for each year’s winner, grab the budget, and print out each Year-Title-Budget combination. After printing each combination, it should print the average budget of all the winners at the end.


    #visit page
    #each year has the following structure:
      # {year: [films: {url, film, producer, wiki, winner?}, film:...]}
      #for each year, iterate through array
      #visit detail url for each object if it has "winner" status
        # detail url looks like: {......."budget": 'budget'....}
    # iterate through all years to retrieve all information
    #create new hash: {year: {title: 'title', budget: 'budget'}, ...}
    # for each object in hash, print Year-Title-Budget

    #collect all budgets
    #return avg of collection

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
        film_obj = Film.new(film)
        hash[year_information['year']] = film if film_obj.winner?
        # hash[year_information['year']] = film if winner?(film)
      end
    end
    hash
  end

  #I wrote this method to get a better look at how the budgets were formatted (also to test budget retrieval in my specs)
  # def all_budgets
  #   budgets = []
  #   winner_hash.each do |year, info|
  #     url = info['Detail URL']
  #     winner_detail = JSON.parse(RestClient.get(url))
  #     budgets << winner_detail['Budget'] if winner_detail['Budget']
  #   end
  #   puts budgets
  #   budgets
  # end

  # private
  # def winner?(film)
  #   film['Winner'] == true
  # end

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

  def convert_millions
    @budget = film_details['Budget']
    match_data = @budget.match(/(?:\$)(?<first>\d)(?:\.)?(?<second>\d)?(?<third>\d)?/)
    digits = Array.new(6, 0)
    digits.map.with_index(1) do |num, index|
      match_data[index] ? digits[index - 1] = match_data[index].to_i : digits[index - 1] = 0
    end
    digits.join.to_i
  end

  def winner?
    film['Winner'] == true
  end


end
