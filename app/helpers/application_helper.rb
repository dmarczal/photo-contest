module ApplicationHelper

# Returns the full title on a per-page basis.
def full_title(page_title = '')
	base_title = "PhotoContest"
	if page_title.empty?
		base_title
	else
		page_title + " | " + base_title
	end
end

def link_to_login()
	user_signed_in? ? link_to('Logout', destroy_user_session_path, :method => :delete) : link_to('Login', new_user_session_path)
end

def link_to_sign_up()
	link_to('Register', new_user_registration_path) unless user_signed_in?
end

  # Returns the Gravatar for the given user.
  def contest_status_label(contest)
    if contest.closed?
    	"Votação Encerrada"
    elsif contest.open?
    	"<span class='label label-success'>Votação Aberta</span>".html_safe
    end
  end


end
