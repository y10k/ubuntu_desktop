# -*- coding: utf-8 -*-

def get_test_host
  File.open(File.join('inventory', 'test')) {|input|
    input.gets.split[0].split(/:/, 2)
  }
end

task :test_host do
  p get_test_host
end

desc 'test container run'
task :test_run do
  ip, port = get_test_host
  sh %Q{ sudo docker run -d -p #{ip}:#{port}:22 --name=desktop_setup_test sshd_ubuntu:17.10 }
end

desc 'test container start'
task :test_start do
  sh %Q{ sudo docker start desktop_setup_test }
end

desc 'test container stop'
task :test_stop do
  sh %Q{ sudo docker stop desktop_setup_test }
end

desc 'test container remove'
task :test_remove do
  sh %Q{ sudo docker rm -f desktop_setup_test }
end

desc 'desktop setup playbook in test container'
task :desktop_setup_test do
  sh %q{ ansible-playbook -i inventory/test setup.yml }
end

desc 'desktop setup playbook on localhost'
task :desktop_setup_local do
  sh %q{ ansible-playbook -i inventory/local setup.yml }
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
