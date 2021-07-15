#stock_picker that takes in an array of stock prices, one for each hypothetical day.
# It should return a pair of days representing the best day to buy and the best day to sell.
#  Days start at 0.

def stock_picker(stock_prices)
  prices = stock_prices.dup
  result = []
  profit = 0
  while prices.size > 1
    min_p = prices.min
    index_of_min = prices.index(min_p)
    arr = prices[index_of_min..]
    max_p = arr.max
    if max_p - min_p > profit
      profit = max_p - min_p
      result.replace([stock_prices.index(min_p), stock_prices.index(max_p)])
    end
    prices = prices[0...index_of_min]
  end
  result
end

p (stock_picker([3, 2, 6, 25, 6, 26, 23, 4, 23, 15, 1, 6, 5]))
