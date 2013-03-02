class Recipe
  attr_accessor :name, :ingredients, :instructions
  
  def initialize(name, recipe_content)
    self.name = name
    self.ingredients = []
    self.instructions = []
    instance_eval recipe_content
  end

  def ingredient(name, options = {})
    ingredient = name
    ingredient << " (#{options[:amount]})" if options[:amount]
    ingredients << ingredient
  end

  def step(text, options = {})
    instruction = text
    instruction << " (#{options[:for]})" if options[:for]
    instructions << instruction
  end
end
file = File.open(ARGV[0], "rb")
contents = file.read
recipe = Recipe.new ARGV[0], contents
p recipe