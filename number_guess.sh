#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guessing_game --tuples-only -c"

echo -e "\nEnter your username: "
read USERNAME

USER_ID=$($PSQL "select user_id from users where name='$USERNAME';")

