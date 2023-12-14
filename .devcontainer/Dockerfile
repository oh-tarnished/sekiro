# Use an image from a private Amazon ECR repository as the base image
FROM 857545368513.dkr.ecr.ap-south-1.amazonaws.com/dawn:1.0.0

# Update the package lists for upgrades for packages that need upgrading, as well as new package installations
RUN apt update && \
    # Install docker.io and lcov packages without recommended additional packages to minimize image size
    apt install --no-install-recommends -y \
    docker.io \
    sudo \
    openssh-client \
    awscli \
    build-essential \
    lcov && \
    # Remove unnecessary packages and clean up the apt cache to reduce the image size
    apt autoremove && apt clean

# Set the user to 'developer'. Future commands will run as this user.
USER developer

# Requires for buildkite to create a cache folder
RUN mkdir -p /home/developer/.cache && \
    chmod -R 777 /home/developer/.cache
