# CourseProject

# m22 custom scraper / information aggregator

Note only macos and linux are supported.

Before you can launch you need to install dependencies

# install dependencies

1. clone the repo 
- `git clone https://github.com/mnhuoi/CourseProject.git`

2. install node.js
- `go to https://nodejs.org/en/download and download and install the linux or macos version`

3. use node package manager (npm) to install packages
- `sudo npm install express`
- `sudo npm install body-parser`
- `sudo npm install http-server -g`

4. (Optional) configure amazon_items and newegg_items files to have one item url per line
- `add amazon item urls to amazon_items file`
- `add newegg item urls to newegg_items file`

# launch_m22

1. open launcher with bash
- `cd <to cloned repo directory>`
- `bash launch_m22`

# Code overview

- `launch_m22`
# kills any already running processes and starts the back and front end servers each in a screen, 
# then opens the site and begins pull and parse


