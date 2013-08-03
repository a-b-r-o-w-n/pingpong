$(document).ready(function(){
	var form = $('#form-container form')

  $('#player1-point').click(function(event){

			var new_score = add_point($('#match_score1'))
			form.trigger('submit.rails');

			form.on('ajax:complete', function(request){
				$('#p1-display-score').text(new_score);
			});
   });

  $('#player2-point').click(function(event){

			var new_score = add_point($('#match_score2'))
			form.trigger('submit.rails');

			form.on('ajax:complete', function(request){
				$('#p2-display-score').text(new_score);
			});
   });

  $('#end-game').click(function(){
  	$('#match_status').val('C');
  	form.trigger('submit.rails');
  	form.on('ajax:complete', function(request){
				location.reload();
			});
  });
});

function add_point(score_input) {
	var curr_point = parseInt(score_input.val());
	score_input.val(curr_point + 1);
	return score_input.val();
}