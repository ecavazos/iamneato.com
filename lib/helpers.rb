module Helpers
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

  def illustrations()
    path = path || File.dirname(File.expand_path(__FILE__)) + '/../public/images/illustrations'
    entries = []
    Dir.new(path).each do |f|
      next if f.start_with?('.')
      stat = File.stat(File.join(path, f))
      entries << {
        :name  => f,
        :mtime => stat.mtime
      }
    end
    entries
      .sort { |x,y| y[:mtime] <=> x[:mtime] }
      .map { |x| x[:name] }
  end
end
