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

  def format_date (date)
    date.strftime("%d/%m/%Y %H:%M")
  end


  def link_to_login()
    user_signed_in? ? link_to('Logout', destroy_user_session_path, :method => :delete) : link_to('Login', new_user_session_path)
  end

  def link_to_sign_up()
    link_to('Register', new_user_registration_path) unless user_signed_in? 
  end

  def link_to_show_inscriptions()
    link_to('Minhas Inscrições', participants_path) if user_signed_in? && !current_user.admin?
  end

  def link_to_show_inscription(participant_id)
    link_to('Veja mais detalhes sobre sua inscrição', participant_path(participant_id))
  end

  def link_to_edit_inscription(participant)
    (participant.between_deadline?) ? link_to('Enviar nova foto/Atualizar Inscrição', edit_participant_path(participant.id)) : ''
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

  def markdown(text)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    renderer.render(text).html_safe
  end

  # show link to register in any contest if it is enrollment open
  def contest_link_register(contest)
    (contest.open_enrollment?) ? link_to('Inscrever-me', new_participant_path(:contest_id => contest.id), :method => :get) : "" 
  end

  # show approved label status 
  def label_status_inscription(participant)
    if participant.pending? 
      '<span class="label label-warning">Inscrição enviada para aprovação</span>'.html_safe
    elsif participant.failed?
      '<span class="label label-danger">Sua inscrição foi recusada</span>'.html_safe 
    elsif participant.approved?
      '<span class="label label-success">Inscrição aprovada</span>'.html_safe 
    end
  end

  def gravatar_for(user, options = { size: 80 , _class: ""})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    _class = options[:_class]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar #{_class}")
  end

  # check if user is registered in a contest
  def label_check_inscription(contest) 
    user_found = contest.users.find_by(id:current_user.id)
    (!user_found.nil?) ? '<span class="label label-primary">Inscrito</span>'.html_safe : ''
  end

  def link_to_approve_inscription(participant)
     label = 'Aprovar Inscrição'
      action = 'approved'
    return link_to 'Aprovar Inscrição', "/admin/participant/#{participant.id}/#{action}", remote: true, class: "btn btn-primary ", "data-dismiss" => "modal" if participant.pending?
  end

  def user_vote_pannel(participant)
    label = "faça login para votar"
    button_class = "btn btn-primary disabled"

    if current_user
      label = "Votar"
      if not_voted_in_this_contest(participant.contest_id)
        button_class = "btn btn-primary"
      end
    end

    return link_to label, "/vote/#{participant.id}", remote: true, class: button_class, "data-dismiss" => "modal"
  end

  def picture_featured (participant)
    if participant.nil?
      image_tag("placeholder.png", alt: "Placeholder-user", class: "img-responsive") 
    else
      image_tag(participant.picture.url(:medium), alt: participant.title, class: "img-responsive img-featured") 
    end
  end

  def not_voted_in_this_contest(contest_id)
    #Erro se não houver participants
    contest_participants = Participant.where(contest_id: contest_id).pluck(:id)
    Vote.where(participant_id: contest_participants, user_id: current_user.id).empty?
  end
  
  def link_to_reject_inscription(participant)
   label = 'Recusar Inscrição'
   action = 'failed'
   return link_to label, "/admin/participant/#{participant.id}/#{action}", remote: true, class: "btn btn-primary", "data-dismiss" => "modal"
 end

end
