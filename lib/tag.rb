class Tag
  def initialize(content = nil)
    @tags = []

    if content != nil
      p = P.new(content)
      @tags << p
    end
  end

  def loadConfig(template, path)
    json = File.read(path + template)
    std = JSON.parse(json)

    @width = std['tag']['width']
    @height = std['tag']['height']
    @margin_left = std['tag']['margin-left']

    if @border.nil?
      @border = std['tag']['border']
    end

    if @padding.nil?
      @padding = 0
    end

    if std['tag'].key?('ln')
      @ln = std['tag']['ln']
    end

    if std['tag'].key?('align')
      @align = std['tag']['align']
    end
  end

  def set_size(size)
    @size = size
    self
  end

  def set_padding(padding)
    @padding = padding
  end

  def set_border(border)
    @border = border
    return self
  end

  def add_p(p)
    @tags << p
    p
  end

  def p(content)
    p = P.new(content)
    @tags << p
    p
  end

  def add_barcode(barcode)
    @tags << barcode
    barcode
  end

  def barcode(content, typeCode = nil)
    barcode = Barcode.new(content, typeCode)
    append(barcode)
    barcode
  end

  def qrcode(content, label = nil, font_size = nil)
    qrcode = QrCode.new(content)

    if label
        qrcode.label = label
    end

    if font_size
        qrcode.label_font_size = font_size
    end

    @tags << qrcode
    qrcode
  end

  def img(content)
    img = Img.new(content)
    @tags.append(img)
    return img
  end

  def getTags
    @tags.getArrayCopy
  end
end

class Tag
  attr_accessor :content

  def initialize(content = "")
    @content = content
  end

  def render
    return @content
  end
end

class Header < Tag
  def initialize(text, level)
    @content = "<h#{level}>#{text}</h#{level}>"
  end
end

class Paragraph < Tag
  def initialize(text)
    @content = "<p>#{text}</p>"
  end
end

class Image < Tag
  def initialize(source, width, height)
    @content = "<img src='#{source}' width='#{width}' height='#{height}' />"
  end
end

class Table < Tag
  def initialize(rows)
    @content = "<table>"
    rows.each do |row|
      @content += "<tr>"
      row.each do |cell|
        @content += "<td>#{cell}</td>"
      end
      @content += "</tr>"
    end
    @content += "</table>"
  end
end

class Document
  attr_accessor :tags

  def initialize
    @tags = []
  end

  def render
    @tags.each do |tag|
      puts tag.render
    end
  end

  def add_tag(tag)
    @tags.push(tag)
  end
end

document = Document.new

document.add_tag(Header.new("Greetings!", 1))
document.add_tag(Paragraph.new("Hello Ruby world!"))
document.add_tag(Image.new("ruby.png", 100, 100))

rows = []
rows.push([Paragraph.new("First cell"), Paragraph.new("Second cell")])
rows.push([Paragraph.new("Third cell"), Paragraph.new("Fourth cell")])

document.add_tag(Table.new(rows))

document.render
THIS RESULT IS...


Incorrect

Unhelpful
