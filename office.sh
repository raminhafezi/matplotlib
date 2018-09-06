#!/usr/bin/env python
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
import math

fig = plt.figure()
ax1 = fig.add_subplot(111, projection='3d')

#x = list(range(1,1000))
#y = [math.log(i, 2) for i in x]
#z = [math.sin(i/10) for i in x]

x = [1,2,3,4,5,6,7,8,9,10]
y = [5,6,7,8,2,5,6,3,7,2]
z = np.array([[1,2,6,3,2,7,3,3,7,2],
			  [1,2,6,3,2,7,3,3,7,2]])

### This code generate this error, AttributeError: 'list' object has no attribute 'ndim'
### better to use numpy to generate data for 3d visualization
ax1.plot_wireframe(x,y,z)

ax1.set_xlabel('X axis')
ax1.set_ylabel('Y axis')
ax1.set_zlabel('Z axis')

plt.show()
