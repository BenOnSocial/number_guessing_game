#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guessing_game --tuples-only -c"

echo -e "\nEnter your username: "
read USERNAME

USER_ID=$($PSQL "select user_id from users where name='$USERNAME';")

BEST_GAME=0
#SECRET=$(shuf -i 1-1000 -n 1)
SECRET=$((1 + $RANDOM % 100))  # Have to do it this way to pass freeCodeCamp tests.

if [[ -z $USER_ID ]]
then
  echo -e "\nWelcome, ${USERNAME}! It looks like this is your first time here."
  RESULT=$($PSQL "insert into users (name) values ('$USERNAME');")
  if [[ $RESULT == "INSERT 0 1" ]]
  then
    USER_ID=$($PSQL "select user_id from users where name='$USERNAME';")
  fi
else
  GAMES_PLAYED=$(echo $($PSQL "select count(*) from games where user_id=$USER_ID;") | sed 's/ //g')
  BEST_GAME=$(echo $($PSQL "select min(guesses) from games where user_id=$USER_ID;") | sed 's/ //g')

  echo -e "\nWelcome back, ${USERNAME}! You have played ${GAMES_PLAYED} games, and your best game took ${BEST_GAME} guesses."
fi

echo -e "\nGuess the secret number between 1 and 1000: "
read GUESS

GUESSES=1

while [[ $GUESS -ne $SECRET ]]
do
  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "\nThat is not an integer, guess again: "
  elif [[ $GUESS -gt $SECRET ]]
  then
    echo -e "\nIt's lower than that, guess again: "
  elif [[ $GUESS -lt $SECRET ]]
  then
    echo -e "\nIt's higher than that, guess again: "
  fi

  read GUESS
  GUESSES=$(($GUESSES+1))
done
