def test_webapp_user(User):
    user = User("webapp")

    assert user.exists
    assert user.group == "webapp"
    assert user.shell == "/sbin/nologin"


def test_webapp_group(Group):
    group = Group("webapp")

    assert group.exists


def test_jira_directories(File):
    directories = [
        '/opt/atlassian/jira/7.1.9',
        '/var/atlassian/application-data/jira'
    ]
    for directory in directories:
        d = File(directory)
        assert d.is_directory
        assert d.user == 'webapp'
        assert d.group == 'webapp'


def test_server_xml(File):
    config = File('/opt/atlassian/jira/7.1.9/conf/server.xml')
    assert config.is_file


def test_server_started(File):
    config = File('/opt/atlassian/jira/7.1.9/logs/catalina.out')
    assert config.contains('Server startup in')


def test_service_running(Service):
    service = Service('jira')
    assert service.is_running
    assert service.is_enabled


def test_service_listening(Socket):
    socket = Socket('tcp://:::8080')
    assert socket.is_listening


def test_java_package_version(Package):
    package = Package('jdk1.8.0_101')
    assert package.is_installed
