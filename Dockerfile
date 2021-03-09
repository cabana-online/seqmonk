FROM cabanaonline/r-env:1.0

LABEL base.image="cabanaonline/r-env"
LABEL description="A SeqMonk container with R."
LABEL maintainer="Alejandro Madrigal Leiva"
LABEL maintainer.email="me@alemadlei.tech"

ARG USER=cabana
ENV HOME /home/$USER
ENV DISPLAY :0

USER root

# Installs R.
RUN set -xe; \
    \
    apt-get update && \
    apt-get install -y openjdk-11-jre

# Removes development tools.
RUN set -xe; \
    \
    cd /opt/scripts && ./uninstall.sh && \
    apt-get clean && \
    apt-get autoclean;

USER cabana

# Setups SeqMonk
RUN set -xe; \
    \
    cd /tmp/ && wget https://www.bioinformatics.babraham.ac.uk/projects/seqmonk/seqmonk_v1.47.2_linux64.tar.gz && \
    tar -xf seqmonk_v1.47.2_linux64.tar.gz && \
    mkdir $HOME/tools && mv SeqMonk $HOME/tools/SeqMonk && cd $HOME/tools/SeqMonk && ls -lha

# Runs SeqMonk
ENTRYPOINT ["/home/cabana/tools/SeqMonk/seqmonk"]