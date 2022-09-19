FROM ruby:3.1.2
ADD . /parking_lot
WORKDIR /parking_lot
RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]
