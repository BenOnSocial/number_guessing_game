drop table if exists games cascade;
drop table if exists users cascade;
drop database if exists number_guessing_game;

create database number_guessing_game;
alter database number_guessing_game owner to freecodecamp;

\connect number_guessing_game;

create table users(user_id serial primary key, name varchar(22) not null);

create table games(game_id serial primary key, user_id int references users(user_id) not null, guesses int not null);

alter table users owner to freecodecamp;
alter table games owner to freecodecamp;
