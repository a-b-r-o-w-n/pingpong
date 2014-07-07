class MatchesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :pending_matches]
  before_action :set_tournament
  before_action :set_match, only: [:show, :edit, :update, :destroy, :play]

  def index
    params[:page] ||= 1
    unless @tournament
      @matches = Match.order('id desc').paginate(:page => params[:page], :per_page => 10)
    else
      @matches = @tournament.matches.order('id desc').paginate(:page => params[:page], :per_page => 10)
    end
  end

  def pending_matches
    params[:page] ||= 1
    unless @tournament
      @matches = Match.where(status: ['P', 'IP']).order('id desc').paginate(:page => params[:page], :per_page => 10)
    else
      @matches = @tournament.matches.where(status: ['P', 'IP']).order('id desc').paginate(:page => params[:page], :per_page => 10)
    end
    respond_to do |format|
      format.html { render :template => "matches/index.html.erb" }
    end
  end

  def new
    unless @tournament
      @match = Match.new
    else
      @match = @tournament.matches.new
    end

  end

  def edit
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to matches_url
    else
      flash.now[:danger] = object_errors_flash( @match )
      render :new
    end
  end

  def update

    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to matches_url, info: 'Match was successfully updated.' }
        format.js { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :no_content }
    end
  end

  def play
    if ['IP', 'P'].include? @match.status
      @match.update_attribute :status, 'IP'
      @match
    else
      redirect_to matches_url
    end
  end


  private
    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.require(:match).permit(:status, :player1_id, :player2_id, :score1, :score2)
    end

    def set_tournament
      @tournament = Tournament.find(params[:tournament_id]) if params[:tournament_id]
    end

end
