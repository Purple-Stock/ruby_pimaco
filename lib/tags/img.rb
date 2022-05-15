class Img
  def initialize(content)
    @content = content
  end

  def set_width(width)
    @width = width
  end

  def setHeight(height)
    @height = height
    return self
  end

  def set_margin(margin)
    if margin.kind_of?(Array)
      margin = margin.join("mm ") + "mm"
    else
      margin = margin + "mm"
    end
    @margin = margin
    return self
  end

  def set_align(align)
    @align = align
    return self
  end

  def rotate(rotate)
    @rotate = rotate
  end

  def render
    styles = []

    if @width
      styles << "width: #{@width}mm"
    end

    if @height
      styles << "height: #{@height}mm"
    end

    if @align == 'left'
      styles << "float: left"
    else
      styles << "float: right"
    end

    if @margin
      styles << "margin: #{@margin}"
    end

    if styles.empty?
      style = ""
    else
      style = "style='#{styles.join(';')}'"
    end

    if @rotate
      rotate = " rotate='#{@rotate}'"
    else
      rotate = ""
    end

    "<img #{style} src='#{@content}'#{rotate}>"
  end

end
