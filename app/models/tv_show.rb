class TvShow < ApplicationRecord
  STATUS = ["Canceled", "Ended", "In Production", "Returning series"].freeze

  acts_as_favoritable

  has_many :seasons, dependent: :destroy
  has_many :people, dependent: :destroy
  has_many :episodes, through: :seasons

  validates :tmdb_id, presence: true, uniqueness: true

  def updated_in_the_last?(period)
    updated_at > Time.now - period
  end

  def returning?
    status == "Returning"
  end

  def upcoming_episodes
    episodes&.upcoming
  end

  def aired_episodes
    episodes&.aired
  end

  def upcoming_episode
    upcoming_episodes&.last
  end

  def last_aired_episode
    aired_episodes&.last
  end

  def last_season
    seasons&.last
  end
end
