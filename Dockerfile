FROM python:3.8-rc-buster
# The FROM keyword tells Docker which base image to use or what should be the
# main platform for this image.

WORKDIR /code
# The WORKDIR instruction sets a working directory for other Docker
# instructions such as RUN and CMD.

# If we do not specify a working directory, we have to provide a full path for
# running our app.py file while using the RUN instruction.

ENV FLASK_APP app.py
ENV FLASK_RUN_HOST 0.0.0.0

# The ENV instruction sets an environment variable.
# Here, we are setting flask app file name and the host.
# The host 0.0.0.0 means we can access the app using any IP within the
# container.

# Setting up a host to 0.0.0.0 is required if you are running the app inside
# the container and want to access it outside. If you change it to anything
# else, you won’t be able to access the app from the host machine.

COPY requirements.txt requirements.txt

# The COPY instruction literally copies the file from one location to another.
# COPY SOURCE DESTINATION is the syntax of the command.

# Here, we are copying the requirements.txt file first so that we will have
# all the libraries installed before copying all the files.

RUN pip3 install -r requirements.txt

# The RUN instruction will execute any commands in a new layer on top of the
# current image and commit the results. The resulting committed image will be
# used for the next step in the Dockerfile.

# One benefit of running requirements before copying all the files is whenever
# a change occurs in project files, we don’t have to build requirements again
# and Docker will use a cached layer for requirements.

COPY . .
# Copy current directory files to containers code directory


# CMD runs the command inside the container once a container is forked or
# created from an image. You can only have one CMD instruction in a Dockerfile.
# If multiple CMD instructions are used, the last one will be executed.

# Here, once the container is created, the CMD command will run our project.

CMD ["flask", "run"]
