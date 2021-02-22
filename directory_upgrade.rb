def input_students
  puts "Please enter student name to add and hit return."
  puts "Then, enter that student's cohort and hit return."
  puts "To finish, simply hit return without adding text."
  # create an empty array
  students = []
  # create list of possible cohorts
  cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
  # get the first name
  name = gets.delete("\n")
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

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort].capitalize} cohort)"
  end
end

def print_footer(names)
  puts  "Overall, we have #{names.count} great #{names.count == 1 ? "student" : "students"}"
end

def interactive_menu
  students = []
  loop do
  # 1. print the menu and ask the user what to do
  puts "1. Input students"
  puts "2. Show list of students"
  puts "9. Exit"
  # 2. read the input and save it into a variable
  selection = gets.chomp.to_i
  # 3. do what the user has asked
  case selection
    when 1
      students = input_students
    when 2
      if !students.empty?
        print_header
        print(students)
        print_footer(students)
      else
        puts "There are currently no students enrolled."
      end
    when 9
      exit # this will cause the program to terminate
    else
      puts "Command not recognised, please try again"
  end
  # 4. repeat from step 1
  end
end

interactive_menu
