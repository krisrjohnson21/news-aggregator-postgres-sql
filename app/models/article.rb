class Article
  attr_accessor :id, :title, :description, :url

  def initialize(title, description, url)
    @id = id
    @title = title
    @description = description
    @url = url
  end

  def self.all
    sql_articles = nil

    db_connection do |connection_helper|
      sql_articles = connection_helper.exec("SELECT * FROM articles;")
    end

    article_hashes = sql_articles.to_a
    articles = []
    article_hashes.each do |article|
      articles << Article.new(article["title"], article["description"], article["url"])
    end

    return articles
  end

  def self.create(title, description, url)
    db_connection do |conn|
      @articles = conn.exec_params("INSERT INTO articles(title, description, url) VALUES ($1, $2, $3)", [title, description, url])
    end
  end

  def self.find(id)
    article_result = db_connection do |conn|
      conn.exec("SELECT title, description, url FROM articles WHERE id=#{id}")
    end

    @article = Article.new(
      article_result.to_a[0]["title"],
      article_result.to_a[0]["description"],
      article_result.to_a[0]["url"]
    )
  end
end
