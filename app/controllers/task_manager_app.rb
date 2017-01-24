require_relative '../models/task.rb'

class TaskManagerApp < Sinatra::Base #gives functionality(Sinatra::Base)
  set :root, File.expand_path("..", __dir__) #base level of application. Root is the app folder, this is the base.(set :root)

  get '/' do
    erb :dashboard  # render's the template
  end
  
  get '/tasks' do
    @tasks = Task.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end

  get '/tasks/:id' do #':'means that it can be a dynamic value that comes through. 
    @task = Task.find(params[:id])
    erb :show
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    erb :edit
  end

  delete '/tasks/:id' do |id|
    Task.destroy(id.to_i)
    redirect '/tasks'
  end

end

#looks for routes sequentially, from top to bottom.



##Define CRUD
# CRUD stands for Create, Read, Update, Delete. The basis of it is a functional app.

##Why do we use set method_override:true?
  #We use  the set method_override:true? because HTML wont allow us to use the method='put' in our form tag, therefore we need to bypass it as a hidden value. That way it gives our controller the information it needs to route the request correctly.


##Explain the difference between value and name in this line: <input type='text' name='task[title]' value="<%=@task.title%>"/>
#name is what assigns what is entered in this section while value is what stores it. 

##What are params?Where do they come from?
 #params come from the user's browser when they make requests. They are key value pairs where params is a hash with hashes inside.

##Check out your routes.Why do we need two routes each for creating a new Task and editing an existing Tasks.
#We need a route to grab the task and a route to display the final output of that task.
