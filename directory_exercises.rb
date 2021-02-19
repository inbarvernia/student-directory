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
    # check whether user has input an real cohort (or made a typo/input some other value)
    while !cohorts.include?(cohort)
      # set default to current cohort in case field is left empty
      # in a real-world scenario it would make more sense to have a separate varaible to store current cohort
      if cohort.empty?
        cohort = :march
        break
      end
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
  puts "The students of Villains Academy"
  puts "-------------"
end
# 8. Once you complete the previous exercise, change the way the users are displayed: print them grouped by cohorts.
# To do this, you'll need to get a list of all existing cohorts (the map() method may be useful but it's not the only option),
# iterate over it and only print the students from that cohort.

# My note: This code works; however, it prints out the cohorts based on the order in which they were entered.
# In the future it would be interesting to get it to rearrange the cohorts based on calendar order.
def sort_students(students)
  # students_by_cohort = students.map { |student| }
  students_by_cohort = {}
  students.each do |student|
    cohort = student[:cohort]
    if students_by_cohort[cohort] == nil
      students_by_cohort[cohort] = []
    end
    students_by_cohort[cohort].push(student[:name])
  end
  return students_by_cohort
end
def print(students_by_cohort)
  students_by_cohort.each do |cohort, names|
    puts "#{cohort.capitalize} cohort:"
    names.each {|name| puts name}
  end
end
def print_footer(names)
  puts  "Overall, we have #{names.count} great #{names.count == 1 ? "student" : "students"}"
end
# Nothing happens until we actually call the methods:
students = input_student
students_by_cohort = sort_students(students)
print_header
print(students_by_cohort)
print_footer(students)