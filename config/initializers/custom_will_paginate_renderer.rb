# config/initializers/custom_will_paginate_renderer.rb

require 'will_paginate/view_helpers/action_view'

class CustomLinkRenderer < WillPaginate::ActionView::LinkRenderer
  protected

  def page_number(page)
    if page == current_page
      tag(:li, link(page, page, class: 'btn btn-secondary active'), class: 'page-item active')
    else
      tag(:li, link(page, page, class: 'btn btn-secondary'), class: 'page-item')
    end
  end

  def gap
    tag(:li, link('...', 'no more pages', class: 'btn btn-secondary'), class: 'page-item disabled')
  end

  def previous_or_next_page(page, text, classname)
    if page
      tag(:li, link(text, page, class: 'btn btn-secondary'), class: 'page-item')
    else
      tag(:li, link(text, 'no more pages', class: 'btn btn-secondary'), class: 'page-item disabled')
    end
  end

  def html_container(html)
    tag(:ul, html, class: 'pagination justify-content-center')
  end
end
