def generate_table(alphabet, first_in_last = false)
  map = []
  head = alphabet[i...alphabet.size]
  tail = alphabet[0...i]
  (0...alphabet.size).each { |i| map << head + tail }
  map << map.shift if first_in_last
  map
end

def generate_table_with_key(alphabet, secret_key)
  map = []
  
  secret_key.each do |i|
    index = alphabet.index(i)
    raise "Symbol '#{i}' in key must be in alphabet" if index.nil?
    map << alphabet[index...alphabet.size] + alphabet[0...index]
  end

  map
end

def print_like_table(symbol_table)
  symbol_table.map { |row| row.join(',') }.join("\n")
end

def vigenere_encrypt(plaintext, alphabet, secret_key, options = {})
  cyphertext = []
  
  plaintext = plaintext - options[:ignore] if options[:ignore]==true
  map = generate_table_with_key(alphabet,secret_key)
  
  (0...plaintext.size).each do |plain_idx|
    alp_idx = alphabet.index(plaintext[plain_idx])
    map_col = alp_idx % alphabet.size
    map_row = plain_idx % secret_key.size
    cyphertext << map[map_row][map_col]
  end
  
  cyphertext
 end

def vigenere_decrypt(cyphertext, alphabet, secret_key, options = {})
  plaintext = []
  
  cyphertext = cyphertext - options[:ignore] if options[:ignore]==true
  map = generate_table_with_key(alphabet,secret_key)
  
  (0...cyphertext.size).each do |cypher_idx|
    map_row = cypher_idx % secret_key.size
    col = map[map_row].index(cyphertext[cypher_idx])
    plaintext << alphabet[col]
  end
  
  plaintext
 end

## Generate alphabet
alphabet = ('a'..'f').to_a

## Insert symbols
# alphabet.insert(3,'ch')
# alphabet.insert(13,'ll')
# alphabet.insert(20,'rr')

## Make secret key like array
secret_key = ['b','e','d']

## Specify plain text
plaintext = ['b','e','b','a']

## Print plain text
puts "Plaintext => #{plaintext.join(',')}"

## Test Vigenere encrypt
cyphertext = vigenere_encrypt(plaintext, alphabet, secret_key, options = {})

## Print cypher text
puts "Cyphertext => #{cyphertext.join(',')}"

## Test Vigenere decrypt
plaintext = vigenere_decrypt(cyphertext, alphabet, secret_key, options = {})

## Print plain text
puts "Plaintext => #{plaintext.join(',')}"
