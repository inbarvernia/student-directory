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

# 5. The filename we use to save and load data (menu items 3 and 4) is
# hardcoded. Make the script more flexible by asking for the filename if the
# user chooses these menu items.

# creating a filename variable that can be accessed from multiple methods:
@filename = String.new

def file_to_load
  puts "Enter the file you would like to load from: "
  @filename = STDIN.gets.chomp
  load_students(@filename)
end

def load_students(filename = "students.csv")
  if File.exists?(@filename)
    @students = [] # deleting students previously loaded from other files or manually entered
    file = File.open(@filename, "r")
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort.to_sym}
    end
    file.close
    puts "Loaded #{@students.count} from #{@filename}"
  else
    puts "Sorry, #{@filename} doesn't exist"
    file_to_load
  end
end

def load_on_startup
  ARGV.first.nil? ? @filename = "students.csv" : @filename = ARGV.first
  load_students(@filename)
end

def save_students
  puts "Enter the file you would like to save to: "
  @filename = STDIN.gets.chomp
  # open the file for writing
  file = File.open(@filename, "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "List saved to #{@filename}"
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
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
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
      file_to_load
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

load_on_startup
interactive_menu
