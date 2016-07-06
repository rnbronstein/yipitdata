module BudgetFormatter

  # perform each operation until budget is comprised of only digit characters
  def reformat_budget(budget)
    @budget = budget #a rather hacky way to pass in an instance variable without initializing a module
    while unformatted?
      convert_millions if @budget =~ /\bmillion\b/
      convert_euros if @budget =~ //
      strip_extra_characters if @budget =~ //
    end
  end

  # (?:\$)(?<amount>\d)(?:\.)(?<digits>[0-9])?.(?<value>\b\million)

  def convert_millions
    handle_budget_ranges if @budget =~ /-\d/
    match_data = @budget.match(/(?:\$)(?<first>\d)(?:\.)?(?<second>\d)?(?<third>\d)?/)
    digits = Array.new(6, 0)
    digits.map.with_index(1) do |num, index|
      match_data[index] ? num = match_data[index] : num = 0
      binding.pry
    end
    binding.pry
    digits
  end

  def convert_euros
  end

  def strip_extra_characters
  end

  private

  def unformatted?
    @budget =~ /\D/
  end

  def handle_budget_ranges

  end

end
