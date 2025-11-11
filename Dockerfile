FROM amazon/aws-cli:2.31.32


USER root

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/ 

RUN aws --version && kubectl version --client

CMD ["/bin/bash"]