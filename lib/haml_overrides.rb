module Haml::Filters::Preserve
  def render(text)
    Haml::Helpers.preserve(Haml::Helpers.html_escape(text))
  end
end

module Haml::Filters::Textile
  include Haml::Filters::Base
  
  def render(text)
    t = ::RedCloth.new(text)
    t.hard_breaks = false
    t.to_html(:textile)
  end
end