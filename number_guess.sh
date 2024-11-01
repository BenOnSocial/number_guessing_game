#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guessing_game --tuples-only -c"

echo -e "\nEnter your username: "
read USERNAME

USER_ID=$($PSQL "select user_id from users where name='$USERNAME';")

BEST_GAME=0
#SECRET=$(shuf -i 1-1000 -n 1)
SECRET=$((1 + $RANDOM % 100))  # Have to do it this way to pass freeCodeCamp tests.
