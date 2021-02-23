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
  @cohort = STDIN.gets.chomp.downcase.to_sym
  # check whether user has input an real cohort (or made a typo/input some other value)
  while !@cohorts.include?(@cohort)
    # set default to current cohort in case field is left empty
    # in a real-world scenario it would make more sense to have a separate varaible to store current cohort
    if @cohort.empty?
      @cohort = :march
      break
    end
    puts "Invalid cohort entered. Enter a valid month name: "
    @cohort = STDIN.gets.chomp.downcase.to_sym
  end
end

def input_students
  input_instructions
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    input_cohort
    # add the student hash to the array
    @students << {name: name, cohort: @cohort}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end
# 1. After we added the code to load the students from file, we ended up with adding the students to @students in two places. The lines in load_students()
# and input_students() are almost the same. This violates the DRY (Don't Repeat Yourself) principle. How can you extract them into a method to fix this problem?

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  ARGV.first.nil? ? filename = "students.csv" : filename = ARGV.first
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if there is no file by that name
    puts "Sorry, #{filename} doesn't exist"
    exit # quits the program
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

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp.to_i)
  end
end

def print_menu
  puts "1. Input students"
  puts "2. Show list of students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end
# 4. Right now, when the user choses an option from our menu, there's no way of them knowing if the action was successful.
# Can you fix this and implement feedback messages for the user?
def process(selection)
  case selection
    when 1
      puts "Inputting students: "
      input_students
    when 2
      puts "Listing students: "
      show_students
    when 3
      save_students
      puts "List saved to students.csv"
    when 4
      load_students
      puts "List loaded from students.csv"
    when 9
      puts "Exiting program"
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

try_load_students
interactive_menu
