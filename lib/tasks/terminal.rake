desc "Start up rails server, rails console and sidekiq"
task :tabs do
  system "osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down' -e 'tell application \"Terminal\" to do script \"cd #{Dir.pwd}; rails console\" in selected tab of the front window'"
  system "osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down' -e 'tell application \"Terminal\" to do script \"cd #{Dir.pwd}; rails server\" in selected tab of the front window'"
  system "osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down' -e 'tell application \"Terminal\" to do script \"cd #{Dir.pwd}; sidekiq\" in selected tab of the front window'"
end
