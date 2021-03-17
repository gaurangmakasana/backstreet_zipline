# Team 21 - Backstreet Brogrammers

## Efficient Backtesting framework using zipline and pyfolio

* Custom bundle pricing data (minutely and daily) ingestion - Quantopian bundle already ingested
* Example strategies implemented - Simple Moving Averages, Asset Allocation, RSI based strategy

### Setup
* Checkout the project (using git clone) to local
* Build the docker image : ./scripts/build_zip.sh

### Run
* Execute : ./scripts/start_zip.sh
* Copy the jupyter notebook token from : ./logs/backtest_zipline_<container_id>.log
* Launch browser and link: http://localhost:8801/tree
* Paste the token and launch jupyter
* 3 example strategies are given which can be opened and run
* Once done, can logout from jupyter notebook
* Stop the docker container : ./scripts/stop_zip.sh

### Ingest the custom bundle
* Execute : ./scripts/ingest_bundle.sh
* This will launch bash shell inside the running docker container - meaning user is inside the container and can make the changes
* Prepare the daily or minutely ticker data csv in OHCLV format or fetch from AWS S3
* Place it at /home/backstreet/use_zipline/prepare_custom_bundle/data/csvs
* Change the bundle name in other details at: /home/backstreet/use_zipline/prepare_custom_bundle/extension.py
* Copy extension.py to /root/.zipline
* Run : /home/backstreet/use_zipline/prepare_custom_bundle/prepare_bundle.py
* Custom bundle is ingested and will be ready to use in backtesting strategies
* Type exit to stop the container and move back to host
