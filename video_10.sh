#!/usr/bin/env python3
import matplotlib.pyplot as plt
import urllib 
import pickle
import numpy as np
import matplotlib.dates as mdates

'''  
	We are talking about the customization in the graph, such as rotating labels around the axis and 
	making subplot. 
	So, in order to modify the figure, you have to reference the figure in some way.
		
'''

'''
	ubplut2grid (
				(1, 1) it is a shape of the grid
				(0, 0) is the starting point of the plot	)
	
'''

def bytespdate2num(fmt, encoding = 'utf-8'):
	strconverter = mdates.strpdate2num(fmt)
	def bytesconverter(b):
		s = b.decode(encoding)
		return strconverter(s)
	return bytesconverter


def graph_date(stock):
	fig = plt.figure()
	ax1 = plt.subplut2grid((1,1), (0, 0) )
	#stock_price_url = 'http://chartapi.finance.yahoo.com/instrument/1.0/'+stock+'/chartdata;type=quote;range=10y/csv'
	stock_price_url = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/5y?format=csv'
	source_code = urllib.request.urlopen(stock_price_url).read().decode()
	stock_data = []
	split_source = source_code.split('\n')
	
	for line in split_source:
		split_line = line.split(',')
		stock_data.append(line)		
		#print(stock_data)
	date, openp, highp, lowp, closep, volume = np.loadtxt(stock_data, 
														delimiter = ',', 
														unpack=True,
														skiprows=1,
														usecols=(0,1,2,3,4,5),
														converters={0:bytespdate2num('%Y-%m-%d')})
	
	plt.plot_date(date, openp, '-')
	plt.title('Tesla Motors Stock Price, 5 years')
	plt.xlabel('Date')
	plt.ylabel('Price')
	plt.legend("TSLA")
	plt.show()


graph_date('TSLA')

