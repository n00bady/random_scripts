#!/bin/bash
#guess.bash - number guessing game in bash

scorefile="highscores_bash"
guess=-1
typeset -i num=0

echo -e "guess.bash - Guess a number between 1 and 100\n"

# Generate random number
((answer = RANDOM % 100 + 1 ))

# Play the game
while (( guess != answer ));
do
	num=num+1
	read -p "Enter guess $num: " guess
	if (( guess < answer ));
	then
		echo "Higher..."
	elif (( guess > answer ));
	then
		echo "Lower..."
	fi
done
echo -e "Correct! That took $num guesses.\n"

# Save high score 
read -p "Please enter your name: " name
echo $name $num >> $scorefile

# Print high scores
echo -e "\nPrevious high score!"
cat $scorefile

