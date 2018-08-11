#!/usr/bin/env python
import matplotlib.pyplot as plt

x = [1,2,3]
y = [9,6,2]

x2 = [1,2,3]
y2 = [10, 12, 15]

plt.plot(x, y, label = 'My Income')
plt.plot(x2, y2, label = 'My Expense')
plt.xlabel('Plot Number')
plt.ylabel('Important var')
plt.title('Interesting Graph\n Check it out')

plt.legend()
plt.show()
