require_relative '../config/environment'

describe 'Scraper' do
  let!(:scraper){Scraper.new}

  it 'retrieves a JSON object from the URL' do
    expect(scraper.data).to have_key('results')
  end

  it 'collects all Oscar winners' do
    expect(scraper.winner_hash).to have_key("1927 / 28 [A]  (1st)")
  end
end

describe 'Film' do
  let!(:film_1){Film.new}

  let!(:film_2){Film.new({
    "Detail URL": "http://oscars.yipitdata.com/films/You_Can%2527t_Take_It_With_You_(film)",
    "Film": "You Can't Take It With You",
    "Producer(s)": "Frank Capra",
    "Production Company(s)": "Columbia",
    "Wiki URL": "http://en.wikipedia.org/wiki/You_Can%27t_Take_It_With_You_(film)",
    "Winner": true
  })}

  let!(:film_3){Film.new()}
  it 'retrieves details for a given film' do
    expect(film_1.film_details).to have_value()
  end

  describe '#budget' do
    it 'finds the budget information for a given film' do
      expect(film_1.budget).to eq('')
    end

    it 'properly formats the budget information when given non-numeric characters' do
      expect(film_2.budget).to eq(1644736)
    end

    it 'properly formats the budget information when budget is given in millions' do
      expect(film_3.budget).to eq()
    end

    it 'returns nil for movies without budget information' do
      expect(film_4.budget).to be_falsy
    end
    
  end


end
