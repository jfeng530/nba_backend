<p align="center"><img width=50% src="https://i.imgur.com/6Ky5MZE.png"></p>
<p>
  <img align="center" src="https://img.shields.io/badge/Postgresql-12.1-336791">
  <img align="center" src="https://img.shields.io/badge/React.JS-16.12.0-61DAFB">
  <img align="center" src="https://img.shields.io/badge/React Redux-7.1.3-764ABC">
  <img align="center" src="https://img.shields.io/badge/Ruby-2.6.1-CC342D">
  <img align="center" src="https://img.shields.io/badge/Ruby%20On%20Rails-6.0.1-cc0600">
</p>

# Contents
- [Overview](#overview)
  - [Description](#description)
  - [Features](#features)
  - [Challenges](#challenges)
  - [Technologies & Frameworks](#technologies-and-frameworks)
- [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Instructions](#instructions)
- [Credits](#credits)

&nbsp;

# Overview
  ### Description
  NBA Showdown is an NBA statistics and simulation web application. Utilizing Ruby on Rails, React and React Redux, NBA Showdown dynamically renders and displays statistics of any player and any team from 1979 to 2019 as well as simulate a game between any two teams.
  
  ### Features
  - Features all teams and players in the NBA from 1979 to 2019
  - Search for and view season totals and averages of any NBA player
  - View season totals and averages of any NBA team
  - Compare statistics of any two NBA players and any two NBA teams (with season totals and season averages)
  - Simulate a game between two NBA teams from any season & view the box score of the simulated game
  
  ### Challenges
  - The data in the reference API used to create the back-end did not include season totals for players.
    - Required mapping over all players and comuting their season totals and thus their averages as well.
    - Had to account for a player that was traded mid-season (each team played for that year would represent a new instance of season)
    - Function written to compute season totals was an O(n²) algorithm
  - Simulation algorithm needed to return accurate and realistic statistics that reflect a player's performance from that year
    - Decided on 'Normal Probability Model' as foundation for algorithm
    - Used gems [Rubystats](https://github.com/phillbaker/rubystats) and [Ruby Native Statistics](https://github.com/corybuecker/ruby-native-statistics) to randomly generate a statistic based on normal distribution (relative to player's season performance)
    
  ### Technologies and Frameworks
  #### Front-End
  - [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
  - [React](https://reactjs.org/)
  - [React Redux](https://react-redux.js.org/)
  - [React Router](https://reacttraining.com/react-router/)
  - [Semantic UI](https://semantic-ui.com/)
  
  #### Back-End
  - [Ruby](https://www.ruby-lang.org/en/)
  - [Ruby on Rails](https://rubyonrails.org/)
  - [PostgreSQL](https://www.postgresql.org/)
  - [Rubystats](https://github.com/phillbaker/rubystats)
  - [Ruby Native Statistics](https://github.com/corybuecker/ruby-native-statistics)

&nbsp;
 
# Installation
  ### Prerequisites
  NBA Showdown is built on React, Ruby, Ruby on Rails & PostgreSQL. Make sure you have the latest versions of all four components installed before cloning this repo. You can find their official installation guides below:
  - [React](https://reactjs.org/docs/getting-started.html)
  - [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
  - [Ruby On Rails](https://guides.rubyonrails.org/v5.0/getting_started.html)
  - [PostgreSQL](https://www.postgresqltutorial.com/)
  
  ### Instructions
  - Clone the most recent branch in this repository
  - Run `npm install` in your bash-enabled terminal to make sure all dependancies are installed
  - Run `npm start` to start and launch local server on your browser

&nbsp;

# Credits
  - [balldontlie API](https://www.balldontlie.io/)
  - Abraham Rabinowitz

# License
<a href="https://github.com/jfeng530/nba_frontend/blob/master/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/jfeng530/nba_frontend?color=blue"></a>

Copyright 2019 © [Jacky Feng](https://github.com/jfeng530)
