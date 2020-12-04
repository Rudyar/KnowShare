class UserMailer < ApplicationMailer
  default from: 'team.genepi.thp@gmail.com'

  def welcome_send(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue chez KnowShare !') 
  end
 
  def send_email_confirm_to_user(student, teacher, start_date, lesson_title)
    @student = student 
    @teacher = teacher
    @start_date = start_date
    @lesson_title = lesson_title
    mail(to: @student.email, subject: 'Votre nouvelle réservation !') 
  end

  def send_email_confirm_to_teacher(student, teacher, start_date, lesson_title)
    @student = student 
    @teacher = teacher
    @start_date = start_date
    @lesson_title = lesson_title
    mail(to: @teacher.email, subject: 'Une nouvelle réservation de cours !') 
  end
end
