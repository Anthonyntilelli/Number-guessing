# Number_guessing - Random number guessing game

## Table of Contents
1. [Description](#Description)
2. [Parameters](#Parameters)
3. [Examples](#Examples)
4. [Exit status](#Exit_status)
5. [Requirements](Requirements)
6. [Authors](#Authors)
7. [Reference](#Reference)

## Description                <a name="Description"></a>

Computer will choose a random number between 0 to 100 by default. The user will
have guess the number and the computer will respond with greater, lower or
correct number. Score is based on the number of guesses/attempts required to
choose correct number.

Input:
- 'Q!' - quit Program
- 'N!' - New Game
- Valid integer - number guess

## Parameters:               <a name="Parameters"></a>

    Usage: number_guessing [options]
        -m, --min INTEGER                Set Minimum number
        -M, --Max INTEGER                Set Maximum number
        -D, --Debug INTEGER              Set hidden number
        -h, --help                       Prints this help

## Examples:                  <a name="Examples"></a>

  `ruby number_guessing.rb`

  `ruby number_guessing.rb -m -50 -M 500`

  `ruby number_guessing.rb -D 25`

## Exit status:               <a name="Exit_status"></a>

     0 Success
     1 General Failure or incorrect parameter provided (varied Message)
     3 Invalid Command line arguments (varied message)
     4 Invalid input after guess
     
## Requirements              <a name="requirements"></a>

-  Ruby 2.4+

## Authors:                  <a name="Authors"></a>

- Anthony Tilelli
