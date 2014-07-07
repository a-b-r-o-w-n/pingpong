$(document).ready ->
  add_point = (score_input) ->
    curr_point = parseInt(score_input.val())
    score_input.val curr_point + 1
    score_input.val()

  form = $('#form-container form')

  increase_score = (player, input, form) ->
    player.on 'click', ->
      toggle_loading( player )
      new_score = add_point( input )
      form.submit()
      form.on 'ajax:complete', ->
        setTimeout( ->
          player.find('.points').text(new_score)
        , 500)

  toggle_loading = (player) ->
    icon = $('<i class="fa fa-circle-o-notch fa-spin"></i>')
    player.find('.points').html icon

  increase_score($('#p1-score'), $('#match_score1'), form)
  increase_score($('#p2-score'), $('#match_score2'), form)

  $('#end-game').click ->
    $('#match_status').val 'C'
    form.submit()
    form.on 'ajax:complete', (request) ->
      location.reload()