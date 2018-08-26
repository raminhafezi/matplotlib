#!/usr/bin/env python3
import matplotlib.pyplot as plt
import urllib 
import numpy as np
import matplotlib.dates as mdates
''' 
	We are talking about how to get data from internet and then show the data in a graph.
	we are using numpy and YAHOO! finnace API as a data source to fetch stock prices.
	We are charting Tesla Motors Stock price in last 5 years. We are charting its opening price per date.
	
	Run this file from terminal. Doesnot work with 'run' in geany
		
'''

'''
	date,open,high,low,close,volume,unadjustedVolume,change,changePercent,vwap,label,changeOverTime
	---		---		---		---		---		---		---		---		---		---		---		---		---		 
	2013-08-26,165.15,173,160.25,164.22,24090136,24090136,2.381,1.471,167.2941,"Aug 26, 13",0
	2013-08-27,162.3,168.8,160.9501,167.01,17533355,17533355,2.79,1.699,165.8064,"Aug 27, 13",0.0169894044574351
	2013-08-28,169.06,171.5,163.25,166.45,14717990,14717990,-0.56,-0.335,166.8188,"Aug 28, 13",0.013579344781390754
	2013-08-29,164.215,167.75,162.51,166.06,9437465,9437465,-0.39,-0.234,165.5935,"Aug 29, 13",0.011204481792717108
	2013-08-30,166.37,169.21,163.96,169,11005799,11005799,2.94,1.77,167.0406,"Aug 30, 13",0.02910729509194983
	2013-09-03,173.4,173.7,166.4,168.94,12036366,12036366,-0.06,-0.036,170.5273,"Sep 3, 13",0.02874193155523078
	
	Here is what we get from TSLA stock price for 5 years
	notice that each line ended with \n
	and data in each line seperated with , 
	
'''
def bytespdate2num(fmt, encoding = 'utf-8'):
	strconverter = mdates.strpdate2num(fmt)
	def bytesconverter(b):
		s = b.decode(encoding)
		return strconverter(s)
	return bytesconverter

def graph_date(stock):
	
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
	plt.title('Interest Graph chart')
	plt.xlabel('Date')
	plt.ylabel('Price')
	plt.legend()
	plt.show()


graph_date('TSLA')
