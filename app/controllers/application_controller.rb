class ApplicationController < Sinatra::Base

  def recipes
    Recipe.all
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # READ
  get '/' do
  end

  get '/recipes' do
    erb :index
    # renders index erb
  end

  get '/recipes/new' do
    erb :new
    # GET request to load the form to create a new blog post
  end

  # CREATE

  post '/recipes' do
    @recipe = Recipe.create( name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time] )
     redirect to "/recipes/#{ @recipe.id }"
    # action responds to a POST request and creates a new post
      # based on the params from the form and saves it to the database
    # action redirects to the show page
  end

  # READ

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
    # controller action responds to a GET request to the route '/posts/:id'
    # route uses a dynamic URL can access the ID of the post
      # in the view through the params hash
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
    # action loads edit form in browser making GET request to recipes/:id/edit
    # action responds to a PATCH request to the route /recipes/:id
  end

  # UPDATE

  patch '/recipes/:id' do
    @recipe = Recipe.find( params[:id] )
    @recipe.update( name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time] )
    redirect "/recipes/#{ @recipe.id }"
    # finds recipe by id
    # update each attribute with param value
    # redirect to that recipe's page
  end

  # DELETE

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect to "/recipes"
    # form is submitted via a DELETE request to the route /recipes/:id/delete
    # action finds the blog post in the database based on the ID in the url parameters, and deletes it
    # redirects to the index page /recipes
  end

end
