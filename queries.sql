/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE neutered = true AND escape_attempts <3;
SELECT name, escape_attempts FROM animals WHERE wight_kg >10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE wight_kg >=10.4 AND wight_kg <=17.3;
