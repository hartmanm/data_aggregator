# data aggregator

Note `only macos and linux are supported for query scripts`

# what it does

People spend a lot of time opening a bunch of different websites, reading them looking for specific data. da is a custom scraper / information aggregator that scrapes target websites for specific information, adding the results to a single json. da.html allows a this json to be loaded in a browser. The tools I developed scrape and parse:

- if items are in stock at amazon or newegg given the url of the item

- all images contained on a site, with some sites

Each of the scrape and parse tools can also be run independently.

# intended functionality / features I didn't have time to implement

- a single configuration file for all configurations

- in general I intended for this tool to be more generic and automatic.

# install dependencies

1. clone the repo 
- `git clone https://github.com/hartmanm/data_aggregator.git`

2. (Optional) configure amazon_items and newegg_items files to have one item url per line
- add amazon item urls to `amazon_items` file
- add newegg item urls to `newegg_items` file

# launch_da

1. open launcher with bash
- `cd <to cloned repo directory>`
- `bash launch_da`

# Code overview

1. Main processes
- `bash launch_da` Primary launcher that invokes query scripts.

- `da.html` the front end webpage, it can load any of the results jsons. If reloading the same json reload the page before loading the json.

3. Scrape and parse tools
- `bash amazon_item_query_wrapper amazon_items` wraps amazon_item_in_stock_query invoking it with each url from the amazon_items file and outputs them to the `results_json_amazon` file
- `bash amazon_item_in_stock_query ${AMAZON_ITEM_URL}`	

- `bash newegg_item_query_wrapper newegg_items` wraps newegg_item_in_stock_query invoking it with each url from the newegg_items file outputs them to the `results_json_newegg` file
- `bash newegg_item_in_stock_query ${NEWEGG_ITEM_URL}`		
			
- `bash images_query ${TARGET_URL}` pulls all images from the url passed (note only tested with some websites) and outputs them to the `results_images_json_${TARGET_URL}` file
- bash images_query defaults to pulling the images from the top google news headlines and outputs them to the `results_images_json_${TARGET_URL}` file
	
4. information aggregator tools
- `bash join_results` generates a single json from all result jsons named `z_all_results_json`. What results files are included can be modified by changing the RESULT_JSONS list inside join_results.

5. Configuration Files add one item url per line
- `amazon_items`
- `newegg_items`
