require 'csv'

@students = [] # an empty array accessible to all methods
@filename = "" # a filename variable accessible to all methods

def input_instructions
  puts "Please enter student name to add and hit return."
  puts "Then, enter that student's cohort month and hit return, or leave it blank and press return to default to current cohort."
  puts "To finish, simply hit return without adding text."
end

def input_cohort
  # get cohort
  @cohort = STDIN.gets.chomp.downcase
  # list of cohorts
  cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
  # check whether user has input an real cohort (or made a typo/input some other value)
  while !cohorts.include?(@cohort.to_sym)
    # set default to current cohort in case field is left empty
    # in a real-world scenario it would make more sense to have a separate varaible to store current cohort
    if @cohort.empty?
      @cohort = "march"
      break
    end
    puts "Invalid cohort entered. Enter a valid month name: "
    @cohort = STDIN.gets.chomp.downcase
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
    add_student(name, @cohort)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def file_to_load
  puts "Enter the file you would like to load from: "
  @filename = STDIN.gets.chomp
  load_students(@filename)
end

def load_students(filename = "students.csv")
  if File.exists?(@filename)
    @students = [] # deleting students previously loaded from other files or manually entered
    CSV.foreach(@filename) do |line|
      add_student(*line)
    end
    puts "Loaded #{@students.count} from #{@filename}"
  else
    puts "Sorry, #{@filename} doesn't exist"
    user_choice
  end
end

def user_choice
  puts "Would you like to load a different file?"
  loop do
    choice = STDIN.gets.chomp.downcase
    case choice
      when "yes"
        file_to_load
        break
      when "no"
        puts "Loading cancelled"
        break
      else puts "Command not recognised; please enter 'yes' or 'no'."
    end
  end
end

def load_on_startup
  ARGV.first.nil? ? @filename = "students.csv" : @filename = ARGV.first
  puts "Loading student list from #{@filename}"
  load_students(@filename)
end

def save_students
  puts "Enter the file you would like to save to: "
  @filename = STDIN.gets.chomp
  # open the file for writing
  CSV.open(@filename, "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
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
