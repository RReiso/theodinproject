r = Range.new(0,100) # inclusive
r = Range.new(0,100,true) # 100 excluded
r = 1..100 # inclusive
r = 1...100 #100 excluded
p r.begin
p r.end
p r.exclude_end? # true
p r.cover?(50) # true
p r.cover?(4.7) # true