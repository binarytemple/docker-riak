# https://docs.docker.com/engine/examples/running_riak_service/

FROM ubuntu:14.04 

ENV RIAK_VERSION 2.1.4-1

RUN apt-get update && apt-get install -y curl dnsutils && curl https://packagecloud.io/install/repositories/basho/riak/script.deb.sh | bash 

RUN apt-get install -y supervisor riak=${RIAK_VERSION} && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN mkdir -p /var/log/supervisor

RUN locale-gen en_US en_US.UTF-8

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN sed -i.bak 's/listener.http.internal = 127.0.0.1/listener.http.internal = 0.0.0.0/' /etc/riak/riak.conf && \
    sed -i.bak 's/listener.protobuf.internal = 127.0.0.1/listener.protobuf.internal = 0.0.0.0/' /etc/riak/riak.conf && \
    echo "anti_entropy.concurrency_limit = 1" >> /etc/riak/riak.conf && \
    echo "javascript.map_pool_size = 0" >> /etc/riak/riak.conf && \
    echo "javascript.reduce_pool_size = 0" >> /etc/riak/riak.conf && \
    echo "javascript.hook_pool_size = 0" >> /etc/riak/riak.conf

# Open ports for HTTP and Protocol Buffers 

EXPOSE 8087 8098 

VOLUME /var/lib/riak/ 

VOLUME /etc/riak

ENTRYPOINT ["/usr/bin/supervisord"]

CMD ["-c", "/etc/supervisor/conf.d/supervisord.conf"]
