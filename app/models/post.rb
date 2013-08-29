class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags

  def list_tags
    self.tags.map { |tag| tag.name }.join(", ")
  end

  def add_tags(tag_array) #takes array of tags e.g. ["tag1", "tag2", etc.]
    tag_array.each do |input_tag|
      unless self.tags.any? { |tag| tag.name == input_tag }
        self.tags.push(Tag.find_or_create_by_name(name: input_tag))
      end
    end
  end

end


# list_tags => "tag1, tag2, tag3"
# post.add_tags(['tag1', 'tag2', 'tag3'])
## post.tags => [tag1, tag2, tag3] assocoiates 3 tag objects 
