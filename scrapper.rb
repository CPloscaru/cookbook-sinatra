require "open-uri"
require "nokogiri"

class Scrapper
  def initialize(ingredient)
    @url = "https://www.allrecipes.com/search?q=#{ingredient}]"
  end

  def parse_web_for_recipe
    html_file = URI.open(@url)
    html_parse = Nokogiri::HTML.parse(html_file)
    recommandations = get_first_five_recommandations(html_parse)
    ratings = get_first_five_ratings(html_parse)
    parsed_informations = []
    recommandations.each_with_index do |r, i |
      parsed_informations << {text: r, rating: ratings[i]}
    end
    parsed_informations
  end

  private

  def get_first_five_ratings(html_parse)
    ratings = []
    html_parse.search(".comp.mntl-recipe-star-rating.mm-recipes-star-rating").first(5).each do |e|
      rating = e.search("use").reduce(0) do |r, use|
        if use["href"] == "#icon-star"
          r + 1
        elsif use["href"] == "#icon-star-half"
           r + 0.5
        end
      end
      ratings << rating
    end
    return ratings
  end

  def get_first_five_recommandations(html_parse)
    recommandations = []
    html_parse.search(".card__title-text").first(5).each { |e| recommandations << e.text}
    recommandations
  end
end
