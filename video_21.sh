#!/usr/bin/env python3
import random
import urllib
import numpy as np
from matplotlib import style
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from mpl_finance import candlestick_ohlc


style.use('ggplot')
'''
		We are trying to show the Ebay average stock price on the ax3 
		and also we will show some data on ax1 since ax2 showing the live stockprice
		In statistics, a moving average is a calculation to analyze data points by creating 
		series of averages of different subsets of the full data set. It is also called a 
		moving mean or rolling mean and is a type of finite impulse response filter. 
		Variations include: simple, and cumulative, or weighted forms	
		
		and also check this website
		https://www.investopedia.com/terms/m/movingaverage.asp
		
		We have two kinds of moving average, Simple Moving Average(SMA) and Exponential Moving Average(EMA)
		
		Q0. What is the difference between EMA and SMA?
		What is the difference between a simple moving average and an exponential moving average? ... 
		More specifically, the exponential moving average (EMA) gives a higher weighting to recent prices, 
		while the simple moving average (SMA) assigns equal weighting to all values
		
		SMA fomrula:
		Quite simply to calculate the simple moving average formula, you divide the total of the closing prices by the number of periods.
		5-days SMA = (Closep1, Closep2, Closep3, Closep4, Closep5)/5
		We also have 10-days SMA, 20-days SMA, 50-days SMA, 100-days SMA, 200-days SMA
		
		
		How to Use Moving Averages
		Moving averages lag current price action because they are based on past prices; 
		the longer the time period for the moving average, the greater the lag. 
		Thus, a 200-day MA will have a much greater degree of lag than a 20-day MA because it 
		contains prices for the past 200 days. The length of the moving average to use depends 
		on the trading objectives, with shorter moving averages used for short-term trading 
		and longer-term moving averages more suited for long-term investors. 
		The 50-day and 200-day MAs are widely followed by investors and traders, 
		with breaks above and below this moving average considered to be important trading signals.
		
		Q1. What does it mean when moving averages cross?
		When a short-term moving average is above a long-term moving average, that means that the trend 
		is higher or bullish, and vice versa for short-term moving averages below long-term moving averages. 
		Moving averages can also be used to identify trend reversals in several ways: Price Crossover.
		
		Q2. What is EMA 50?
		The 50-day moving average marks a line in the sand for traders holding positions through inevitable drawdowns. ... 
		The 50-day exponential moving average (EMA) offers the most popular variation, responding to price movement more 
		quickly than its simple minded cousin.
		
		Q3. What happens when the 200 day moving average crosses the 50 day moving average?
		The “cross” refers to two simple moving averages “crossing” over each other. A golden cross is 
		considered a bullish sign; it occurs when the 50-day moving average rises above 200-day moving average. 
		A death cross is considered a bearish sign; it occurs when the 50-day moving average drops below 200-day moving average.
		
		We also define a funtion named moving average to calculate the moving average of the stock price, 
		we msut notice that we need to define the same starting point. 
		In the moving average we used 
		-->numpy.convolve() 
		here is the definition of convolution in mathematics
		In mathematics convolution is a mathematical operation on two functions to 
		produce a third function that expresses how the shape of one is modified by the other. 
		
		or have a look at this video
		https://www.youtube.com/watch?v=RCw530Emvks
		

		The fast moving average is blue and the slow moving average is red.
		So we can use this two chart to predict the trend, for example, when the fast moving average is above the 
		slow moving average, that is a good sign, its time to invest, when the slow moving average is above the 
		fast moving average, its time to sell or invest on reverse.
		
		We also use the (highp - lowp_ price chart in ax1. We define the method and use it.
		
		
'''
MA1 = 5
MA2 = 30


def moving_average(values, window):
	weights = np.repeat(1.0, window) / window
	smas = np.convolve(values, weights, 'valid')
	return smas

def high_minus_low(highs, lows):
	return highs-lows
	
# ~ h_l = list(map(high_minus_low, highs, lows)) #This is a quick way to apply the function into each corresponding elements of two list, otherwise we can use the for-loop
# ~ print(h_l)

def bytespdate2num(fmt, encoding = 'utf-8'):
	strconverter = mdates.strpdate2num(fmt)
	def bytesconverter(b):
		s = b.decode(encoding)
		return strconverter(s)
	return bytesconverter

def graph_data(stock):
	fig = plt.figure()
	fig.patch.set_facecolor('#ccdef9') # set background color of the figure
	
	ax1 = plt.subplot2grid((6, 1), (0, 0), rowspan = 1, colspan = 1)
	plt.title(stock)
	ax2 = plt.subplot2grid((6, 1), (1, 0), rowspan = 4, colspan = 1)
	plt.xlabel('Date')
	plt.ylabel('Price(USD)')
	ax3 = plt.subplot2grid((6, 1), (5, 0), rowspan = 1, colspan = 1)
	
	stock_price_url = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/1y?format=csv'
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
	
	ma1 = moving_average(closep , MA1)
	ma2 = moving_average(closep , MA2)
	start = len(date[MA2-1:])
	
	h_l = list(map(high_minus_low, highp, lowp))
	ax1.plot_date(date, h_l, '-')
	
	candlestick_ohlc(ax2, ohlc, width = 0.15, colorup='#096d09', colordown='#9b287c') #color from http://www.color-hex.coms
	
	for label in ax2.xaxis.get_ticklabels():
		label.set_rotation(35)
	
	ax2.xaxis.set_major_formatter(mdates.DateFormatter('%Y/ %m/ %d'))
	
	bbox_props = dict(boxstyle="round4, pad=0.4", 
					fc="#edef7c", # Face color 
					ec="#000000", #edge color
					lw=0.5) #line width
	ax2.annotate(
				str(closep[-1]), #string format of the annotation text
				(date[-1], closep[-1]),  # the place the annotation pointing to
				xytext = (date[-1]+3 , closep[-1]), # the (x, y) location of the annotation, +3 guarantee the annotation will be off the graph on right side
				bbox = bbox_props) # the property of the box around the annotation.

	ax3.plot(date[-start:], ma1[-start:])
	ax3.plot(date[-start:], ma2[-start:])

	# ~ plt.legend(title = 'Ebay', borderaxespad=0.8, loc=2)
	
	#now the problem is that the label goes off the screen, we need to modify the margin
	plt.subplots_adjust(top=0.88, right=0.850, bottom=0.165, left=0.14, wspace = 0.2, hspace=0.2)
	plt.show()

graph_data('EBAY')



