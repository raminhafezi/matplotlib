#!/usr/bin/env python3
import matplotlib.pyplot as plt
import time
import pandas as pd
import matplotlib.dates as mdates


'''
	We are trying to read stock price irectly from the web API and save it into a dataFrame and then
	Save the DataFrame into a picke, we seperated each stock into a unique picke same as stock name.
	
	
'''

stockToPull =  'AAPL','GOOG', 'TSLA', 'MSFT', 'CMG', 'EBAY', 'AMZN', 'BABA', 'AMD', 'NFLX', 'PEP', 'FB', 'TEVA'

def pullData(stock):
	try:
		urlToVisit = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/5y?format=csv'
		
		#header = 0 means use the first row as a column name
		#index_col = 0 means the first column which is a date will be used as a index of the data frame
		#
		stock_dataFrame = pd.read_csv(urlToVisit, sep = ',', 
												  header = 0, 
												  #index_col = 0, 
												  usecols = [0,1,2,3,4,5])
		#print(stock_dataFrame.head(10))
		stock_dataFrame.to_pickle(stock+'.pickle')
		print("writing {} pickle".format(stock))
		tempDF = pd.read_pickle(stock+'.pickle')
		print(tempDF.tail(30))
			
	except Exception as e:
		print('Main Loop', str(e)) 

for stockAbv in stockToPull:
	pullData(stockAbv)
	time.sleep(1)
	#display_pickle(stockAbv+'.pickle')
	
	
