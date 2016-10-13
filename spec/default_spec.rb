require 'spec_helper'

# verify user/group creation tasks
context 'install' do
  describe group('jira') do
    it { should exist }
    it { should have_gid 33_000 }
  end

  describe user('jira') do
    it { should exist }
    it { should belong_to_group 'jira' }
    it { should have_login_shell '/sbin/nologin' }
    it { should have_uid 33_000 }
  end
end

# verify install tasks
context 'directories' do
  [
    '/opt/atlassian/jira/7.2.2',
    '/var/atlassian/application-data/jira'
  ].each do |dir|
    describe file(dir) do
      it { should be_directory }
      it { should be_owned_by 'jira' }
      it { should be_grouped_into 'jira' }
    end
  end
end

# verify cleanup
describe file('/var/tmp/atlassian-jira-software-7.2.2.tar.gz') do
  it { should_not exist }
end

# verify configuration tasks
# rubocop:disable LineLength
describe file('/opt/atlassian/jira/7.2.2/atlassian-jira/WEB-INF/classes/jira-application.properties') do
  # rubocop:enable LineLength
  it { should be_file }
  its(:content) { should match '/var/atlassian/application-data/jira' }
end

describe file('/opt/atlassian/jira/7.2.2/conf/server.xml') do
  it { should be_file }
end

describe file('/opt/atlassian/jira/7.2.2/bin/setenv.sh') do
  it { should be_file }
  its(:content) { should match 'JVM_MINIMUM_MEMORY="384m"' }
  its(:content) { should match 'JVM_MAXIMUM_MEMORY="768m"' }
end

# verify service tasks
context 'server started' do
  describe file('/opt/atlassian/jira/7.2.2/logs/catalina.out') do
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
