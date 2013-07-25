class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :gists
  
  acts_as_voter

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(name: auth.extra.raw_info.name,
        oauth_token: auth.credentials.token,
        oauth_secret: auth.credentials.secret,
        provider: auth.provider,
        uid: auth.uid,
        email: "#{auth.info.nickname}@twitter.oauth",
        name: auth.info.nickname,
        image: auth.info.image,
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def karma
    gists.map(&:cached_votes_score).sum
  end

  def gravatar_url(size=80)
    # Temp special case for eLife
    if email == 'staff@elifesciences.org'
      '/images/elife_logo.png'
    else
      hash = Digest::MD5.hexdigest(email.downcase)
      "http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=#{CGI.escape('http://sciencegist.com/images/default_profile.png')}"
    end
  end
end
