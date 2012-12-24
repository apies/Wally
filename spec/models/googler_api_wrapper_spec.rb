require 'spec_helper'
describe 'GooglerApiWrapper' do
  
  before :each do
    @object = Object.new
    @object.extend(GooglerApiWrapper)
    @object.service = Dir
  end
  
  it "should have instance attributes useful for storing client and service objects" do
    @object.should respond_to(:client)
    @object.should respond_to(:service)
    @object.should respond_to(:token)
  end
  
  it "should correctly build the method missing attribute hash" do
    method_hash = @object.get_method_hash('get_posts')
    method_hash[:model].should eq 'posts'
    method_hash[:method].should eq 'get'
    method_hash_complex = @object.get_method_hash('list_blogs_by_user')
    method_hash_complex[:model].should eq 'blogs'
    method_hash_complex[:method].should eq 'list_by_user'
  end
  
  it "should be able to build an api_method method on the service and client objects" do
    @object.service = Dir 
    api_method = @object.build_api_method('pwd', 'to_s')
    api_method.should eq Dir.pwd.to_s
  end
  
  it "should be able to build an execution hash to send to the google client" do
    @object.service = Dir
    execution_hash = @object.build_execution_hash('length_pwd', {'userId' => 'self'} )
    execution_hash[:parameters].should eq({'userId' => 'self'})
    execution_hash[:api_method].should eq(Dir.pwd.length)
  end
  
  it "should build the execution hash and execute it on method missing" do
    @client = double('client')
    @object.client = @client
    @client.should_receive(:execute).with(:api_method => Dir.pwd.length, :parameters => {'userId' => 'self'}, :headers => {'Content-Type' => 'application/json'})
    @object.length_pwd('userId' => 'self')
  end
  
  it "should know to create a client before making the api calls" do
    @client = double('client')
    @object.client.should be_nil
    @object.stub(:create_client).and_return(@object.client = @client)

    @client.should_receive(:execute).with(:api_method => Dir.pwd.length, :parameters => {'userId' => 'self'}, :headers => {'Content-Type' => 'application/json'})

    @object.length_pwd('userId' => 'self')
    #api client should now be instantiated
    @object.client.should_not be_nil

  end
  
  
  
  
  
end