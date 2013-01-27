class Paper < ActiveRecord::Base
  attr_accessible :abstract, :abstract_html, :metadata, :title, :user_id
  serialize :metadata, ActiveRecord::Coders::Hstore
end
