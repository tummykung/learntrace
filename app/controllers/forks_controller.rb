class ForksController < ApplicationController
  before_filter :authenticate_user!

  def create
    @source = Stream.find(params[:stream_id])
    if params[:new_stream] && !params[:new_stream].blank?
      @target = current_user.streams.create(:name => params[:new_stream])
    else
      @target = current_user.streams.find(params[:fork][:target_id])
    end
    @target.fork!(@source)
    respond_to do |format|
      format.html { redirect_to @target }
      format.js
    end
  end

  def destroy
    @fork = Fork.find(params[:id])
    @fork_id = @fork.id
    @target = current_user.streams.find(@fork.target)
    @target.dam!(@fork.source)

    respond_to do |format|
      format.js
    end
  end

end
