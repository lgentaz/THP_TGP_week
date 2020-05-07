module SessionsHelper
    def current_user
        User.find_by(id: session[:user_id])
    end

    def current_user?(user)
        user == current_user
    end

    def liked?(which_goss)
        liked_user = Like.find_by(user_id: session[:user_id])
        liked_gossip = Like.find_by(gossip_id: which_goss)
        liked_user == liked_gossip
    end
    
    def log_in(user)
        session[:user_id] = user.id
    end
    
    def signed_in?
        !current_user.nil?
    end
    
end
