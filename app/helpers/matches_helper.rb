module MatchesHelper

  def player_input( f, player )
    if params[:action] == 'edit'
      f.input player, as: :static
    else
      f.association player
    end
  end

end
