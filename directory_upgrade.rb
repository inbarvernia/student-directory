@students = [] # an empty array accessible to all methods

def input_instructions
  puts "Please enter student name to add and hit return."
  puts "Then, enter that student's cohort month and hit return."
  puts "To finish, simply hit return without adding text."
end

# create list of possible cohorts
@cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]

def input_cohort
  # get cohort
  @cohort = gets.chomp.downcase.to_sym
  # check whether user has input an real cohort (or made a typo/input some other value)
  while !@cohorts.include?(@cohort)
    # set default to current cohort in case field is left empty
    # in a real-world scenario it would make more sense to have a separate varaible to store current cohort
    if @cohort.empty?
      @cohort = :march
      break
    end
    puts "Invalid cohort entered. Enter a valid month name: "
    @cohort = gets.chomp.downcase.to_sym
  end
end

def input_students
  input_instructions
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    input_cohort
    # add the student hash to the array
    @students << {name: name, cohort: @cohort}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = gets.chomp
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp.to_i)
  end
end

def print_menu
  puts "1. Input students"
  puts "2. Show list of students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
    when 1
      input_students
    when 2
      show_students
    when 3
      save_students
    when 4
      load_students
    when 9
      exit # this will cause the program to terminate
    else
      puts "Command not recognised, please try again"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort].capitalize} cohort)"
  end
end

def print_footer
  puts  "Overall, we have #{@students.count} great #{@students.count == 1 ? "student" : "students"}"
end

def show_students
  if !@students.empty?
    print_header
    print_student_list
    print_footer
  else
    puts "There are currently no students enrolled."
  end
end

interactive_menu
