class User < ApplicationRecord
  enum kind: %i[knight wizard]
  validates :level, numericality: { greater_than: 0, less_than_or_equal_to: 99 }

  def title
    "#{nickname} the #{kind} ##{level}"
  end
end
