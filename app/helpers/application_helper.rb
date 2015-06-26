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

# Redirects to stored location (or to the default).
def redirect_back_or(default)
  redirect_to(session[:forwarding_url] || default)
  session.delete(:forwarding_url)
end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def format_date_old (date)
   from_time = Time.zone.now
   distance_of_time_in_words(from_time, date) 
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
    elsif contest.open_enrollment?
     "<span class='label label-info'>Inscrições Abertas</span>".html_safe
   elsif contest.idle?
     "<span class='label label-default'>Votação inicia em #{format_date_old(contest.opening)}</span>".html_safe
   elsif contest.waiting?
    "<span class='label label-default'>Inscrições iniciam em #{format_date_old(contest.opening_enrollment)}</span>".html_safe
  end
end

# show link to register in any contest if it is enrollment open
def contest_link_register(contest)
    (contest.open_enrollment?) ? link_to('Inscrever-me', new_inscription_path(contest.id)) : ''
end

# show approved label status 
def inscription_approved_label(inscription)
    (inscription.approved?) ? '<span class="label label-success">Inscrição Aprovada</span>'.html_safe : '<span class="label label-warning">Aguardando aprovação da inscrição</span>'.html_safe 
end


end
