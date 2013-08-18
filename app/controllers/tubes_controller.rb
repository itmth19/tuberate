require 'open-uri'

class TubesController < ApplicationController
	def new
		
	end
  
	def create
		@tube = Tube.new(params[:tube].permit(:title,:link))
    source = open(@tube.link).read
    @tube.title=/<title>(?<title>.+)<\/title>/.match(source)[:title]
		@tube.link=/.+\=(?<href>.+)/.match(@tube.link)[:href]
		@tube.rank=1
		@tube.save
		redirect_to @tube
	end

	def show
		@tube = Tube.find(params[:id])
	end

	def index
		@tubes = Tube.find(:all,:order => "rank DESC")

	end

	def voteup
		@tube = Tube.find(params[:id])
		@tube.rank=@tube.rank + 1
		@tube.save
		redirect_to tube_path(@tube)	
	end

	def votedown
		@tube = Tube.find(params[:id])
		@tube.rank = @tube.rank - 1
		@tube.save
		redirect_to tube_path(@tube)
	end

	def cleartubes
		Tube.delete_all
		redirect_to tubes_path
	end
end
