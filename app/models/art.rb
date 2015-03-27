class Art < ActiveRecord::Base
    validates :art_id, presence: true
   validates :name, presence: true
    validates :description, presence: true
    validates :catagory, presence: true
    validates :size, presence: true
    validates :price, presence: true
    validates :url, presence: true
    
end
