desc "Update important user stats."
task :update_stats => :environment do
  puts "BEGIN - Updating user stats..."
  User.all.each { |u| u.update_stats }
  puts "END - User stats updated."
end