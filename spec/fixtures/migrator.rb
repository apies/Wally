require 'json'
require 'fileutils'
#require 'dir'

posts = JSON.parse(File.read('posts_list.json'))['items']

posts.each do |post|
	File.open("2510490903247292153/#{post['id']}.json", "w") do |file|
		file.write(post.to_json)
	end
end