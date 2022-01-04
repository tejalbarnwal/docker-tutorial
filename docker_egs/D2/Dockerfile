FROM gcc:latest

COPY . /usr/src/cpp_test
# main.cpp gets copied to a folder created cpp_test inside the container

WORKDIR /usr/src/cpp_test
# specifies the working directory
# means if you want to run any command it would run inside this directory

RUN g++ -o tejal main.cpp

CMD [ "./tejal" ]

