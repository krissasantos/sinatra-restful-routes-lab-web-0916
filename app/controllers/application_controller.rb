class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to('/recipes/new')
  end

   get '/recipes/new' do 
    erb :new
  end 


  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end  


  get '/recipes' do
    @recipes = Recipe.all #iterate through this in the index page
    erb :'index'
  end


  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :'show'
  end

  #edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :'edit'
  end


  patch '/recipes/:id' do
      @recipe = Recipe.find_by_id(params[:id])
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.cook_time = params[:cook_time]
      @recipe.save
      redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do 
    @recipe = Recipe.all.find(params[:id])
    @recipe.delete 
    redirect to '/recipes'
  end 
 

end