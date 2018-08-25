#!/usr/bin/env python
import matplotlib.pyplot as plt
from random import random, shuffle
''' 
	We are talking about scatter graph, to show the correlation between two types of variables
	for customizing your scatter graph, google matplotlib marker options
	or have a look at this website https://matplotlib.org/api/markers_api.html
'''
x = [x for x in range(12)]
y = [x for x in range(12)]
shuffle(x)
shuffle(y)
print("X: {}, Y: {}".format(x, y))

plt.scatter(x, y, label="Skitscat", color = "red", marker = "d", s = 25)

plt.xlabel('x')
plt.ylabel('y')
plt.title('Scatter chart\n Check it out')

plt.legend()
plt.show()
