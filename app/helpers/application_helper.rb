module ApplicationHelper
  def full_title(title='')
    baseTitle="DemoApp"
    if title.nil?
      baseTitle
    else
      "#{title} | #{baseTitle}"
    end
  end
end
