class HorizontalRadioInput < Formtastic::Inputs::RadioInput
  def choices_wrapping_html_options
    super.merge("data-type" => "horizontal")
  end
end
d
 
