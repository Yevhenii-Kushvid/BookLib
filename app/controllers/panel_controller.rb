class PanelController < ApplicationController
  
  
  def index
    @drafts = Book.where(is_draft: true, user_id: current_user.id)
    @books = Book.where(is_draft: false, user_id: current_user.id) 
  end

end
