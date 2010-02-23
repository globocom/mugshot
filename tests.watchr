def notify(kind, msg)
  title = king == :pass ? "Yeah!" : "Fail!"
  
  if RUBY_PLATFORM =~ /darwin/ # OSX
    system "growlnotify -m #{msg.inspect} -t #{title.inspect}"
  elsif RUBY_PLATFORM =~ /linux/ # Linux
    require 'libnotify'
    Libnotify.show(:body => title, :summary => msg, :timeout => 2.5)
  end
end

def run(cmd, clear = false)
  system("clear") if clear
  pass = system(cmd)
  if pass
    notify(:pass, "Your getting good on it.")
  else
    notify(:fail, "Go to http://www.aiqueburro.com")
end

def run_test_file(file)
  run %Q(bundle exec rspec #{file})
end

def run_all_tests
  run "bundle exec rake"
end

def related_test_files(path)
  Dir['spec/**/*.rb'].select{|file| file =~ /#{File.basename(path)}_spec/ }
end

watch('spec/spec_helper\.rb'){ system('clear'); run_all_tests }
watch('spec/.*/.*_spec\.rb'){|m| system('clear'); run_test_file(m[0]) }
watch('lib/.*'){|m| related_test_files(m[0]).each{|file| run_test_file(file) }}

# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

# Ctrl-C
Signal.trap('INT') { abort("\n") }

