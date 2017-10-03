# Wrap a String into lines such that each line’s length does not exceed
# line_length.
# Limitation: If a line contains more than line_length characters without any
# whitespace, the line will not be modified and its length will exceed
# line_length after all.
Puppet::Functions.create_function(:word_wrap) do
  dispatch :word_wrap do
    param          'String',  :text
    optional_param 'Numeric', :line_length
    return_type 'String'
  end

  def word_wrap(text, line_length=80)
    result = ''
    text.each_line do |line|
      # remove trailing linebreak
      chomped = line.chomp!
      wrapped_line = ''
      space_left = line_length
      # split line on spaces
      line.each_line(' ') do |word|
        if word.length <= space_left
          wrapped_line += word
          space_left -= word.length
        else
          result += wrapped_line + "\n"
          wrapped_line = word
          space_left = line_length - word.length
        end
      end
      # append the remaining words that didn’t fill a whole line
      result += wrapped_line
      # put linebreak back if it was removed
      result += "\n" if chomped
    end
    return result
  end

end

