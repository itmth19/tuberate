module TubesHelper
  def tube_link_to(body, url, html_options = {})
    link_to body, "http://www.youtube.com/watch?v=#{url}", html_options
  end
end
