class CommentsController < ApplicationController
	def create
		@tube = Tube.find(params[:tube_id])
		@comment = @tube.comments.create(params[:comment].permit(:author,:body))
		redirect_to tube_path(@tube)	
 	end
end
