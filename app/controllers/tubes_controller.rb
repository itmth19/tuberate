require 'open-uri'

class TubesController < ApplicationController
  before_action :set_tube, only: [:show, :edit, :update, :destroy, :votedown, :voteup]

	def index
		@tubes = Tube.find(:all,:order => "rank DESC")
	end

	def new
	end
  
	def create
		@tubeX = Tube.new(params[:tube].permit(:title,:link))
    links = @tubeX.link.lines.map(&:chomp)
    links.each do |link|
      source = open(link).read
      @tube = Tube.new
      @tube.title = /<title>(?<title>.+)<\/title>/.match(source)[:title]
		  @tube.link = /.+\=(?<href>.+)/.match(link)[:href]
		  @tube.rank = 1
		  @tube.save
    end
		redirect_to @tube
	end

	def show
	end

	def voteup
		@tube.rank += 1

		if @tube.save
      redirect_to @tube
    else
      # TODO Throw error
    end
	end

	def votedown
		@tube.rank -= 1

		if @tube.save
      redirect_to @tube
    else
      # TODO Throw error
    end
	end

	def cleartubes
    # FIXME
		Tube.delete_all
		redirect_to tubes_path
	end

  private
    def set_tube
      @tube = Tube.find(params[:id])
    end
end
