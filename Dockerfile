# To build the container
# docker build -t jupyter-keras .
# To run the container:
# docker run -it -v /$(pwd)/:/home/jovyan/work -p 8888:8888 jupyter-keras:latest start-notebook.sh --NotebookApp.token=''

# To access the notbook from the browser:
# http://localhost:8888/tree

# To login in to the server:
# docker exec -it <container ID> /bin/bash

# To check Keras version:
# python -c 'import keras; print(keras.__version__)'

FROM jupyter/scipy-notebook

MAINTAINER Mahmoud Adly <@mahmoudadly>

USER root

# bash instead of dash to use source
RUN ln -snf /bin/bash /bin/sh

USER jovyan

RUN pip install --upgrade pip \
  && pip install --upgrade tensorflow \
  && pip install --upgrade --no-deps git+git://github.com/keras-team/keras.git \
  && pip install --upgrade --no-deps h5py \
  # This fixes errors like "no module named keras_applications"
  && pip install keras_applications==1.0.4 --no-deps \
  && pip install keras_preprocessing==1.0.2 --no-deps
