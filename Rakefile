# -*- coding: utf-8 -*-

require 'pathname'

IMAGE = 'sshd_ubuntu:17.10'
NAME = Pathname.getwd.basename.to_s + '_test'

def get_test_host
  File.open(File.join('inventory', 'test')) {|input|
    input.gets.split[0].split(/:/, 2)
  }
end

task :test_image do
  p IMAGE
end

task :test_name do
  p NAME
end

task :test_host do
  p get_test_host
end

desc 'test container run'
task :test_run do
  ip, port = get_test_host
  sh "sudo docker run -d -p #{ip}:#{port}:22 --name=#{NAME} #{IMAGE}"
  sh "sudo docker ps"
end

desc 'test container start'
task :test_start do
  sh "sudo docker start #{NAME}"
  sh "sudo docker ps"
end

desc 'test container stop'
task :test_stop do
  sh "sudo docker stop #{NAME}"
  sh "sudo docker ps"
end

desc 'test container remove'
task :test_remove do
  sh "sudo docker rm -f #{NAME}"
  sh "sudo docker ps"
end

desc 'test container login'
task :test_login do
  ip, port = get_test_host
  sh "slogin -l admin -p #{port} #{ip}"
end

desc 'desktop setup playbook in test container'
task :desktop_setup_test do
  sh %q{ ansible-playbook -i inventory/test site.yml }
end

desc 'desktop setup playbook on localhost'
task :desktop_setup_local do
  sh %q{ ansible-playbook -i inventory/local site.yml }
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
