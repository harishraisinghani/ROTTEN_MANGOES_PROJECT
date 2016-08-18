class Movie < ApplicationRecord
  
  mount_uploader :image, ImageUploader

  has_many :reviews  

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :post_image_url, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  scope :search_by_title, -> (title) { where("title like ?", "%#{title}%")}
  scope :search_by_director, -> (director) { where("director like?", "%#{director}%")}
  scope :less_than_90, -> (duration) { where("runtime_in_minutes < ?", 90) if duration == '<90mins'}
  scope :between_90_120, -> (duration) { where("runtime_in_minutes >= ? AND runtime_in_minutes <= ? ", 90,120) if duration == 'Between 90 and 120 mins' }
  scope :greater_than_120, -> (duration) { where("runtime_in_minutes > ?", 120) if duration == '>120mins'}

  def review_average
    if reviews.size == 0
      return 0
    else 
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end


  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
