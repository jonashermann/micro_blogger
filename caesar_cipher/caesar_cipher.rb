$num = (0..9).to_a
$m   = ('a'..'z').to_a
$M   = ('A'..'Z').to_a


def caesar_cipher(text, shift)
	puts "Encode  UP or DOWN?"
	puts "Enter 'U'or 'D'"
	bool = gets.chomp.to_s
	letter = text.split('')
	coded_letter = letter.map {|l| encode(l, shift, bool) }
    puts coded_letter.join
end

#encode method

def encode(char, shift, bool)
	if bool.upcase == 'D'
	    return encode_down(char, shift)
    elsif bool.upcase == 'U'
       	return encode_up(char, shift)
    else 
    	 return encode_up(char, shift)
    end 	 


end

def encode_down(char, shift)
	if $m.include? char
		i = $m.index char
		j = (i + shift) % 26
		return $m[j]
	elsif $M.include? char
	     i = $M.index char
	     j = (i + shift) % 26
	     return  $M[j]
	elsif (char.ord >=48 && char.ord <= 57)     	
         i = $num.index(char.to_i)
         j = (i + shift) % 10
         return $num[j].to_s
    else
     
        return char
    end         
end
def encode_up(char, shift)
	if $m.include? char
		i = $m.index char
		j = (i - shift).abs % 26
		return $m[j]
	elsif $M.include? char
	     i = $M.index char
	     j = (i - shift).abs % 26
	     return $M[j]
	elsif  (char.ord >= 48 && char.ord <= 57)
	      i = $num.index(char.to_i)
	      j = (i - shift).abs % 26
	      return $num[j]
	else
	      return char
	end                 	
end
caesar_cipher("this as great", 6)