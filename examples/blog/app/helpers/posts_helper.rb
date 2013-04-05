module PostsHelper
  def show_links_for(post)
    html = [link_to('Show', post)]

    if session[:username]
      html << " "+link_to('Edit', edit_post_path(post))
      html << " "+link_to('Destroy', post, method: :delete, data: { confirm: 'Are you sure?' })
    end

    html.join(" ").html_safe
  end
end
