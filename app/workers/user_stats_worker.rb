class UserStatsWorker
  include Sidekiq::Worker

  def perform
    users = User.all
    users.each { |u| u.update_owp            }
    users.each { |u| u.update_oowp           }
    users.each { |u| u.update_rpi            }
    users.each { |u| u.update_rank(users)    }
  end
end