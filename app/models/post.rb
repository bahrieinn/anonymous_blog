class Post < ActiveRecord::Base
  has_and_belongs_to_many :tags
  # before_create :default_author

  def list_tags
    self.tags.map { |tag| tag.name }.join(", ")
  end

  def add_tags(tag_array) #takes array of tags e.g. ["tag1", "tag2", etc.]
    tag_array.each do |input_tag|
      unless self.tags.any? { |tag| tag.name == input_tag.downcase }
        self.tags.push(Tag.find_or_create_by_name(name: input_tag.downcase ))
      end
    end
  end

  def fix_datetime
    ar_time = self.created_at.to_s
    DateTime.parse(ar_time).strftime("%a, %b %e at %l:%M %p")
  end
  
  # def set_author(anonymity)
  #   unless anonymity
  #     self.author = current_user.username
  #   end
  # end

  #if user selects anonymous, then post.author should be blacnk
  #else, post.author should be user.username

end


# list_tags => "tag1, tag2, tag3"
# post.add_tags(['tag1', 'tag2', 'tag3'])
## post.tags => [tag1, tag2, tag3] assocoiates 3 tag objects 
