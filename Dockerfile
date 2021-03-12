FROM ubuntu

RUN apt-get update \
    && apt-get install git python3 python3-pip -y \
    && mkdir /root/.ssh \
    && ln -s /ostool/id_rsa /root/.ssh/id_rsa \
    && ln -s /ostool/id_rsa.pub /root/.ssh/id_rsa.pub \    
    && mkdir /repo \
    && cd /repo \
    && git clone https://github.com/CiscoUcs/intersight-python.git \
    && pip3 install enum34 git+https://github.com/CiscoUcs/intersight-python.git \ 
    && ln -s /repo/intersight-python/intersight /repo/intersight-python/os-discovery-tool/intersight \
    && cd /repo/intersight-python/os-discovery-tool 

ADD hosts /repo/    
RUN for line in `cat /repo/hosts`; do ssh-keyscan $line >> ~/.ssh/known_hosts; done

CMD python3 /repo/intersight-python/os-discovery-tool/get_linux_inv_to_intersight.py --log-inventory --configfile=/ostool/discovery_config_linux.json