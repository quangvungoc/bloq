module ApplicationHelper
  @@max_length = 560

  def need_truncate?(content) 
    content.length > @@max_length ? true : false
  end

  def truncate(content)
    if need_truncate?(content)
      content[0..@@max_length-20] << "..."
    else
      content
    end
  end
end
