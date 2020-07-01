control 'V-62283' do
  title "The Wildfly server must be configured to bind the management interfaces
  to only management networks."
  desc  "Wildfly provides multiple interfaces for accessing the system.  By
  default, these are called \"public\" and \"management\".  Allowing
  non-management traffic to access the Wildfly management interface increases the
  chances of a security compromise.  The Wildfly server must be configured to bind
  the management interface to a network that controls access.  This is usually a
  network that has been designated as a management network and has restricted
  access.  Similarly, the public interface must be bound to a network that is not
  on the same segment as the management interface."
  impact 0.5
  tag "gtitle": 'SRG-APP-000158-AS-000108'
  tag "gid": 'V-62283'
  tag "rid": 'SV-76773r1_rule'
  tag "stig_id": 'JBOS-AS-000285'
  tag "cci": ['CCI-000778']
  tag "documentable": false
  tag "nist": ['IA-3', 'Rev_4']
  tag "check": "Obtain documentation and network drawings from system admin
  that shows the network interfaces on the Wildfly server and the networks they are
  configured for.

  If a management network is not used, you may substitute localhost/127.0.0.1 for
  management address.  If localhost/127.0.0.1 is used for management interface,
  this is not a finding.

  From the Wildfly server open the web-based admin console by pointing a browser to
  HTTP://127.0.0.1:9990.
  Log on to the management console with admin credentials.
  Select \"RUNTIME\".
  Expand STATUS by clicking on +.
  Expand PLATFORM by clicking on +.
  In the \"Environment\" tab, click the > arrow until you see the
  \"jboss.bind.properties\" and the \"jboss.bind.properties.management\" values.

  If the jboss.bind.properties and the jboss.bind.properties.management do not
  have different IP network addresses assigned, this is a finding.

  Review the network documentation.  If access to the management IP address is
  not restricted, this is a finding."
  tag "fix": "Refer to the Wildfly EAP Installation guide for
  detailed instructions on how to start JBoss as a service.

  Use the following command line parameters to assign the management interface to
  a specific management network.

  These command line flags must be added both when starting JBoss as a service
  and when starting from the command line.

  Substitute your actual network address for the 10.x.x.x addresses provided as
  an example below.

  For a standalone configuration:
  JBOSS_HOME/bin/standalone.sh -bmanagement=10.2.2.1 -b 10.1.1.1

  JBOSS_HOME/bin/domain.sh -bmanagement=10.2.2.1 -b 10.1.1.1

  If a management network is not available, you may substitute
  localhost/127.0.0.1 for management address.  This will force you to manage the
  Wildfly server from the local host."
  tag "fix_id": 'F-68203r1_fix'

  bind_mgmt_address = command("grep jboss.bind.address.management #{ input('jboss_home') }/standalone/configuration/standalone.xml | awk -F'=' '{print $2}' ").stdout
  public_bind_address = command("grep jboss.bind.address #{ input('jboss_home') }/standalone/configuration/standalone.xml | grep -v management | awk -F'=' '{print $2}' ").stdout

  bind_mgmt_address = command("grep jboss.bind.address.management #{ input('jboss_home') }/standalone/configuration/standalone.xml | awk -F'=' '{print $2}' ").stdout
  public_bind_address = command("grep jboss.bind.address #{ input('jboss_home') }/standalone/configuration/standalone.xml | grep -v management | awk -F'=' '{print $2}' ").stdout

  describe 'The wildfly bind address' do
    subject { bind_mgmt_address }
    it { should_not eq public_bind_address }
  end
end
