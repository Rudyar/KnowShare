class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,  presence: true,
                        uniqueness: true

  has_many  :lessons, dependent: :destroy
  has_many  :bookings, dependent: :destroy
  has_many  :followed_lessons,
            through: :bookings,
            foreign_key: 'followed_lesson_id',
            class_name: 'Lesson',
            dependent: :destroy

  has_one_attached :avatar

  before_create :assign_student_role

  def role_include?(searched_role)
    role.split.include?(searched_role)
  end

  def student?
    role_include?('student')
  end

  def teacher?
    role_include?('teacher')
  end

  def assign_teacher_role
    new_role = role + ' ' + 'teacher'
    update(role: new_role)
  end

  def has_first_name?
    self.first_name
  end

  def has_last_name?
    self.last_name
  end

  def has_description?
    self.description
  end 
  
  private

  def assign_student_role
    self.role = 'student'
  end
end
