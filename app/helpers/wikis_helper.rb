module WikisHelper
  def public_private
    if @wiki.private?
      content_tag :span, 'Private', class: 'badge glyphicon glyphicon-lock'
    else
      content_tag :span, 'Public', class: 'badge glyphicon glyphicon-pencil'
    end
  end
end
