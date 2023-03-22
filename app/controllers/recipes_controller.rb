class RecipesController < ApplicationController

    before_action :authorize
    def index
      recipes = Recipe.all
      render json: recipes, status: :created
    end

    def create
        user = User.find_by(id: session[:user_id])
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: :created
    end


    private
    def recipe_params
        params.permit(:title,:instructions,:minutes_to_complete)
    end 

    def authorize
        return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end
end
