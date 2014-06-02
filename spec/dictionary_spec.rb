require 'dictionary'

describe Dictionary do
  it "parses dictionary files" do
    dictfile  = <<DICT
{
  "word": {
    "definition": "a {collection} of {letters}",
    "url": "//example.com/word"
  },
  "letter": {
    "definition": "a character representing one or more of the sounds used in speech; any of the symbols of an alphabet",
    "url": "//example.com/letter"
  },
  "collection": {
    "definition": "a group of things or people",
    "url": "//example.com/collection"
  }
}
DICT

    dict = Dictionary.new(dictfile)
    actual = dict.definition("word")
    expected = {
      definition: "a collection of letters",
      see_also: [
        "//example.com/collection",
        "//example.com/letter"
      ]
    }

    expect(actual).to eq expected

  end
end