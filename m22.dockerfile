# Copyright (c) 2024 Michael Neill Hartman. All rights reserved.

FROM   ubuntu:noble AS with_noble
RUN    apt update
RUN    apt install -y screen
RUN    apt install -y curl
RUN    apt install -y nodejs
RUN    apt install -y npm
RUN    npm install npm -g
FROM   with_noble AS m22_di
COPY   . /
RUN    chmod 755 /launch_m22
EXPOSE 9000
EXPOSE 8080
ENTRYPOINT ["./launch_m22"]

#CMD ["npm", "start"]
#RUN    npm update
# sudo apt install screen
#VOLUME ["."]
#FROM   with_node AS with_dependencies
#FROM   with_noble AS with_dependencies
#RUN    npm install express
#RUN    npm install body-parser
#RUN    npm install http-server -g
