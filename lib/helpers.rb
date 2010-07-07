helpers do
  def article_body(article)
    haml(article.template, :layout => false)
  end

  def article_path(article)
    "/#{article.published.strftime("%Y/%m/%d")}/#{article.id}"
  end
  
  def date(article)
    article.published.strftime("%Y/%m/%d")
  end
  
  def absoluteify_links(html)
    host = 'http://www.iamneato.com'
    path = "\\1#{host}\\2\\3"
    
    html.
      gsub(/href=(["'])(\/.*?)(["'])/, "href=#{path}").
      gsub(/src=(["'])(\/.*?)(["'])/, "src=#{path}")
  end
  
  def page_title(title)
    return "iamneato.com" if title.nil?
    "#{title} - iamneato.com"
  end
end
