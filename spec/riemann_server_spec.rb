require 'spec_helper'

describe package('riemann') do
  it { should be_installed }
end

describe service('riemann') do
  it { should be_running }
  it { should be_enabled }
end

describe user('riemann') do
  it { should exist }
  it { should have_login_shell '/bin/false' }
  it { should have_home_directory '/usr/share/riemann' }
  it { should belong_to_group 'riemann' }
end

riemann_directories = %w(
  /usr/share/riemann
  /etc/riemann
  /var/log/riemann
)
riemann_directories.each do |dir|
  describe file(dir) do
    it { should exist }
    it { should be_directory }
  end
end

describe file('/etc/riemann/riemann.config') do
  it { should exist }
  its('owner') { should eq 'riemann' }
  its('group') { should eq 'riemann' }
  its('mode') { should eq '644' }
  its('content') { should match(/\(let \[host "127\.0\.0\.1"\]/) }
  its('content') { should match(/\(tcp-server {:host host :port 5555}\)/) }
end

# Would be better to read the version dynamically from a variable somewhere.
riemann_version = '0.2.11'
describe file("/usr/local/src/riemann_#{riemann_version}_all.deb") do
  it { should exist }
  it { should be_file }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should eq '644' }
end

describe port(5555) do
  it { should be_listening }
  it { should be_listening.on('127.0.0.1') }
  it { should_not be_listening.on('0.0.0.0') }
end

# Check that riemann process is running as riemann user
describe command('pgrep -u riemann | wc -l') do
  its('stdout') { should eq "1\n" }
end

describe command('sudo netstat -nlt') do
  its('stdout') { should match(/127\.0\.0\.1:5555/) }
  its('stdout') { should_not match(/0\.0\.0\.0:5555/) }
end
