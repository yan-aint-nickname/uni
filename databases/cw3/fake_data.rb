# frozen_string_literal: true

require 'faker'
require 'date'

mode = ARGV[0].to_s

STUDENTS_AMOUNT = 11
INSTRUCTORS_AMOUNT = 3
LESSONS_AMOUNT = 22

# Generates students
class Student
  def self.generate(amount)
    amount.times do
      f = Faker::Name.unique.first_name
      l = Faker::Name.unique.last_name
      e = Faker::Internet.email(name: "#{f}#{l}", separators: ['-'])
      p = Faker::PhoneNumber.cell_phone_in_e164
      yield "('#{f}', '#{l}', '#{e}', '#{p}'),"
    end
  end
end

# Generates instructors
class Instructor
  def self.generate(amount)
    amount.times do
      f = Faker::Name.unique.first_name
      l = Faker::Name.unique.last_name
      e = Faker::Internet.email(name: "#{f}#{l}", separators: ['-'])
      p = Faker::PhoneNumber.cell_phone_in_e164
      license_number = Faker::IdNumber.brazilian_citizen_number
      yield "('#{f}', '#{l}', '#{e}', '#{p}', '#{license_number}'),"
    end
  end
end

# Generates lessons
class Lesson
  @statuses = %w[
    scheduled
    initial
    pay_error
    pay_success
    passed
    cancelled_by_student
    cancelled_by_instructor
    missed_by_student
    missed_by_instructor
  ]
  def self.generate(amount)
    amount.times do |i|
      student_id = Random.rand(1..STUDENTS_AMOUNT)
      instructor_id = Random.rand(1..INSTRUCTORS_AMOUNT)
      topic = "#{Faker::Lorem.sentence} #{Faker::Lorem.question}"
      scheduled = DateTime.now.next_day(i).strftime('%Y-%m-%d %H:%M:%S')
      yield "('#{student_id}', '#{instructor_id}', '#{topic}', '#{status}', '#{scheduled}'),"
    end
  end

  def self.status
    @statuses.sample
  end

  private_class_method :status
end

case mode
when 'students'
  puts 'Create records for `students` table'
  Student.generate(STUDENTS_AMOUNT) do |s|
    puts s
  end
when 'instructors'
  puts 'Create records for `instructors` table'
  Instructor.generate(INSTRUCTORS_AMOUNT) do |i|
    puts i
  end
when 'lessons'
  puts 'Create records for `lessons` table'
  Lesson.generate(LESSONS_AMOUNT) do |l|
    puts l
  end
else
  puts 'Unknown parameter'
end
