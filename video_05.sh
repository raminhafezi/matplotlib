#!/usr/bin/env python
import matplotlib.pyplot as plt
from random import random, shuffle
''' 
	We are talking about stack plot , to show the size of use/ percentage in a whole
	our data is how much time we spending each day on 4 days.
	
	 
'''
days = ["Saturday", "Sunday", "Monday", "Tuesday","Wednesday", "Thursday", "Friday"]
sleeping = [10, 9, 7, 8, 9, 8, 9 ]
eating = [4, 4, 3, 2, 1, 2, 4]
playing = [8, 10, 4, 1, 6, 5, 3]
working = [2, 1, 10, 13, 8, 9, 8]

Colors = ["red", "blue", "black", "green"]
Labels = ["Sleeping", "Eating", "Playing", "Working"]

plt.stackplot(days, sleeping, eating, playing, working, colors = Colors , labels = Labels)

plt.xlabel('x')
plt.ylabel('y')
plt.title('Scatter chart\n Check it out')

plt.legend()
plt.show()
