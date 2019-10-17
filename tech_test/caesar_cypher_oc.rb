gem 'minitest'
require 'pry'
require 'minitest/autorun'

class CaesarCypher
  UPPERCASE_CHAR_CODES = ('A'.ord..'Z'.ord)
  LOWERCASE_CHAR_CODES = ('a'.ord..'z'.ord)

  def encrypt(text, key)
    return false unless key.is_a?(Numeric)

    key = key % 26
    array_of_chars = text.chars
    encrypted_array_of_chars = array_of_chars.map do |char|
      encrypt_char(char, key)
    end
    encrypted_array_of_chars.join
  end

  private

  def encrypt_char(char, key)
    return char unless char_alphabetic?(char)

    new_char_code = char.ord + key
    if UPPERCASE_CHAR_CODES.include?(char.ord)
      new_char_code += 26 if new_char_code < 'A'.ord
      new_char_code -= 26 if new_char_code > 'Z'.ord
    end
    if LOWERCASE_CHAR_CODES.include?(char.ord)
      new_char_code += 26 if new_char_code < 'a'.ord
      new_char_code -= 26 if new_char_code > 'z'.ord
    end
    new_char_code.chr
  end

  def char_alphabetic?(char)
    UPPERCASE_CHAR_CODES.include?(char.ord) || LOWERCASE_CHAR_CODES.include?(char.ord)
  end
end

class TestCypher < Minitest::Test
  def setup
    @encrypter = CaesarCypher.new
  end

  def test_provided_encryption_example
    assert_equal('krphiorz', @encrypter.encrypt('homeflow', 3))
  end

  def test_that_number_arguments_not_shifted
    assert_equal('123', @encrypter.encrypt('123', 1))
  end

  def test_that_punctuation_arguments_not_shifted
    assert_equal('!@£', @encrypter.encrypt('!@£', 1))
  end

  def test_that_method_handles_mix_of_alpha_and_non_alpha_characters
    assert_equal('d! e@ f£ g1 h2 i3', @encrypter.encrypt('a! b@ c£ d1 e2 f3', 3))
  end

  def test_that_method_handles_mix_of_upper_and_lower_case
    assert_equal('dEfGh', @encrypter.encrypt('aBcDe', 3))
  end

  def test_that_non_numeric_keys_return_false
    assert_equal(false, @encrypter.encrypt('abc', 'a'))
  end

  def test_that_negative_numbers_work_as_key
    assert_equal('xyz', @encrypter.encrypt('abc', -3))
  end

  def test_that_numbers_greater_than_26_work_as_key
    assert_equal('def', @encrypter.encrypt('abc', 679))
  end

  def test_that_encrypt_letter_method_is_private
    assert_raises(NoMethodError) { @encrypter.encrypt_letter('a', 3) }
  end

  def test_that_all_chars_valid_method_is_private
    assert_raises(NoMethodError) { @encrypter.all_chars_valid('abc') }
  end
end
