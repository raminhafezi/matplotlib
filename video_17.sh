#!/usr/bin/env python3
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import matplotlib.ticker as mticker
#from matplotlib.finance import candlestick_ohlc
from mpl_finance import candlestick_ohlc
from matplotlib import style
 
import urllib
import numpy as np

'''  
	In this video we are talking about adding text to the plot.
	
	----> ax1.text(x location, y location, 'text')
	the usage of the text on axise would be the formula of the graph, or the copyright.
	
	---> we can also use another funtion named "annotate"
	The good thing about the annotation is that we can use the fraction of the axise and
	when we move the graph the annotation will alwaus point to the same locaiton of the graph.
	
	and the annotaion will be pointed  to the locaiton
	
	
	---> ax1.annotate('Bad News!', (date[11], highp[11]),
						axtext = (0.8, 0.9), textcoords='axes function'
						arrowprops = dict(facecolor = ''grey, color='grey'))
	
	
	
'''
style.use('ggplot')

def bytespdate2num(fmt, encoding = 'utf-8'):
	strconverter = mdates.strpdate2num(fmt)
	def bytesconverter(b):
		s = b.decode(encoding)
		return strconverter(s)
	return bytesconverter


def graph_date(stock):
	fig = plt.figure()
	fig.patch.set_facecolor('xkcd:mint green') # set background color of the figure
	ax1 = plt.subplot2grid((1,1), (0, 0) ) 
	
	lowestp = highestp = 0
		
	stock_price_url = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/1m?format=csv'
	source_code = urllib.request.urlopen(stock_price_url).read().decode()
	stock_data = []
	split_source = source_code.split('\n')
	
	for line in split_source:
		split_line = line.split(',')
		stock_data.append(line)		
	date, openp, highp, lowp, closep, volumep = np.loadtxt(stock_data, 
														delimiter = ',', 
														unpack=True,
														skiprows=1,
														usecols=(0,1,2,3,4,5),
														converters={0:bytespdate2num('%Y-%m-%d')})
	
	x = 0
	y = len(date)
	ohlc = []
	while x < y:
		append_me = date[x], openp[x],highp[x], lowp[x], closep[x], volumep[x]
		ohlc.append(append_me)
		x+=1
		
	
	
	candlestick_ohlc(ax1, ohlc, width = 0.15, colorup='#19b484', colordown='#ff4ca3') #color from http://www.color-hex.coms
	
	for label in ax1.xaxis.get_ticklabels():
		label.set_rotation(35)
	
	ax1.xaxis.set_major_formatter(mdates.DateFormatter('%Y/ %m/ %d'))
	
	ax1.annotate('Bad News!', (date[11], closep[11]),
						xytext = (0.8, 0.9), textcoords = 'axes fraction',
						arrowprops = dict(facecolor = 'grey', color='grey'))
	
	
	plt.xlabel('Date')
	plt.ylabel('Price(USD)')
	plt.title('Ebay Stock Price, 1 month')
	plt.legend(title = 'Ebay', borderaxespad=0.8, loc=2)
	
	#now the problem is that the label goes off the screen, we need to modify the margin
	plt.subplots_adjust(top=0.88, right=0.900, bottom=0.165, left=0.165, wspace = 0.2, hspace=0.2)
	plt.show()

graph_date('EBAY')


