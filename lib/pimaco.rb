require 'rubygems'
require 'mimpdf'

class Pimaco
  attr_reader :pdf

  def initialize(template, path_template = nil, tempDir = nil)
    @path_template = File.expand_path("../../templates/", __FILE__)
    @file_template = template + ".json"
    loadConfig

    @tags = Array.new

    config = {
      :format => [@width, @height],
      :default_font_size => @fontSize,
      :margin_left => @marginLeft,
      :margin_right => @marginRight,
      :margin_top => @marginTop,
      :margin_bottom => @marginBottom,
      :margin_header => @marginHeader,
      :margin_footer => @marginFooter
    }

    if !tempDir.nil?
      config[:tempDir] = tempDir
    end

    begin
      @pdf = Mpdf.new(config)
    rescue Exception => e
      raise e
    end
  end

  def load_config
    if !File.exist?("#{path_template}#{file_template}")
      raise "template not found"
    end
    json = File.read("#{path_template}#{file_template}")
    std = JSON.parse(json)

    @width = std["page"]["size"][0]
    @height = std["page"]["size"][1]
    @font_size = std["page"]["font-size"]
    @orientation = std["page"]["orientation"]
    @columns = std["page"]["columns"]
    @unit = std["page"]["unit"]
    @margin_top = std["page"]["margin-top"]
    @margin_left = std["page"]["margin-left"]
    @margin_right = std["page"]["margin-right"]
    @margin_bottom = std["page"]["margin-bottom"]
    @margin_header = std["page"]["margin-header"]
    @margin_footer = std["page"]["margin-footer"]
  end

  def addTag(tag)
    tag.loadConfig(@file_template, @path_template)

    new = @tags.count + 1
    cols = @columns
    rows = (new / cols.to_f).ceil

    if new%cols == 0
      sideCol = "right"
      margin = false
    elsif new == (rows * cols - (cols - 1))
      sideCol = "left"
      margin = false
    else
      sideCol = "left"
      margin = true
    end

    @tags.append(tag.render(sideCol, margin))
  end

  def addTagBlank
    tag = Tag.new('')
    addTag(tag)
  end

  def getTags
      return @tags.to_a
  end

  def jump(jump)
      jump.times do
          addTagBlank
      end
  end

  def render
    @content = ""
    rows = (tags.count / @columns).ceil
    blank = @columns * rows - tags.count
    (blank).times { @content += blank_tag }

    tags.each_with_index do |tag, col|
      @content += tag
      col += 1
      break if col > tags.count
    end
    @content
  end

  def output(name = nil, dest = nil)
    @pdf.write_html(render)
    @pdf.output(name, dest)
  end
end
