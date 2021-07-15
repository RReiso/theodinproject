#Implement a caesar cipher that takes in a string and the shift factor
#and then outputs the modified string.

def caesar_cipher(string, shift_factor = 0)
  result = ''
  string.each_char do |char|
    # use cipher only if char is an uppercase or lowercase letter
    if char.ord.between?(65, 90) || char.ord.between?(97, 122)
      new_code = char.ord + shift_factor

      #ensure wrapping from Z to A or z to a
      new_code -= 26 if (new_code > 91 && char.ord < 91) || new_code > 122
      result += new_code.chr
    else
      result += char
    end
  end
  result
end

puts (caesar_cipher('What a string', 5))
