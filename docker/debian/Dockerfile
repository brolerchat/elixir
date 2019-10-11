FROM debian:latest
ARG GIT_REPO_URL
ARG PROJECT

RUN \
    : "${GIT_REPO_URL:?set GIT_REPO_URL to the repo git url}"

RUN \
    : "${PROJECT:?set PROJECT to set the project name}"

RUN \
    echo "repo url to index: ${GIT_REPO_URL}"

RUN \
  apt-get update && \
  apt-get -y install \
    python3 \
    python3-jinja2 \
    python3-pygments \
    python3-bsddb3 \
    exuberant-ctags \
    perl \
    git \
    apache2 \
    vim
RUN \
  git clone https://github.com/brolerchat/elixir.git /usr/local/elixir/

RUN \
  mkdir -p /srv/elixir-data/

ARG SSH_PRIVATE_KEY
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan nanny.netease.com > /root/.ssh/known_hosts

# Add the keys and set permissions
RUN echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa


RUN \
  mkdir /cgi-logs && \
  mkdir -p /srv/elixir-data/$PROJECT/repo && \
  mkdir -p /srv/elixir-data/$PROJECT/data && \
  git clone -b nebula-vbox "${GIT_REPO_URL}" /srv/elixir-data/$PROJECT/repo/ && \
  cd /srv/elixir-data/$PROJECT/repo/ && \ 
  git tag xref

ENV LXR_REPO_DIR /srv/elixir-data/$PROJECT/repo
ENV LXR_DATA_DIR /srv/elixir-data/$PROJECT/data

RUN \
  cd /usr/local/elixir/ && \
  ./script.sh list-tags && \
  ./update.py

COPY default.conf /etc/apache2/sites-enabled/000-default.conf
# apache elixir config, see elixir README
# make apache less stricter about cgitb spam headers
RUN \
  echo -e "\nHttpProtocolOptions Unsafe" >> /etc/apache2/apache.conf && \
  a2enmod cgi rewrite

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
