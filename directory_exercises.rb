def input_student
  puts "Please enter student name to add."
  puts "To finish, simply hit return twice."
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :November}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print(students)
  # 3. Modify your program to only print the students whose name is shorter than 12 characters.
  students.each do |student|
    if student[:name].length < 12 
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# Nothing happens until we actually call the methods:
students = input_student
print_header
print(students)
print_footer(students)