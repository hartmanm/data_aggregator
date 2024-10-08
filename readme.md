# m22 custom scraper / information aggregator

Note `only macos and linux are supported`

Before you can launch you need to install dependencies

# what it does

People spend a lot of time opening a bunch of different websites, reading them looking for specific data. m22 is a custom scraper / information aggregator that scrapes target websites for specific information, adding the results to a single all in one webpage. It is simple to add additional scrape and parse tools to this simple framework. The tools I developed scrape and parse:

- if items are in stock at amazon or newegg given the url of the item

- the top 10 news headlines from google news

- the crypto exchange rates from coinmarketcap

- all images contained on a site, with some sites

Each of the scrape and parse tools can also be run independently.

# intended functionality / features I didn't have time to implement

- pulling crypto prices and exchange rates from sites other than coinmarketcap

- pulling the top 10 news headlines for news sites other than google news

- a single configuration file for all configurations

- in general I intended for this tool to be more generic and automatic, and have a better looking webpage. Never the less, I made signficant progress for 20 hours

# install dependencies

1. clone the repo 
- `git clone https://github.com/mnhuoi/CourseProject.git`

2. install node.js
- go to `https://nodejs.org/en/download` and download and install the linux or macos version

3. use node package manager (npm) to install packages
- `sudo npm install express`
- `sudo npm install body-parser`
- `sudo npm install http-server -g`

4. install screen
- update your /etc/apt/sources.list to include an updated source
- sudo apt update
- sudo apt install -y screen

5. (Optional) configure amazon_items and newegg_items files to have one item url per line
- add amazon item urls to `amazon_items` file
- add newegg item urls to `newegg_items` file

# launch_m22

1. open launcher with bash
- `cd <to cloned repo directory>`
- `bash launch_m22`

# Code overview

1. Main processes
- `bash launch_m22` Primary launcher that invokes node_server.js, http-server, and launches m22.html. kills any already running processes and starts the back and front end servers each in a screen, then opens the site and begins pull and parse. This is the only process you need to launch.

- `node node_server.js` backend server, invokes all the scrape and parse tools when sent an http request by m22.html

- `m22.html` the front end webpage served by http-server, can load any of the results jsons. If reloading the same json you must either load a different json first, or clear wait for pull and parse to complete, then reopen.

3. Scrape and parse tools
- `bash amazon_item_query_wrapper amazon_items` wraps amazon_item_in_stock_query invoking it with each url from the amazon_items file and outputs them to the `results_json_amazon` file
- `bash amazon_item_in_stock_query ${AMAZON_ITEM_URL}`	

- `bash newegg_item_query_wrapper newegg_items` wraps newegg_item_in_stock_query invoking it with each url from the newegg_items file outputs them to the `results_json_newegg` file
- `bash newegg_item_in_stock_query ${NEWEGG_ITEM_URL}`		

- `bash coinmarketcap_crypto_price_parser` pulls the usd exchange rates for the top cryptocurrencies by marketcap and outputs them to the `results_json_coin_market_cap` file
			
- `bash google_news_headlines` pulls the top google news headlines and outputs them to the `results_json_google_headlines` file
			
- `bash images_query ${TARGET_URL}` pulls all images from the url passed (note only tested with some websites) and outputs them to the `results_images_json_${TARGET_URL}` file
- bash images_query defaults to pulling the images from the top google news headlines and outputs them to the `results_images_json_httpsnewsgooglecomtopstorieshlen-USglUSceidUSen` file
	
4. information aggregator tools
- `bash join_results` generates a single json from all result jsons named `z_all_results_json`. What results files are included can be modified by changing the RESULT_JSONS list inside join_results.

5. Configuration Files add one item url per line
- `amazon_items`
- `newegg_items`

6. Image Files
- `instock.png`				
- `outofstock.png`