require 'formtastic'

module Formtastic


class OnCompareFormBuilder < Formtastic::SemanticFormBuilder

  def slider_input(method, options = {})
    collection   = find_collection_for_column(method, options)
    html_options = strip_formtastic_options(options).merge(options.delete(:input_html) || {})

    input_id = generate_html_id(method,'')
    slider_id = "#{input_id}_slider"
    label_id = "#{input_id}_label"
    value_items = []
    label_items = []

    collection.each do |c|
      label_items << (c.is_a?(Array) ? c.first : c)
      value = c.is_a?(Array) ? c.last  : c
      value_items << value
    end

    label_options = options_for_label(options).merge(:input_name => input_id)
    label_options[:for] ||= html_options[:id]

    script_content = "$(function() {
        var option_values = [#{value_items.map {|v|"'#{v.to_s.gsub(/[']/, '\\\\\'')}'"}.join(',')}]
        var option_labels = [#{label_items.map {|l|"'#{l.to_s.gsub(/[']/, '\\\\\'')}'"}.join(',')}]
        $( '##{slider_id}' ).slider({
            value:100,
            min: 0,
            max: #{collection.count - 1},
            step: 1,
            slide: function( event, ui ) {
                $( '##{input_id}' ).val(
                        option_values[ui.value] );
                $( '##{label_id}' ).text(
                        option_labels[ui.value] );
            }
        });
        for(var i = 0; i < option_values.length; i++) {
          if(option_values[i] == $( '##{input_id}' ).val()) $( '##{slider_id}' ).slider( 'value', i )
        }
        $( '##{label_id}' ).text( option_labels[$( '##{slider_id}' ).slider( 'value' )] );
    });"

    label(method, label_options) <<
    template.content_tag(:script, Formtastic::Util.html_safe(script_content), :type => 'text/javascript') <<
    template.content_tag(:div,
        template.content_tag(:div, label_items[label_items.count - 1], :class => 'right-label') <<
        template.content_tag(:div, label_items[0], :class => 'left-label') <<
        template.content_tag(:div, nil, html_options.merge(:id => slider_id)), :class => 'slider-holder') <<
      hidden_input(method, options.delete(:as)
    ) <<
    template.content_tag(:span, nil, :id => label_id)
  end

end
end
#Formtastic::SemanticFormHelper.builder = ::Formtastic::OnCompareFormBuilder



