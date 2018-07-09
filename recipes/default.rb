EC2_METADATA_ENDPOINT_IP = "169.254.169.254".freeze
EC2_METADATA_STUB_DIRECTORY = "/etc/ec2_metadata_stubs".freeze

node["ec2_metadata_stubs"]["stubs"].each do |endpoint_name, endpoint_data|
  filename = "#{EC2_METADATA_STUB_DIRECTORY}/#{endpoint_name}"
  file_content = endpoint_data

  directory File.dirname(filename) do
    recursive true
  end

  file filename do
    content file_content
  end
end

ifconfig EC2_METADATA_ENDPOINT_IP do
  device "lo:0"
end

poise_service "ec2_metadata_stubs" do
  command "/opt/chef/embedded/bin/ruby -run -e httpd '#{EC2_METADATA_STUB_DIRECTORY}' --bind-address #{EC2_METADATA_ENDPOINT_IP} -p 80"
end

ohai "reload" do
  action :reload
end
