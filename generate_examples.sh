#!/bin/bash
# This file contains all the commands to generate the examples from the README

# Create example repo-account
mkdir mcfly
cd mcfly
git init

# Make a bunch of posts
MARTY="Marty McFly <marty.mcfly@hotmail.com>"
SLEEP="sleep"
#SLEEP="false"  # For testing purposes, to skip the sleeps

git commit --allow-empty --author="$MARTY" -m "Damn, I'm late for school!"
$SLEEP 60

git commit --allow-empty --author="$MARTY" -m "@docbrown, you don't just walk into a store and buy... plutonium. Did you rip that off?"
$SLEEP 120

echo "Deep down in Louisiana close to New Orleans
Way back up in the woods among the evergreens
There stood a log cabin made of earth and wood
Where lived a country boy named Johnny B. Goode
Who never ever learned to read or write so well
But he could play a guitar just like a-ringin' a bell

Go go
Go Johnny go go
Go Johnny go go
Go Johnny go go
Go Johnny go go
Johnny B. Goode" > johnny_b_goode.txt

git add johnny_b_goode.txt
git commit --allow-empty --author="$MARTY" -m "All right. This is an oldie, but, uh... well, it's an oldie where I come from.
I attached the lyrics to this post."
$SLEEP 100

git commit --allow-empty --author="$MARTY" -m "I guess you guys aren't ready for that yet...

But your kids are gonna love it."
$SLEEP 180

# Show the posts with various formattings
git log --pretty=format:"%Cblue%ad %Cgreen%aN %Creset%s" --date=human --compact-summary
echo
echo "--------------"
echo
git log --pretty=format:"%C(yellow)%h %Cgreen%aN%Creset (%Cblue%ad%Creset)%n%Creset%n%w(0,4,4)%B" --date=human --compact-summary

# Remove example repo-account
cd ..
rm -rf mcfly

