class P
  attr_accessor :size
  attr_accessor :bold

  def initialize(content)
    @content = content
    @bold = false
  end

  def setSize(size)
    @size = size
    return self
  end

  def b
    @bold = true
    return self
  end

  def size(size)
    @size = size
    self
  end

  def bold
    @bold = true
    self
  end

  def br
    @content << "<br>"
    self
  end

  def render
    tag = "span"
    style = []
    if @size
      style << "font-size: #{@size}mm"
    end
    if @bold
      style << "font-weight: bold"
    end

    if style.empty?
      content = "<#{tag}>#{@content}</#{tag}>"
    else
      content = "<#{tag} style='#{style.join(";")}'>#{@content}</#{tag}>"
    end
    content
  end
end
