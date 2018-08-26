#!/usr/bin/env python
import matplotlib.pyplot as plt
''' 
	We are trying  to make histagram and barchart
	
'''

'''__________BARS Chart__________ 
x = [1, 3, 5, 7, 9]
y = [6, 8, 3, 2, 9]

x2 = [2, 4, 6, 8]
y2 = [11, 4, 6, 9 ]

plt.bar(x, y, label = "Bars one", color = 'grey')
plt.bar(x2, y2, label = "Bars Two", color = 'red')

plt.xlabel('X')
plt.ylabel('Y')
plt.title('Interesting Graph\n Check it out')

plt.legend()
plt.show()

'''

'''_______________Histogram_____________ '''
#Histogram is used to show the distribution of the one thing

population_ages = [112, 65, 98, 34, 67, 90, 42, 46, 74, 82, 98, 68, 121, 117, 45, 76, 82, 93, 52, 58, 69, 23, 83, 37, 45, 67, 78, 34, 56, 90]

ids = [x for x in range(len(population_ages))]

#plt.bar(ids, population_ages, label="Age and the IDs", color = "brown")
#So the bars can not help us with useful information, we are trying to see how many elderies we have, how many middle-ages we have
# and also see how many teenagers and babies we have, so we have to do it in histogram to show us the distribution of the data

basket = [x for x in range(140) if x % 10 ==0 ]
print(basket)

plt.hist(
		population_ages, 
		basket, 
		histtype = "bar", 
		rwidth=0.8, 
		label="Histogram bar charts for distribution of Age")


plt.xlabel('ages')
plt.ylabel('age_group')
plt.title('Histogram bars chart\n Check it out')

plt.legend()
plt.show()
