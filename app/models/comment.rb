class Comment < ApplicationRecord
  belongs_to :prototype  #prototypesテーブルとのアソシエーション（属している）
  belongs_to :user
  validates :text, presence: true
end
