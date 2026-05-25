package 'postgresql' do
  action :install
end
service 'postgresql' do
  action [:enable, :start]
end
