class Article

  attr_reader :path, :template

  def initialize(file_path)
    @path = file_path
    @template = File.read(file_path)
  end

  def slug
    File.basename(self.path, '.haml')
  end
  
  def id
    slug.gsub('_', '-')
  end

  def title
    template_variable('title')
  end

  def published
    @published ||= parse_date(template_variable('published'))
  end

  def updated
    @updated ||= parse_date(template_variable('updated'))
  end

  def last_modified
    updated || published
  end

  def template_variable(name)
    self.template[/\-\s*#\s*#{name}:\s*(.+)/, 1]
  end

  def parse_date(date_string)
    date_string && Time.local(*date_string.split('-').map {|s| s.to_i})
  end
  
  def <=>(other)
    [other.published.year, other.published.month, other.published.day] <=> [self.published.year, self.published.month, self.published.day]
  end
end
