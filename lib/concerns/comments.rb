# module BudgetFormatter
#   def budget_result(budget)
#     @budget = budget #a hacky way to pass the budget info without initializing the module
#     case budget
#     when budget =~ /\bmillion\b/
#       convert_millions
#     end
#   end
#
#   private
#
#
#   def convert_millions
#     if @budget =~ /\d\.\d*/
#       (@budget.match(/\.\d*/)[0].length) - 1
#     end
#   end
#     # general: if budget information contains the word 'million', append 000000
#     # if contains 'million' AND has a decimal, remove decimal and append 0's until there are 6 digits after main num
#     # if contains a range, average the first two numbers and add 0's
#
#   def convert_euros
#     # if contains euro symbol, convert to US
#   end
#
#   def as_integer
#     # strip any remaining characters
#     # convert to integer
#   end
#
#
#     # budget info looks like this
#     # US$ 2 million [ 4 ]
#     #
#     # $1.2 million [ 2 ]
#     # $1,433,000 [ 2 ]
#     # $750,000 [ 1 ]
#     # $1,180,280
#     # $325,000 [ 2 ]
#     # $1,950,000 [ 2 ]
#     # $2.183 million [ 3 ]
#     #
#     # US$1,644,736 (est.)
#     # $3.85 million
#     # $1,288,000 [ 1 ]
#     # $800,000 [ 1 ]
#     # $1.34 million [ 2 ]
#     # $878,000 [ 3 ]
#     #
#     # $1.25 million
#     # $2.1 million [ 1 ]
#     # $1,985,000 [ 1 ]
#     # £527,530 [ 1 ]
#     #
#     # $1.4 million [ 2 ] [ 3 ]
#     # $2,724,000 [ 1 ]
#     #
#     # $1,650,000
#     # $910,000
#     # $350,000 [ 1 ] [ 2 ]
#     # $6 million [ 1 ] [ 2 ]
#     # $2.8 million [ 2 ]
#     # $3,319,355 [ 2 ] [ 3 ]
#     # $15.2 million [ 3 ] [ 4 ]
#     # $3 million
#     # $6 million
#     # $15 million [ 3 ]
#     # $1 million or £467,000 [ 1 ]
#     # $17 million [ 1 ]
#     # $8.2 million [ 2 ] [ 3 ]
#     # $2 million
#     # $2 million [ 2 ]
#     # $10 million
#     # $3.2 million [ 1 ]
#     # $12.6 million [ 1 ]
#     # $1.8 million
#     # $6–7 million [ 1 ] [ 2 ]
#     # $5.5 million [ 1 ]
#     # $13 million [ 2 ] [ 3 ]
#     # $3 million [ 3 ]
#     # $1.1 million
#     # $4 million
#     # $15 million [ 2 ]
#     # $8 million [ 1 ]
#     # $6 million
#     # £3 million [ 1 ]
#     # $22 million [ 3 ]
#     # $8 million
#     # $18 million [ 2 ]
#     # $28 million [ 1 ]
#     # $6 million [ 2 ]
#     # $23.8 million [ 1 ]
#     # $25 million [ 1 ]
#     # $7.5 million [ 3 ]
#     # $22 million [ 2 ]
#     # $19 million [ 2 ]
#     # $14.4 million [ 2 ]
#     # $22 million [ 2 ]
#     # $55 million [ 1 ]
#     # $72 million [ 2 ]
#     # $27 million [ 2 ]
#     # $200 million [ 3 ] [ 4 ] [ 5 ]
#     # $25 million [ 2 ]
#     # $15 million [ 2 ]
#     # $103 million [ 6 ] [ 7 ]
#     # $58 million [ 1 ]
#     # $45 million [ 2 ]
#     # $94 million [ 5 ]
#     # $30 million [ 1 ] [ 2 ]
#     # $6.5 million [ 2 ]
#     # $90 million [ 1 ]
#     # $25 million
#     # $15 million [ 4 ]
#     # $15 million [ 1 ]
#     # $15 million [ 3 ]
#     # $15 million
#     # $44.5 million [ 2 ]
#     # $22 million [ 2 ]
#     # $16.5-18 million [ 2 ] [ 3 ]
# end
