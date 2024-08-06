# Use the official Dart image as a base
FROM dart:latest

# Install Flutter dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    wget \
    unzip \
    xz-utils \
    libglu1-mesa \
    libpulse0 \
    clang \
    cmake

# Download and install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Pre-download development binaries.
RUN flutter precache

# Accept Android licenses (if needed)
RUN yes | flutter doctor --android-licenses

# Perform flutter doctor
RUN flutter doctor

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Run flutter pub get to get dependencies
RUN flutter pub get

# Expose the port for the web server
EXPOSE 8080

# Start the Flutter app
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080"]