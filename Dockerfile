FROM jenkins
MAINTAINER Oliver Schwab

# install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# skip setup wizard
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"

# execute the following with root permissions
USER root

RUN apt-get update --fix-missing
RUN apt-get install -y \
  maven \
  git

# create "link" to parent docker
RUN touch /var/run/docker.sock

# grant permission to parent docker
RUN groupadd docker \
	&& gpasswd -a jenkins docker \
	&& chown root:docker /var/run/docker.sock

# drop back to regular jenkins user
USER jenkins