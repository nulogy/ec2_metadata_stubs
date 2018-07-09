describe command("curl http://169.254.169.254/latest/user-data") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match "abcd1234" }
end
