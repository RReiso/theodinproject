def fibs(n)
  return [] if n == 0
  return [0] if n == 1

  first, second = result = [0, 1]
  (n - 2).times do
    acc = first + second
    result << acc
    first = second
    second = acc
  end
  result
end
p fibs(9)

def fibs_rec(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2

  fibs_rec(n - 1) << fibs_rec(n - 1)[-2] + fibs_rec(n - 1)[-1]
end
p fibs_rec(3) # [0, 1, 1, 2, 3, 5, 8, 13, 21]

