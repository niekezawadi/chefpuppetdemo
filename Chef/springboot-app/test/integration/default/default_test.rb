describe package('openjdk-21-jdk') do
  it { should be_installed }

end
describe service('postgresql') do
  it { should be_running }
end
describe port(8080) do
  it { should be_listening }
end
