# @ THIS FILE IS FOR USING WITH RUNPOD PODS APIS
ARG FROM_IMAGE="odanielbrown/sd-base:v12"
FROM ${FROM_IMAGE} as base
ENV FROM_IMAGE=${FROM_IMAGE}

# use bash as default shell
WORKDIR /workspace
SHELL ["conda", "run", "-n", "ldm", "/bin/bash", "-c"]

# get the api
RUN git clone https://github.com/danbrown/docker-runpod-sd-training.git --branch main training
WORKDIR /workspace/training

# install requirements
RUN conda run -n ldm pip install torch==1.12.1 torchvision==0.13.1
RUN conda run -n ldm pip install -r requirements.txt --prefer-binary
RUN conda run -n ldm pip install protobuf==3.20.3
RUN conda run -n ldm pip install lion_pytorch
WORKDIR /workspace

# add the loras folder
RUN mkdir -p /workspace/loras

# copy over run script, it will run the server in ldm environment
ADD run.sh .

# expose ports, 8888 for jupyter, 3000 for the server
EXPOSE 8888 3000

# Start
ADD start.sh .
RUN chmod a+x start.sh
CMD ["./start.sh"]