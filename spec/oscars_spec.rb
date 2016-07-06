require_relative '../config/environment'

describe 'OscarData' do
  let!(:oscar_data){OscarData.new}

  it 'retrieves a JSON object from the URL' do
    expect(oscar_data.data).to have_key('results')
  end

  it 'collects all Oscar winners' do
    expect(oscar_data.results.first).to eq({:year=>"1927 / 28 (1st)", :title=>"Wings", :budget=>2000000})
  end

end

describe 'Budget' do
  let!(:budget){Budget.new('$3.85 million')}
  let!(:budget_2){Budget.new('$900,000')}
  let!(:budget_3){Budget.new('$6-7 million')}
  let!(:budget_4){Budget.new('$3,319,355 [ 2 ] [ 3 ]')}
  let!(:budget_5){Budget.new('£3 million [ 1 ]')}

  it 'can convert a string containing "million" into an integer' do
    budget.reformat
    expect(budget.budget).to eq(3850000)
  end

  it 'can convert a string to an integer if there are no operations to perform' do
    budget_2.reformat
    expect(budget_2.budget).to eq(900000)
  end

  it 'can create an average budget if a range of values is given' do
    budget_3.reformat
    expect(budget_3.budget).to eq(6500000)
  end

  it 'can remove footnotes' do
    budget_4.reformat
    expect(budget_4.budget).to eq(3319355)
  end

  it 'properly formats a budget in euros' do
    budget_5.reformat
    expect(budget_5.budget).to eq(3000000)
  end
end

describe 'Results' do
  let!(:data){OscarData.new.results}
  let!(:result){Result.new(data)}

  it 'calculates the average budget' do
    expect(result.average).to eq('$2,913,023') #this is a bit of a silly test as I got this information from my own calculations
  end

end
