class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  before_create :create_remember_token
  before_save { email.downcase! }
  validates(:name, presence: true, length: { maximum: 50 })
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates(:email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness:  { case_sensitive: false })
  has_secure_password
  validates :password, length: { minimum: 6 }
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  has_attached_file :avatar, 
  :styles => {
    :medium   => ['115x115#',  :jpg, :quality => 70],
    :small    => ['75x75#',    :jpg, :quality => 70],
    :tiny     => ['50x50#',    :jpg, :quality => 70]
  },
  :convert_options => {
    :medium   => '-set colorspace sRGB -strip',
    :small    => '-set colorspace sRGB -strip',
    :tiny   => '-set colorspace sRGB -strip'
  },
  :default_url => "/images/:style/missing.png"

  validates_attachment :avatar,
    #:presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
