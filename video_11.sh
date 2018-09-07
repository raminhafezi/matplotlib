<<<<<<< HEAD
#!/usr/bin/env python3.5

import dash
from dash.dependencies import Input, Output
import dash_core_components as dcc
import dash_html_components as html
from pandas_datareader import data as web
from datetime import datetime as dt

app = dash.Dash()

app.layout = html.Div([
    html.H1('Stock Tickers'),
    dcc.Dropdown(
        id='my-dropdown',
        options=[
            {'label': 'Coke', 'value': 'COKE'},
            {'label': 'Tesla', 'value': 'TSLA'},
            {'label': 'Apple', 'value': 'AAPL'}
        ],
        value='COKE'
    ),
    dcc.Graph(id='my-graph')
])

@app.callback(Output('my-graph', 'figure'), [Input('my-dropdown', 'value')])
def update_graph(selected_dropdown_value):
    df = web.DataReader(
        selected_dropdown_value, data_source='google',
        start=dt(2017, 1, 1), end=dt.now())
    return {
        'data': [{
            'x': df.index,
            'y': df.Close
        }]
    }

if __name__ == '__main__':
    app.run_server()
=======
#!/usr/bin/env python3
import matplotlib.pyplot as plt
import urllib
import pickle
import numpy as np
import datetime as dt
import matplotlib.dates as mdates

'''  
	We are talking about the time conversion, in the python if you import time lib
	and then print time.time(), it gives you the unix tmie, which is less readable and need conversion.
	
	>>> time.time()
	1536021109.7199385
	>>>
	
	we can prettify this by 
	
	>>> import datetime
	>>> import time
	>>> now = time.time()
	>>> datetime.datetime.fromtimestamp(now)
	datetime.datetime(2018, 9, 4, 10, 39, 17, 83692)
	>>>
	
	then we use the vectorize from numpy

	
		
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
	ax1 = plt.subplot2grid((1,1), (0, 0) )
	
		
	stock_price_url = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/5d?format=csv'
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
	print(date)
	
	ax1.plot_date(date, openp, '-', label='Price', color='xkcd:maroon')
	
	#let modify the date on the axis of the graph
	for label in ax1.xaxis.get_ticklabels():
		#rotate the label 45 degree
		label.set_rotation(45)
	#This grid help to put web like texture underline the graph
	ax1.grid(True, linestyle = ':', color='blue', linewidth=0.08)
	
	#now the problem is that the label goes off the screen, we need to modify the margin
	plt.subplots_adjust(top=0.88, right=0.900, bottom=0.165, left=0.110, wspace = 0.2, hspace=0.2)
	plt.title('Tesla Motors Stock Price, 5 years')
	
	
	plt.xlabel('Date')
	plt.ylabel('Price')
	plt.legend("TSLA")
	plt.show()


graph_date('TSLA')

>>>>>>> 53461d7ee5735fb6a79ea3621710c77cff0ada17
