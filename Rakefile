# -*- coding: utf-8 -*-

desc 'ping to localhost'
task :ping do
  sh "ansible -i inventory/local all -m ping"
end

desc 'facts on localhost'
task :facts do
  sh "ansible -i inventory/local all -m setup"
end

desc 'run setup playbook on localhost'
task :run do
  sh "ansible-playbook -Ki inventory/local site.yml"
end

desc 'run update playbook on localhost'
task :update do
  sh "ansible-playbook -Ki inventory/local update.yml"
end

desc 'run home backup playbook on localhost'
task :backup do
  sh "ansible-playbook -i inventory/local backup.yml"
end

desc 'copy backup files to remote server'
task :backup_scp do
  sh "scp /mnt/c/Users/toki/Documents/tmp/home.*.tar.gz.* 192.168.100.200:/home/toki/backup/."
end

desc 'ping to test container'
task :ping_test => %w[ test:inventory ].map(&:to_sym) do
  sh "ansible -i inventory/test all -m ping"
end

desc 'facts on test container'
task :facts_test => %w[ test:inventory ].map(&:to_sym) do
  sh "ansible -i inventory/test all -m setup"
end

desc 'run setup playbook on test container'
task :run_test => %w[ test:inventory ].map(&:to_sym) do
  sh "ansible-playbook -i inventory/test site.yml"
end

desc 'run update playbook on test container'
task :update_test => %w[ test:inventory ].map(&:to_sym) do
  sh "ansible-playbook -i inventory/test update.yml"
end

namespace :test do
  require 'json'
  require 'pathname'
  require 'uri'

  DOCKER = ENV['DOCKER_COMMAND'] || 'docker'
  DOCKER_HOST = (ENV.key? 'DOCKER_HOST') ? URI(ENV['DOCKER_HOST']).host : 'localhost'
  IMAGE = 'sshd_ubuntu:18.04'
  NAME = Pathname.getwd.basename.to_s + '_test'

  DOCKER_INSPECT_CACHE = {}

  def docker_inspect(name)
    DOCKER_INSPECT_CACHE[name] ||= JSON.parse(`#{DOCKER} inspect #{name}`)
  end

  def get_exposed_port(name)
    docker_inspect(name)[0]['Config']['ExposedPorts'].keys.first
  end

  def get_published_port(name)
    Integer(docker_inspect(name)[0]['NetworkSettings']['Ports'][get_exposed_port(name)][0]['HostPort'])
  end

  task :docker_host do
    p DOCKER_HOST
  end

  task :image do
    p IMAGE
  end

  task :name do
    p NAME
  end

  task :exposed_port do
    p get_exposed_port(NAME)
  end

  task :published_port do
    p get_published_port(NAME)
  end

  desc 'test inventory'
  task :inventory do
    File.open('inventory/test', 'w') {|output|
      output << NAME
      output << " ansible_connection=ssh"
      output << " ansible_host=#{DOCKER_HOST}"
      output << " ansible_port=#{get_published_port(NAME)}"
      output << " ansible_user=admin"
      output << "\n"
    }
  end

  desc 'test container run'
  task :run do
    sh "#{DOCKER} run -d -P --name=#{NAME} #{IMAGE}"
    sh "#{DOCKER} ps"
  end

  desc 'test container start'
  task :start do
    sh "#{DOCKER} start #{NAME}"
    sh "#{DOCKER} ps"
  end

  desc 'test container stop'
  task :stop do
    sh "#{DOCKER} stop #{NAME}"
    sh "#{DOCKER} ps"
  end

  desc 'test container remove'
  task :remove do
    sh "#{DOCKER} rm -f #{NAME}"
    sh "#{DOCKER} ps"
  end

  desc 'test container login'
  task :login do
    sh "#{DOCKER} exec -u admin -it #{NAME} bash"
  end
end

require 'rake/clean'

desc 'converto README markdown to html'
task :readme => [ 'README.html' ]

file 'README.html' => [ 'README.md' ] do
  sh "pandoc --from=markdown --to=html5 --standalone --self-contained --css=$HOME/.pandoc/github.css --output=README.html README.md"
end
CLOBBER.include 'README.html'

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
