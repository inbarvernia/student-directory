# 7. In the input_students method the cohort value is hard-coded. How can you ask for both the name and the cohort?
# What if one of the values is empty? Can you supply a default value?
# The input will be given to you as a string. How will you convert it to a symbol?
# What if the user makes a typo?
def input_student
  puts "Please enter student name to add and hit return."
  puts "Then, enter that student's cohort and hit return."
  puts "To finish, simply hit return without adding text."
  # create an empty array
  students = []
  # create list of possible cohorts
  cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
  # get cohort
    cohort = gets.chomp.downcase.to_sym
    # set default to current cohort in case field is left empty
    # in a real-world scenario it would make more sense to have a separate varaible to store current cohort
    if cohort.empty?
      cohort = :march
    end
    # check whether user has input an real cohort (or made a typo/input some other value)
    while !cohorts.include?(cohort)
      puts "Invalid cohort entered. Enter a valid month name: "
      cohort = gets.chomp.downcase.to_sym
    end
    # add the student hash to the array
    students << {name: name, cohort: cohort}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(200, " ")
  puts "-------------".center(200, " ")
end
def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort].capitalize} cohort)".center(200, " ")
  end
end
# Right now if we have only one student, the user will see a message "Now we have 1 students", whereas it should be
# "Now we have 1 student". How can you fix it so that it used singular form when appropriate and plural form otherwise?
def print_footer(names)
  puts  "Overall, we have #{names.count} great #{names.count == 1 ? "student" : "students"}".center(200, " ")
end
# Nothing happens until we actually call the methods:
students = input_student
print_header
print(students)
print_footer(students)