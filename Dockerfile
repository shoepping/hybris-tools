FROM shoepping/oraclejdk:8

# https://github.com/keeganwitt/docker-gradle/blob/e486d3ff8bb68e77ac37239d68d4d60f4a9485fc/jdk7/Dockerfile
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 6.8.3

# https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip.sha256
ARG GRADLE_DOWNLOAD_SHA256=7faa7198769f872826c8ef4f1450f839ec27f0b4d5d1e51bade63667cbccd205

RUN set -o errexit -o nounset \
	&& echo "Downloading Gradle" \
	&& wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
	\
	&& echo "Checking download hash" \
	&& echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum --check - \
	\
	&& echo "Installing Gradle" \
	&& unzip gradle.zip \
	&& rm gradle.zip \
	&& mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
	&& ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle


# https://github.com/groovy/docker-groovy/blob/master/jdk8/Dockerfile
ENV GROOVY_HOME /opt/groovy
ENV GROOVY_VERSION 2.5.15

RUN set -o errexit -o nounset \
	&& echo "Downloading Groovy" \
	&& wget --no-verbose --output-document=groovy.zip "https://dist.apache.org/repos/dist/release/groovy/${GROOVY_VERSION}/distribution/apache-groovy-binary-${GROOVY_VERSION}.zip" \
	\
	&& echo "Importing keys listed in http://www.apache.org/dist/groovy/KEYS from key server" \
	&& echo "Installing Groovy" \
	&& unzip groovy.zip \
	&& rm groovy.zip \
	&& mv "groovy-${GROOVY_VERSION}" "${GROOVY_HOME}/" \
	&& ln --symbolic "${GROOVY_HOME}/bin/grape" /usr/bin/grape \
	&& ln --symbolic "${GROOVY_HOME}/bin/groovy" /usr/bin/groovy \
	&& ln --symbolic "${GROOVY_HOME}/bin/groovyc" /usr/bin/groovyc \
	&& ln --symbolic "${GROOVY_HOME}/bin/groovyConsole" /usr/bin/groovyConsole \
	&& ln --symbolic "${GROOVY_HOME}/bin/groovydoc" /usr/bin/groovydoc \
	&& ln --symbolic "${GROOVY_HOME}/bin/groovysh" /usr/bin/groovysh \
    && ln --symbolic "${GROOVY_HOME}/bin/java2groovy" /usr/bin/java2groovy

ENV JACOCO_VERSION 0.8.2
RUN wget https://repo1.maven.org/maven2/org/jacoco/org.jacoco.agent/${JACOCO_VERSION}/org.jacoco.agent-${JACOCO_VERSION}-runtime.jar -P /opt

RUN apt-get update
RUN apt-get install -y \
		curl \
		git \
		zip \
		wget

ENV TZ=Europe/Vienna
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
