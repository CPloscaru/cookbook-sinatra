require "csv"
require_relative "recipe"
# TODO: Implement the Cookbook class that will be our repository
class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def mark_recipe_as_done(index)
    @recipes[index].mark_as_done
  end

  def create(recipe)
    @recipes << recipe
    save_csv
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      recipe = Recipe.new(row[1], row[2], row[3], row[4])
      create(recipe)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each_with_index { |r, i| csv << [i + 1, r.name, r.description, r.rating] }
    end
  end
end
