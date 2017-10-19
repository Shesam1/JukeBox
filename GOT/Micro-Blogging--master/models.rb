class PhotoUploader < CarrierWave::Uploader::Base
	storage :file
end

class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	has_many :followers, class_name: "Following" #, foreign_key: :follower_id
	has_many :followees, class_name: "Following" #, foreign_key: :followee_id

	mount_uploader :photo, PhotoUploader
end
class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :user

	mount_uploader :photo, PhotoUploader
end
class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
end
class Following < ActiveRecord::Base
	belongs_to :follower, class_name: "User" #, foreign_key: :follower_id
	belongs_to :followee, class_name: "User" #, foreign_key: :followee_id
end
