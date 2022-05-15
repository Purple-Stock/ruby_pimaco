class QrCode
  attr_accessor :content, :label, :label_font_size, :size, :padding, :margin, :align

  # QrCode constructor.
  # @param [String] content
  # @param [String] type_code
  def initialize(content, type_code = nil)
    @content = content
    @label = nil
    @label_font_size = 12
    @size = 100
    @padding = 0
    @margin = 0
    @align = 'left'
  end

  def initialize(size, label, labelFontSize)
    @size = size
    @label = label
    @labelFontSize = labelFontSize
  end

  def setSize(size)
    @size = size
    return self
  end

  def setLabel(label)
    @label = label
    return self
  end

  def setLabelFontSize(labelFontSize)
    @labelFontSize = labelFontSize
    return self
  end

  class Document
    def set_padding(padding)
      @padding = padding
      return self
    end

    def set_margin(margin)
      if margin.is_a?(Array)
        margin = margin.join('mm ') + 'mm'
      else
        margin = margin + 'mm'
      end
      @margin = margin
      return self
    end

    def set_align(align)
      @align = align
      return self
    end

    def br
      @br = "<br>"
    end
  end

  def render
      qrcode = QrCode.new
      qrcode.set_error_correction_level(QrCode::ErrorCorrectionLevel::HIGH)
      qrcode.set_encoding('UTF-8')
      qrcode.set_foreground_color(r: 0, g: 0, b: 0, a: 0)
      qrcode.set_background_color(r: 255, g: 255, b: 255, a: 0)
      qrcode.set_writer_by_name('png')
      qrcode.set_text(self.content)

      if self.br == nil
          if self.align == 'left'
              styles << "float: left"
          else
              styles << "float: right"
          end
      end

      if self.margin != nil
          styles << "margin: {$self.margin}"
      end

      if !empty(self.size)
          qrcode.set_size(self.size)
      end

      if !empty(self.label)
          qrcode.set_label(self.label)
      end

      if !empty(self.label_font_size)
          qrcode.set_label_font_size(self.label_font_size)
      end

      if !empty(self.padding)
          qrcode.set_padding(self.padding)
      end

      if !empty(styles)
          style = "style='".implode(";", styles)."'"
      else
          style = ""
      end

      return "<img ".$style." src='{$qrcode.write_data_uri()}'>".self.br
    end
end
