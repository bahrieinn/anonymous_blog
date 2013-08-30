require 'faker'

@tags = %w{coffee colors expo food markers nighthawks nuts phone post-its programming ruby sinatra stuff tag whatever}

50.times do 
  Post.create!(
    title: Faker::Company.bs,
    author: Faker::Name.name,
    body: Faker::Lorem.paragraphs(paragraph_count = 2, random_paragraphs_to_add = 2 )
  )
end

def rand_tag_sample
  @tags.sample(rand(5)+1)
end

Post.all.each do |post|
  post.add_tags(rand_tag_sample)
end




