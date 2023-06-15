FROM ubuntu:22.04

#CMD ["/bin/bash"]
RUN /bin/sh -c 'apt clean' # buildkit
#RUN apt clean

RUN /bin/sh -c 'apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx net-tools wget && apt-get clean && rm -rf /var/lib/apt/lists/*' # buildkit
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx net-tools wget && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /bin/sh -c 'mkdir /opt/tmp_vts' # buildkit
RUN /bin/sh -c 'ls /opt'

#COPY ./installer_files /opt/tmp_vts/ # buildkit
ADD ./installer_files /opt/tmp_vts/

RUN /bin/sh -c 'ls /opt/tmp_vts/'

RUN /bin/sh -c 'mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf_orig' # buildkit
WORKDIR /opt/tmp_vts/

#cat /opt/tmp_vts/installer_files && wget -q -i /opt/tmp_vts/installer_files && 
RUN /bin/sh -c 'cp /opt/tmp_vts/nginx.conf /etc/nginx/nginx.conf && ls -l /opt/tmp_vts && chmod -fRv a+x /opt/tmp_vts && /opt/tmp_vts/inst64.bin -i silent -DVTS_DATA_FOLDER='\"/var/lib/MF/MF_VTS/db/data\"' -DADMIN_UI_SERVER_PORT=4000 && rm -R /opt/tmp_vts && rm -R /opt/MF/MF_VTS/jre' # buildkit

ENV DEBIAN_FRONTEND=newt

EXPOSE 4000 8888
#ENTRYPOINT ["/bin/sh" "-c" "cd /opt/MF/MF_VTS/web; nginx; ./node main.js"]
#ENTRYPOINT ["/bin/bash -c 'cd /opt/MF/MF_VTS/web && nginx && ./node main.js'"]
ENTRYPOINT ["/bin/bash", "-c", "cd /opt/MF/MF_VTS/web; nginx; ./node main.js"]



#docker build -t vtsjg .
# docker run -i -t -d -p 4000:4000 -p 8888:8888 -v /home/demo/repositories/vtsdocker/volumes/config/configure.json:/opt/MF/MF_VTS/web/configure.json -v /home/demo/repositories/vtsdocker/volumes/data:/var/lib/MF/MF_VTS/db/data -v /home/demo/repositories/vtsdocker/volumes/logs:/tmp/VTS --name myvts vtsjg

#docker run -i -t -d -v /home/demo/repositories/vtsdocker/volumes/config/configure.json:/opt/MF/MF_VTS/web/configure.json -v /home/demo/repositories/vtsdocker/volumes/data:/var/lib/MF/MF_VTS/db/data -v /home/demo/repositories/vtsdocker/volumes/logs:/tmp/VTS --name myvts vtsjg
