class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :todo_lists, dependent: :destroy
  has_many :todo_items, through: :todo_lists, source: :todo_items

  validates :username, presence: true

  def get_completed_count
    todo_lists = TodoList.where(user_id: id)
    count = 0
    todo_lists.each do |x| 
      count += TodoItem.where(todo_list_id: x.id, completed: true).size
    end
    count
  end

  has_secure_password
end
