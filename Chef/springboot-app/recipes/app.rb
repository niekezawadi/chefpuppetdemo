directory '/opt/springboot' do
  action :create
end
cookbook_file '/opt/springboot/app.jar' do
  source 'app.jar'
  action :create_if_missing
end

execute 'start-springboot' do
  command 'java -jar /opt/springboot/app.jar &'
  action :run
end
