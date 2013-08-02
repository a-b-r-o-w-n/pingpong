desc "Update important user stats."
task :update_stats => :environment do
	logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  logger.tagged("STATS") { logger.info "BEGIN - Updating user stats..." }
  User.update_stats
  logger.tagged("STATS") { logger.info "END - User stats updated." }
  
end