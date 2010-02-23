def notify(kind, msg)
  title = kind == :pass ? "Yeah!" : "Fail!"
  
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
    notify(:pass, "O Cirne agradece.")
  else
    notify(:fail, "http://www.aiqueburro.com")
  end
end

def run_test_file(file, clear = false)
  run "bundle exec rspec #{file}", clear
end

def run_all_tests
  run "bundle exec rake", :clear
end

def related_test_files(path)
  Dir['spec/**/*.rb'].select{|file| file =~ /#{File.basename(path, ".rb")}_spec/ }
end

watch('spec/spec_helper\.rb'){ run_all_tests }
watch('spec/.*/.*_spec\.rb'){|m| run_test_file(m[0], :clear) }
watch('lib/.*\.rb'){|m| puts m; related_test_files(m[0]).each{|file| run_test_file(file) }}

# Ctrl-\
Signal.trap('QUIT') do
  puts " --- Running all tests ---\n\n"
  run_all_tests
end

# Ctrl-C
Signal.trap('INT') { abort("\n") }

