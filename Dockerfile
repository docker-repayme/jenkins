FROM jenkins
MAINTAINER Oliver Schwab

# install plugins
RUN /usr/local/bin/install-plugins.sh git gradle deploy workflow-aggregator checkstyle email-ext dashboard-view build-environment all-changes envinject docker-workflow

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