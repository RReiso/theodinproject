def reverse(x) 
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
reverse(1563847412)

def reverse2(x) - fastest
  res = []
  i = 1
  if x < 0
    res<<"-"
    x*= -1
  end
  begin
    num = x.remainder(i*10)
    num = num/i
    res << num
    i*=10
  end until x/i==0
  res = res.join.to_i
  
  if res.between?(-2**31,2**31-1)
    res
  else
    0
  end
end
reverse2(-1563847412)

def reverse3(x)
  res = 0
  if x<0
    x=x.abs 
    neg = true
  end
  until x==0
    res = res * 10 + x.remainder(10);
    x = x / 10;
  end
    res = res * (-1) if neg
  if res.between?(-2**31,2**31-1)
    res
  else
    0
  end
end
reverse3(1563847412)