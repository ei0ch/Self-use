#!/usr/bin/env ruby

puts "==== Rime auto deploy ===="
puts "Have you installed Rime?(y/n)"

result = gets
if result.strip != "y"
  puts "(1/4) Install rime ? (y/n)"
  result = gets
  system("brew install --cask squirrel") if result.strip == "y"
  puts "step1: Logout and relogin system"
  puts "step2: Make Rime Input as your input method in system pane."
  puts "step3: Rerun this program, jump over install Rime step."
else
  puts "Do you want to continue?(y/n)"
  result = gets
  exit 0 if result.strip != "y"

  puts "(2/4) Backup Rime default config."
  puts "run `mv ~/Library/Rime ~/Library/Rime.old`"
  system("mv ~/Library/Rime ~/Library/Rime.old")
  puts "done ✅"
  puts ""
  puts "(3/4) Install Rime-ice config."
  puts "run `git clone --depth=1 https://github.com/Mark24Code/rime-ice.git ~/Library/Rime`"
  system(
    "git clone --depth=1 https://github.com/Mark24Code/rime-ice.git ~/Library/Rime"
  )
  puts "done ✅"
  puts ""
  puts "(4/4) Download Custom config."
  system("wget https://raw.githubusercontent.com/ei0ch/Self-use/master/Self-use%20software/rime-auto-deploy/default.custom.yaml -O ~/Library/Rime/default.custom.yaml")
  system("wget https://raw.githubusercontent.com/ei0ch/Self-use/master/Self-use%20software/rime-auto-deploy/squirrel.custom.yaml -O ~/Library/Rime/squirrel.custom.yaml")
  puts "done ✅"
  puts ""
  puts "Deploy finised"
  puts "Please open Rime setting pane and click `Deploy`. Enjoy~ 🍻"
end
