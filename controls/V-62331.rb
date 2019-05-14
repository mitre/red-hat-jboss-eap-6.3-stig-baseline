control "V-62331" do
  title "Wildfly must be configured to generate log records when
  successful/unsuccessful attempts to delete privileges occur."
  desc  "Deleting privileges of a subject/object may cause a subject/object to
  gain or lose capabilities.  When successful and unsuccessful privilege
  deletions are made, the events need to be logged.  By logging the event, the
  modification or attempted modification can be investigated to determine if it
  was performed inadvertently or maliciously."
  impact 0.5
  tag "gtitle": "SRG-APP-000499-AS-000224"
  tag "gid": "V-62331"
  tag "rid": "SV-76821r1_rule"
  tag "stig_id": "JBOS-AS-000695"
  tag "cci": ["CCI-000172"]
  tag "documentable": false
  tag "nist": ["AU-12 c", "Rev_4"]
  tag "check": "Log on to the OS of the Wildfly server with OS permissions that
  allow access to Wildfly.
  Using the relevant OS commands and syntax, cd to the $JBOSS_HOME;/bin/ folder.
  Run the jboss-cli script to start the Command Line Interface (CLI).
  Connect to the server and authenticate.
  Run the command:

  For a Managed Domain configuration:
  \"ls
  host=master/server/<SERVERNAME>/core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\"

  For a Standalone configuration:
  \"ls
  /core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\"

  If \"enabled\" = false, this is a finding."
  tag "fix": "Launch the jboss-cli management interface.
  Connect to the server by typing \"connect\", authenticate as a user in the
  Superuser role, and run the following command:

  For a Managed Domain configuration:
  \"host=master/server/<SERVERNAME>/core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\"

  For a Standalone configuration:
  \"/core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\""
  tag "fix_id": "F-68251r1_fix"

  connect = attribute('connection')

  describe 'The wildfly setting: generate log records when successful/unsuccessful attempts to delete privileges occur' do
    subject { command("/bin/sh /opt/wildfly/bin/jboss-cli.sh #{connect} --commands=ls\\ /core-service=management/access=audit/logger=audit-log").stdout }
    it { should_not match(%r{enabled=false}) }
  end
end
