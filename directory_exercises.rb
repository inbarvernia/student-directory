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
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print(students)
  # 4. Rewrite the each() method that prints all students
  # using while or until control flow methods (Loops).
  num = 0
  while num < students.length
    puts "#{students[num][:name]} (#{students[num][:cohort]} cohort)"
    num += 1
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# Nothing happens until we actually call the methods:
# students = input_student
print_header
print(students)
print_footer(students)