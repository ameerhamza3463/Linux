
echo "Hamza"  #Print output in the terminal
echo -n "Hamza"  #Print output with no new line in the terminal
echo -e "Hamza"  #Print output with backslash escapes enabled \n for line break in the terminal


pwd # Print present/current working directory
cd # Change to home directory
cd ~ # Move to user's home directory
cd .. # Move into previous/parent directory

# Absolute vs Relative Paths
# Absolute paths start with / Defines complete path of the file and works from everywhere
# Relative paths are resolved according to our current working directory

ls
ls -a  # all files including hidden (.) files
ls -r # list in reverse order
ls -t # list and sort with respect to modification time of file
ls --color


# Execute multiple commands. We use a semi-colon and execute multiple commands 
# command1; command2;
echo -n 'Hello'; echo 'World'


# How to get help?
# For a lot of commands, we can just add a -h or a --help. For example: ls --help
# We can also check the built-in manuals. For example: man ls


## User Management

# In linux, users can be categorized into three general categories:
# 1. System accounts (Webserver, DB): They are responsible for running background tasks on your system. They don't have a home directory
# 2. Regular users: They have access to their own files and directories. They can't access other user's files unless permissions are given
# 3. Superuser (root): The superuser (root) has unrestricted access to the entire system (including files in the home directories of regular users). It can add / remove users, install software. It can change the configuration of the system.

# Elevate your privileges using sudo
# If we want to temporarily elevate our privileges, we can put a sudo in front of our command. For example: sudo ls /root
# If sudo doesn't work, In this case, you might want to create a new user and give this user administrative privileges

## Package Management
# Most Linux distributions offer a centralized way to install software. This process is called package management. Our system connects to centralized repositories, they provide a list of available packages (including available versions, and their dependencies)
# 1. Ubuntu
#   apt update (Refresh list of available packages), apt upgrade (Small upgrade existing packages), apt full-upgrade or apt dist-upgrade (Large system upgrade), apt-get
#   apt install [package], apt remove [package], apt autoremove (removes packages that are no longer needed)
# 2. CentOS
#   dnf upgrade or dnf update (Fetches latest version of the packages and upgrades system)
#   dnf install [package], dnf remove [package]

## FILE MANAGEMENT
touch file   # Create a new empty file
mkdir Folder    # Create an empty directory/folder
mv <sourcefilepath> <destinationfilepath>
cp <sourcefilepath> <destinationfilepath>
cp -R <sourcefolderpath> <destinationfolderpath>  # Copies the whole Folder
rm <file>        # Delete a file
rmdir <folder>   # Delete an Empty directory


# Globbing recognizes and expands pre-defined wildcard characters, it searches for files that match this pattern and it allows to easily access multiple files. Wildcard characters must not be quoted.
# * (anything after wildcard inclusive), ? (matches any single character), [0-9] -> The square brackets allow us to specify a character range (here: all numbers)
# Bash doesn't differentiate between a folder and a parameter. 

## The find program
# Instead of searching by name, we can use the find program for a more sophisticated search
find <path> -type f     # If we want to see only file types
find <path> -type d     # If we want to see only directories types
find <path> -type f -mtime 7     # If we want to see only file types that are modified within the last 7 days
find <path> -type f -size +10M   # If we want to see only file types that are larger than 10 MB
find <path> -empty -delete       # Delete all empty files


## FILE MANAGEMENT PART 2 (TEXT FILES)
cat data.txt      # cat command allows to print contents of the file
head -n 5 data.txt      # head command allows to print the specified number of lines (-n 5) from top of the file
tail -n 5 data.txt      # tail command allows to print the specified number of lines (-n 5) from bottom of the file
less                    # Allows to read large files, we can use arrow keys to navigate through the file Or we can use f (forward) and b (backward) to navigate a whole page ahead or back
# Common Navigation Keys for less
# Space → Next page
# b → Previous page
# Enter → Move down one line
# g → Go to beginning of file
# G → Go to end of file
# /text → Search for text
# n → Next search result
# q → Quit
# While inside less, type: 50% This moves to 50% of the file


## WORD COUNT
wc file
wc -lwc file  # (wordcount) Prints out the number of lines, the number of words, and the number of bytes in the file. We can use each tag, separately as well
du <folder>        #  It will calculate the size of all items in this folder


## HOW TO EDIT FILES
# There's no builtin text editor for bash. We have to install additional software for that.
# 4 quite popular options are:
# pico / nano: A simple editor for text files in bash
# vi / vim: A more advanced text editor


## Overview: Streams



# HOW TO WRITE OUTPUT TO A FILE
echo "Test content" > test.txt   # If file doesn't exist, it will be created. If there is already some content in file, it will be overwritten.
echo "2nd Test content" >> test.txt     # To append to a file, we can use ">>" instead of ">"


## Standard streams: stdin, stdout, stderr
# By default, there are 3 communication channels for data:
# ►0: standard input (from the keyboard); stdin
# ►1: standard output (on the screen); stdout
# ►2: standard error output (on the screen); stderr
# By using ">" or ">>", we can redirect the stdout to a file

# However, there's also a more verbose way to do this:
du -h IMG_9328.jpg 1> output.txt   # Here 1 represents channel 1 (stdout)
# We can use this way to also redirect stderr (2):
du -h IMG_9328.jpg 2> error.txt    # Here 2 represents channel 2 (stderr)
# We can also combine those:
du -h IMG_9328.jpg > output.txt 2> error.txt
# How can we redirect stderr to stdout?
# &1 stands for: current stdout
[command] 2>&1
[command] > out.txt 2>&1

# How to redirect a file to stdin
# We can also use redirects! 
wc -l < out.txt
# However, a lot of Unix tools can work with files directly
wc -l out.txt      # Provide a file as input to a command


## PIPES: The pipe is a mechanism that passes the output of one command as input to another command
# tee: The tee command in Linux/Unix is used to: Display output on the terminal and simultaneously write it to a file.
echo 'Hello World!' | tee hello.txt        # Show output in terminal and write in file at the same time
echo 'Hello World!' | tee -a hello.txt     # Show output in terminal and append in the file

## sort: sort the contents in a file or stdin
# uniq: uniq only checks for consecutive lines with the same content
sort <filename>         # sorts in alphabetical order with priority of capital alphabets, small alphabets, numbers
sort -r <filename>      # sort in reverse alphabetical order
sort -n <filename>      # sort numbers according to numerical order
sort -c <filename>      # checks whether the contents in a file are sorted and find unsorted elements
sort -k column_number <filename>  # sort data by a specific column
sort <filename> | uniq  # uniq only checks for consecutive content (!) lines with the same
# same can be done using sort -u <filename>
sort <filename> | uniq -d   # Find duplicate lines in a file


## grep: Grep is a tool that can find a pattern in an output or a file. Grep works with all types of files, so we can technically grep on a binary file as well but we shouldn't
grep -F 'pattern' <filename>
cat <filename> | grep -F 'less'


# HOW TO WORK WITH STRINGS?
echo 'bash' | tr 'b' 'd'           # Replace b with d. Here tr represents translate
echo 'awesome' | tr 'a-z' 'A-Z'    # Convert lowercase to uppercase
echo 'Bash is amazing' | tr -d ' ' # To delete characters, here we are deleting spaces
echo 'Was it a cat I saw?' | rev   # To reverse a string

# cut: It allows us to process and extract data from a file or standard input 
uptime | cut -b 1-10    # Cutting by bytes (b), Here, we select the bytes 1-10 from each line of the input
cut -c                  # Cutting by characters (c).  It otherwise works exactly as we would cut by bytes


# sed: The tool sed allows us to easily execute commands on a file or on stdin, Those commands can modify the string, used to search text, replace text, edit files, filter output
sed 's/apple/orange/' file.txt       # Replace first occurrence in each line. This doesn't update the original file but only prints the updated content in output terminal.
sed 's/apple/orange/g' file.txt      # Replace all occurrences globally. This doesn't update the original file but only prints the updated content in output terminal.
sed -i 's/apple/orange/g' file.txt   # Using -i flag represents in-place edit and modifies the content in actual file. Replace all occurrences globally. This doesn't update the original file but only prints the updated content in output terminal.
sed '3d' file.txt                    # Delete a specific line from the file
sed '/^$/d' file.txt                 # Delete empty lines



# SHELL
# General Definition: A shell is the Outer layer of the operating system. It takes commands from the user and translates them into a form that the kernel can understand. It can also display the result of those commands to the user
#  The shell environment is a collection of settings, variables, aliases, and configurations. It defines the context in which our programs are run.

# What are environment variables:
#   Used to store configuration information and settings
#   They influence the shell and program behavior
# By convention: Environment variables are written in uppercase letters

# Important environment variables: 
#   HOME: Stores current user's home directory
#   PWD: Stores the current working directory path
#   USER: Stores the current user's username
#   PATH: The environment variable PATH is one of the most important variables in our shell. Stores a list of directories. Directories searched for executable programs. Directories are searched from left to right


env          # List all environment variables
# HOW TO SET/UNSET Environment Variables
export VAR=value       # We can use the export command to create an environment variable:
VAR=new-value        # We can also overwrite an existing variable:
unset VAR              # Delete an environment variable




# Usually, to add a new directory where our executable files exist, we want to append a directory to our PATH:
# PATH="${PATH}:/new/path"

which <programname>    # To find a program, e.g. which sed   --> /usr/bin/sed


# alias: We can use an alias to shorten our command
# An alias is only valid within the current session. We can add it to a startup file, so it is loaded every time we start our shell
alias gohome='cd ~'
alias                    # To list existing aliases
unalias gohome           # To remove an alias




whois <domain>
ifplugstatus       # Shows if your interfaces are working or not








