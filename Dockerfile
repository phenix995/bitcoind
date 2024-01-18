# Use an Ubuntu base image
FROM ubuntu:noble

# Install dependencies
RUN apt-get update && apt-get install -y wget tar

# Download bitcoin bin
RUN wget https://bitcoincore.org/bin/bitcoin-core-26.0/bitcoin-26.0-x86_64-linux-gnu.tar.gz
RUN tar xzf bitcoin-26.0-x86_64-linux-gnu.tar.gz
RUN mv bitcoin-26.0 /usr/local/bin/bitcoin

# Copy bitcoin.conf
COPY bitcoin.conf /home/bitcoin/.bitcoin/bitcoin.conf

# Create bitcoin user
RUN useradd -ms /bin/bash bitcoin

# Set permissions
RUN chown -R bitcoin:bitcoin /usr/local/bin/bitcoin
RUN chown -R bitcoin:bitcoin /home/bitcoin/.bitcoin

# Switch to bitcoin user
USER bitcoin

# Expose ports 8333 for mainnet and 18333 for testnet
EXPOSE 8333

# Set volume
VOLUME ["/home/bitcoin/.bitcoin"]

# Run bitcoin
CMD ["/usr/local/bin/bitcoin/bin/bitcoind", "-conf=/home/bitcoin/.bitcoin/bitcoin.conf", "-datadir=/home/bitcoin/.bitcoin"]
