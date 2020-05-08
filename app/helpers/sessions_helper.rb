module SessionsHelper
    def current_user
        if session[:user_id]
            current_user = User.find_by(id: session[:user_id])
        elsif cookies[:user_id]
            user = User.find_by(id: cookies[:user_id])
            if user
                remember_token = cookies[:remember_token]
                remember_digest = user.remember_digest
                user_authenticated = BCrypt::Password.new(remember_digest).is_password?(remember_token)
                if user_authenticated
                    log_in user
                    current_user = user
                end
            end
        end
    end

    def current_user?(user)
        user == current_user
    end

    def liked?(which_goss)
        which_goss.user_id == session[:user_id]
    end
    
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def signed_in?
        !current_user.nil?
    end

    def remember(user)
        remember_token = SecureRandom.urlsafe_base64
        user.remember(remember_token)
        cookies.permanent[:user_id] = user.id
        cookies.permanent[:remember_token] = remember_token
    end

    def forget(user)
        user.update(remember_digest: nil)
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def log_out(user)
        session.delete(:user_id)
        forget(user)        
    end

end
