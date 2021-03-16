#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 27 05:29:23 2021

@author: srivrish
"""


import talib
from zipline.api import order_target, record, symbol, order_target_percent

import os
os.chdir("/home/backstreet/use_zipline/rsi_strategy")


def initialize(context):
    stocklist = ['FB', 'AMZN', 'AAPL', 'NFLX', 'GOOGL']
    
    context.stocks = [symbol(s) for s in stocklist]
    context.target_pct_per_stock = 1.0 / len(context.stocks)
    
    context.LOW_RSI = 30
    context.HIGH_RSI = 70
    
    
def handle_data(context, data):
    prices = data.history(context.stocks, 'price', bar_count=20, frequency="1d")
    rsis = {}
    
    for stock in context.stocks:
        rsi = talib.RSI(prices[stock], timeperiod=14)[-1]
        rsis[stock] = rsi
        
        current_position = context.portfolio.positions[stock].amount
        
        # RSI is above 70 and we own shares, time to sell
        if rsi > context.HIGH_RSI and current_position > 0 and data.can_trade(stock):
            order_target(stock, 0)
   
        # RSI is below 30 and we don't have any shares, time to buy
        elif rsi < context.LOW_RSI and current_position == 0 and data.can_trade(stock):
            order_target_percent(stock, context.target_pct_per_stock)
        
    # record the current RSI values of each stock for later ispection
    record(fb_rsi=rsis[symbol('FB')],
           amzn_rsi=rsis[symbol('AMZN')],
           aapl_rsi=rsis[symbol('AAPL')],
           nflx_rsi=rsis[symbol('NFLX')],
           googl_rsi=rsis[symbol('GOOGL')])
    

"""
zipline run -f backtest.py --start 2014-1-1 --end 2018-1-1 -o perf.pickle --no-benchmark --capital-base 20000
"""
