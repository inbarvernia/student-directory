# def input_student
#   puts "Please enter student name to add."
#   puts "To finish, simply hit return twice."
#   # create an empty array
#   students = []
#   # get the first name
#   name = gets.chomp
#   # while the name is not empty, repeat this code
#   while !name.empty? do
#     # add the student hash to the array
#     students << {name: name, cohort: :November}
#     puts "Now we have #{students.count} students"
#     # get another name from the user
#     name = gets.chomp
#   end
#   # return the array of students
#   students
# end
students = [
  # 5. Our code only works with the student name and cohort. Add more information: hobbies, country of birth, height, etc.
  {name: "Dr. Hannibal Lecter", cohort: :november, hobby: "cooking"},
  {name: "Darth Vader", cohort: :november, hobby: "using the Force"},
  {name: "Nurse Ratched", cohort: :november, hobby: "caring for others"},
  {name: "Michael Corleone", cohort: :november, hobby: "making people offers they can't refuse"},
  {name: "Alex DeLarge", cohort: :november, hobby: "a bit of the old ultra-violence"},
  {name: "The Wicked Witch of the West", cohort: :november, hobby: "flying"},
  {name: "Terminator", cohort: :november, hobby: "terminating"},
  {name: "Freddy Krueger", cohort: :november, hobby: "making new friends"},
  {name: "The Joker", cohort: :november, hobby: "practical jokes"},
  {name: "Joffrey Baratheon", cohort: :november, hobby: "being a dick"},
  {name: "Norman Bates", cohort: :november, hobby: "spending time with family"}
]
# 6. Research how the method center() of the String class works. Use it in your code
# to make the output beautifully aligned.
def print_header
  puts "The students of Villains Academy".center(200, " ")
  puts "-------------".center(200, " ")
end
def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort), who likes #{student[:hobby]}".center(200, " ")
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(200, " ")
end
# Nothing happens until we actually call the methods:
# students = input_student
print_header
print(students)
print_footer(students)