require 'yaml'

language_characters_file = File.join(Rails.root, 'config', 'language_characters.yml')
$language_characters = YAML.load(File.open(language_characters_file))
