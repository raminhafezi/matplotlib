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
	we are talking about annotating the stock price ourside of the graph,
	we are eager to annotate the latest price of the stock on the right side of the stock,
	look at the picture in this web address:
	https://www.fool.com/investing/2017/04/18/apple-stock-price-targets-rising-think-about-sell.aspx
	
	we will use 
	ax1.annotate('The string of what we want to display, in this case the last close price which we will show with closep[-1]',
				 'the location that the annotate pointing to, in this case it is (date[-1], closep[-1)',
				 ' the palce that the annotation take place, we want the price move dynamically with the price so the //
				 xytext= (date[-1]+3', closep[-1]) this 3 put our annotation off the chart in the right side)
	
	we also like to have a box around that annotation, so we cover  this by bbox property in the annotation
	we usually set the bbox = box-props and then set the properties of the box outside of the annotaion code
	
	--> ax.annotation (str(something), loc(of something that point to), xytext( x_location, y_location ), bbox = box-props)
	
	have a look at this website https://matplotlib.org/users/annotations.html
		
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
	fig.patch.set_facecolor('#ccdef9') # set background color of the figure
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
		
	
	
	candlestick_ohlc(ax1, ohlc, width = 0.15, colorup='#096d09', colordown='#9b287c') #color from http://www.color-hex.coms
	
	for label in ax1.xaxis.get_ticklabels():
		label.set_rotation(35)
	
	ax1.xaxis.set_major_formatter(mdates.DateFormatter('%Y/ %m/ %d'))
	
	bbox_props = dict(boxstyle="round4, pad=0.4", 
					fc="#edef7c", # Facecolor 
					ec="#000000", #edge color
					lw=0.5 #line width
					)
	ax1.annotate(
				str(closep[-1]), #string format of the annotation text
				(date[-1], closep[-1]),  # the place the annotation pointing to
				xytext = (date[-1]+3 , closep[-1]), # the (x, y) location of the annotation, +3 guarantee the annotation will be off the graph on right side
				bbox = bbox_props # the property of the box around the annotation.
				)
	
	
	
	# annotation example with arrow
	'''
	ax1.annotate('Bad News!', (date[11], closep[11]),
						xytext = (0.8, 0.9), textcoords = 'axes fraction',
						arrowprops = dict(facecolor = 'grey', color='grey'))
	
	# Font dict example
	font_dict = {
					'family' : 'serif',
					'color' : 'darkred',
					'size' : 15	}
					
	# Hard code text
	ax1.text (date[10], closep[1], 'Text Example', fontdict = font_dict)
		
	'''
	
	plt.xlabel('Date')
	plt.ylabel('Price(USD)')
	plt.title('Ebay Stock Price, 1 month')
	plt.legend(title = 'Ebay', borderaxespad=0.8, loc=2)
	
	#now the problem is that the label goes off the screen, we need to modify the margin
	plt.subplots_adjust(top=0.88, right=0.900, bottom=0.465, left=0.065, wspace = 0.2, hspace=0.2)
	plt.show()

graph_date('EBAY')


