class Barcode
  attr_accessor :margin, :align
  attr_accessor :br

  def initialize(content, typeCode = nil)
    @content = content
    @typeCode = 'TYPE_CODE_128'

    if typeCode
      @typeCode = typeCode
    end

    @width = 2
    @height = 30
    @align = 'left'
  end

  def set_width(width)
    @width = width
    self
  end

  def set_height(height)
    @height = height
    self
  end

  def set_margin(margin)
    if margin.is_a?(Array)
      margin = margin.join('mm ') + 'mm'
    else
      margin = margin + 'mm'
    end
    @margin = margin
  end

  def set_align(align)
    @align = align
  end

  def br
    @br = "<br>"
  end

  def render
    if @align == 'left'
        $styles[] = "float: left"
    else
        $styles[] = "float: right"
    end

    if @margin !== nil
        $styles[] = "margin: {@margin}"
    end

    if !empty ($styles)
        $style = "style='".implode(";", $styles)."'"
    else
        $style = ""
    end

    $barcode = BarcodeGeneratorPNG.new

    case "TYPE_CODE_39"
      return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_CODE_39, @width, @height))."'>".$this->br

    case "TYPE_CODE_39_CHECKSUM"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_CODE_39_CHECKSUM, @width, @height))."'>".$this->br

    case "TYPE_CODE_39E"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_CODE_39E, @width, @height))."'>".$this->br

    case "TYPE_CODE_39E_CHECKSUM"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_CODE_39E_CHECKSUM, @width, @height))."'>".$this->br

    case "TYPE_CODE_93"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_CODE_93, @width, @height))."'>".$this->br

    case "TYPE_STANDARD_2_5"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_STANDARD_2_5, @width, @height))."'>".$this->br

    case "TYPE_STANDARD_2_5_CHECKSUM"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_STANDARD_2_5_CHECKSUM, @width, @height))."'>".$this->br

    case "TYPE_INTERLEAVED_2_5"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_INTERLEAVED_2_5, @width, @height))."'>".$this->br

    case "TYPE_INTERLEAVED_2_5_CHECKSUM"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_INTERLEAVED_2_5_CHECKSUM, @width, @height))."'>".$this->br

    case "TYPE_CODE_128"
        return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode(@content, Barcode1D::TYPE_CODE_128, @width, @height))."'>".$this->br
        case 'TYPE_CODE_128_A':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_CODE_128_A, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_CODE_128_B':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_CODE_128_B, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_CODE_128_C':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_CODE_128_C, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_EAN_2':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_EAN_2, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_EAN_5':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_EAN_5, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_EAN_8':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_EAN_8, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_EAN_13':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_EAN_13, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_UPC_A':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_UPC_A, $this->width, $this->height))."'>".$this->br;

      case 'TYPE_UPC_E':
          return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_UPC_E, $this->width, $this->height))."'>".$this->br;
          case 'TYPE_MSI':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_MSI, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_MSI_CHECKSUM':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_MSI_CHECKSUM, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_POSTNET':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_POSTNET, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_PLANET':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_PLANET, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_RMS4CC':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_RMS4CC, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_KIX':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_KIX, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_IMB':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_IMB, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_CODABAR':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_CODABAR, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_CODE_11':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_CODE_11, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_PHARMA_CODE':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_PHARMA_CODE, $this->width, $this->height))."'>".$this->br;

        case 'TYPE_PHARMA_CODE_TWO_TRACKS':
            return "<img ".$style." src='data:image/png;base64,".base64_encode($barcode->getBarcode($this->content, $barcode::TYPE_PHARMA_CODE_TWO_TRACKS, $this->width, $this->height))."'>".$this->br;

  end
end
