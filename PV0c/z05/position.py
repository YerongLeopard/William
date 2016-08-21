import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
n = 100
data = np.loadtxt('./tmp.txt')
xs = data[:, 0]
ys = data[:, 1]
zs = data[:, 2]
for it in range(len(xs)):
	ax.scatter(xs[it], ys[it], zs[it], c='b', marker='o')
  	ax.text(xs[it],ys[it],zs[it],  '%s' % (str(it+1)))

ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
ax.set_zlabel('Z Label')

plt.show()
