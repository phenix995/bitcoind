# bitcoind
 
# To build the image, run this command.
docker build -t bitcoin-node .

# To run this container, run this command.
docker run --detach --name my-bitcoin-node --publish 8333:8333 bitcoin-node
