require "sinatra"
require "pg"
require "pry" if development? || test?
require "sinatra/reloader" if development?
require_relative "./app/models/article"

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app", "views")

configure :development do
  set :db_config, { dbname: "news_aggregator_development" }
end

configure :test do
  set :db_config, { dbname: "news_aggregator_test" }
end

def db_connection
  begin
    connection = PG.connect(Sinatra::Application.db_config)
    yield(connection)
  ensure
    connection.close
  end
end

get "/" do
  redirect "/articles"
end

get "/articles" do
  @articles = Article.all
  erb :index
end

get "/articles/new" do
  erb :new
end

get "/new" do
  redirect "/articles/new"
end

post "/articles" do
  @title = params["title"]
  @description = params["description"]
  @url = params["url"]

  if @title != "" && @description != "" && @description.length > 20 && @url != "" && @url.include?("http")
    @articles = Article.create(@title, @description, @url)
    redirect "/articles"
  else
    @errors = "Error!<br>"

    if @title.strip == ""
      @errors += "Please provide a title.<br><br>"
    end

    if @description.strip == "" || @description.length < 20
      @errors += "Please provide a description longer than 20 characters.<br><br>"
    end

    if @url.strip == "" || !@url.include?("http")
      @errors += "Please provide a valid URL, including 'http.'<br><br>"
    end
  end
  erb :new
end

get "/articles/:id" do
  @article = Article.find(params["id"])
  erb :show
end
