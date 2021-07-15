def word_pattern(pattern, s)
  pattern_hash = Hash.new

  words = s.split(' ')
  return false if words.size != pattern.size
  pattern.each_char.with_index do |c, i|
    if !pattern_hash[c] && !pattern_hash.has_value?(words[i])
      pattern_hash[c] = words[i]
    elsif pattern_hash[c] != words[i]
      return false
    end
  end
  return true
end

p word_pattern('aaa', 'aa aa aa aa')
