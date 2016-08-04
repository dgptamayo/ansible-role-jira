require 'spec_helper'

context 'install' do
  describe group('webapp') do
    it { should exist }
  end

  describe user('webapp') do
    it { should exist }
    it { should belong_to_group 'webapp' }
    it { should have_login_shell '/sbin/nologin' }
  end
end

context 'directories' do
  [
    '/opt/atlassian/jira/7.1.9',
    '/var/atlassian/application-data/jira'
  ].each do |dir|
    describe file(dir) do
      it { should be_directory }
      it { should be_owned_by 'webapp' }
      it { should be_grouped_into 'webapp' }
    end
  end
end

context 'config files' do
  [
    '/opt/atlassian/jira/7.1.9/conf/server.xml'
  ].each do |file|
    describe file(file) do
      it { should be_file }
      # its(:content) { should match /zone.*0.0.10.in-addr.arpa/ }
    end
  end
end

context 'server started' do
  describe file('/opt/atlassian/jira/7.1.9/logs/catalina.out') do
    its(:content) { should match(/Server startup in/) }
  end
end

context 'service' do
  describe service('jira') do
    it { should be_running }
  end

  describe port(8080) do
    it { should be_listening }
  end
end
