require 'json'
require 'pp'

class Dictionary

  def initialize(file)
    @definition_list = JSON.parse(file)
  end

  def definition(entry)
    format_entry(entry)
  end

  private

  def format_entry(entry)
    entry_definition = {}
    parsed_definition = parse_definition(@definition_list[entry]["definition"])
    entry_definition[:definition] = parsed_definition[:definition]
    entry_definition[:see_also] = parsed_definition[:see_also].map do |word|
      @definition_list[word]["url"]
    end
    entry_definition
  end

  def parse_definition(the_definition)
    definition_hash = {}
    definition_hash[:see_also] = the_definition.scan(/\{.*?\}/).map do |word|
      stripped_word = word.gsub("{","").gsub("}","")
      if stripped_word[-1] == "s"
        stripped_word = stripped_word[0..-2]
      end
      stripped_word
    end
    definition_hash[:definition] = the_definition.gsub("{","").gsub("}","")
    pp definition_hash
  end

end