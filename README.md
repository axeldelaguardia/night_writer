# Night Writer/Reader

### Project Overview
---
Night Writing was first developed for Napoleon's army so soldiers could communicate silently without any light. This concept led to what we now know as Braille.

This program essentially takes in text as input from a .txt file and creates a new file containing the results in Braille. When running the program from the terminal, it is required to give two arguments afterwards. The first argument is the filepath of an existing .txt file containing text. The second argument is the name of the new file that will be created and will contain the Braille characters translated from english.

This program currently supports all 26 characters of the alphabet, as well as, its capitalized versions. It also supports several other grammatical characters, such as:

- ,
- ;
- :
- .
- !
- ( and )
- ?
- " "
- ' '
- \-

### Iteration 4
---
The two following features were added to iteration 4. 
1. *Extracting a File I/O class* - The File I/O functions were moved to a shared class. This was extracted a Parent Class along with the dictionary and commonly used methods.
2. *Support Capitalization* - Capitalization was added when in the ToBraille class by checking the incoming text for capitalized characters and added the corresponding Braille character to the array before converting it into braille. For the ToEnglish class, I used the '|' character to indicate that the character after it will need to be capitalized. I ran through the translation as I normally would, then just removed the '|' character and capitalized the following character. After testing with both, short strings and very long strings, everything seemed to work as expected.

### Extra Features
---
I wanted to catch an error when an incoming file that didn't exist was given as an argument. I found that I can rescue specific errors, meaning I can catch them and return a specific message if necessary. I found that it was a little tricky to test but ultimately with some assistance figured out how to fix and use it successfully. When this was completed, I also noticed it continued to run the program, which led to other errors. To fix these, I created a method that will exit the program in specific areas which should complete the error rescue fully.