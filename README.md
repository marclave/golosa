# Golosa
Golosa is a Ruby [Shoes](http://shoesrb.com/) application, designed for language-learners to use as a vocabulary aid. Generally a dictionary is too inconvenient and cumbersome to use when starting out learning a language. Use Golosa to keep track of the vocabulary words (and their translations) that are important to you.

## Getting Started

#### If Shoes and Rake are installed

2. Via the command line, navigate to the directory that you would like to build Golosa

3. Run these commands in order

        > git clone https://github.com/swcraig/golosa
        > rake install
        > shoes personal.rb

#### If Shoes and Rake are not installed
These instructions are super sketchy until I figure out a better way to do this...

1. Download the [v1.0.0 release of Golosa](https://github.com/swcraig/golosa/releases/tag/v1.0.0) (only Golosa.exe and config.yml, not the Source code)

2. In your home directory create a folder named "Golosa" and put config.yml in it **

3. Using a text editor, edit the line in config.yml to your preference (Include the " marks <strong>exactly</strong> where they are shown!)

  For example if my home directory was C:/Users/Cole and I wanted to set the dictionary up for German my config.yml would look <strong>exactly</strong> like

        {"languages":["german"],"path":"C:/Users/Cole/Golosa"}

  Or, if my home directory was C:/Users/Teddy and I wanted to set the dictionary up for Russian and Afrikaans my config.yml would look <strong>exactly</strong> like

        {"languages":["russian", "afrikaans"],"path":"C:/Users/Teddy/Golosa"}

4. Run Golosa.exe

  Shoes is included in this executable and will start to download.  If the download stops indefinitely, all is well, click "cancel" and run Golosa.exe again. Golosa will start without any issue.

5. Start to use Golosa daily and become a polyglot

<sub>Installation instructions were tested on Windows 7</sub>  

<br>

** To find your home path, open the Command Prompt and enter

              echo %HOMEPATH%

It should be something like "C:/Users/Curtis"

<sub>Development was done with Shoes 3.2.21</sub>
