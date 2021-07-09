def reverse(x) #100ms, 210mb
  int_str = x.to_s
  res_str=String.new
  if int_str[0]=='-'
    res_str<<int_str[0]
    int_str.slice!(0)
  end
  i=int_str.size-1
  int_str.size.times do
    res_str<<int_str[i]
    i-=1
  end
  res = res_str.to_i
  if res.between?(-2**31,2**31-1)
    res
  else
    0
  end
end
reverse(

1563847412)