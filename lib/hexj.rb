require "hexj/version"

class String
  def escape!
    self.tr!("\x00-\x1f", ".")
  end
end

module Hexj
  def hexdump input
    result=Array.new
    input.codepoints.each_slice(4){|y| result << y.map{|x| "%02x" % x}.join(" ")}
    result.join("  ").ljust($width*3+($width-1)/4, " ")
  end

  def stringdump input
    input.escape!
    begin
      encoder=Encoding::Converter.new($encoding, Encoding::UTF_8)
    rescue Encoding::ConverterNotFoundError
      return ($encoding==Encoding::UTF_8) ? input : "."*$width
    end
    destination=""
    begin
      result=encoder.primitive_convert(input, destination)
      case result
      when :invalid_byte_sequence
        encoder.insert_output(".")
        encoder.insert_output(encoder.primitive_errinfo[3].dump[1..-2])
        redo
      when :defefined_conversion
        encoder.insert_output("."*encoder.primitive_errinfo[3].size)
        redo
      when :incomplete_input
        encoder.insert_output(".")
        encoder.insert_output(encoder.primitive_errinfo[3].dump[1..-2])
      when :finished
      else
        encoder.insert_output("."*encoder.primitive_errinfo[3].size)
        redo
      end
      break
    end while nil
    destination
  end
end
