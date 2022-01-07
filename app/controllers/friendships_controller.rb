class FriendshipsController < ApplicationController
  
  def create
    @friendship = current_user.friendships.build(:user_b => params[:user_b])
    #@friendship = Friendship.new.current_user.friendships.build(:user_b => params[:user_b])

    respond_to do |format|
      if @friendship.save
        format.turbo_stream
        format.html { redirect_to user_path }
        format.json { render :show, status: :created, location: @friendship }
        #flash[:notice] = "Added friend."
        ##redirect_to root_url
      else
        #render "new"
        format.turbo_stream # add format turbo_stream
        format.html { render user_path, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
        #friend = @friendship.friend
        #flash[:error] = "Issues adding #{friend.email}: #{@friendship.errors.full_messages}"
      end
      #redirect_to user_path
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end
  
end