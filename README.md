## Lightning Demo

### 1.Get the box

​	Build the container yourself:

```
git clone https://github.com/ccyanxyz/lightning-testnet-box.git
cd lightning-testnet-box
docker build -t lightning-testnet-box .
```

​	OR pull the image from docker hub:

```
docker pull ccyanxyz/lightning-testnet-box:latest
```

### 2.Start everything

​	Start the container:

```
docker run -it lightning-testnet-box
```

​	Start bitcoind & lightningd:

```
make start-bitcoind
make start-lightningd
```

### 3.Generate some blocks

​	Make them rich: 

```
b1 generate 100 # alias to bitcoin-cli -datadir=/root/lightning-testnet-box/node1, see .bashrc
b2 generate 100
b3 generate 100
b4 generate 101
```

### 4.State channel

​	Generate new address and send some bitcoin to the address:

```
l1 newaddr
b1 sendtoaddress <ADDRESS> <AMOUNT IN BITCOIN>
b1 generate 6 # make sure the tx is confirmed
l1 listfunds # list the output, if empty, just wait a minute and try again
```

​	Connect to node2 and fund channel:

```
l2 getinfo # copy the id of lightning node2
l1 connect <PEER ID>@127.0.0.1:9736
l1 fundchannel <PEER ID> <AMOUNT IN SAT>
l1 listfunds # channels is open now
```

​	Assume that node1 have to pay node2 some btc, node2 has to generate an invoice:

```
l2 invoice <AMOUNT IN mSAT> <LABEL> <DESCRIPTION>
```

​	Now node1 can pay node2 use the serialized invoice 'bolt11':

```
l1 decodepay <BOLT11> # inspect the content of the serialized invoice
l1 getroute <PEER ID>
l1 pay <BOLT11>
l2 listfunds # now node2 should have received the money, see 'channel_sat'
```

​	Close channel:

```
l1 close <PEER ID>
b1 generate 101
l1 listfunds # now the channel should be closed
```

### 5.Make a network of lightning nodes

​	Lazy… TBD...

### 6.Acknowledgement

This testnet box is modified from the [bitcoin-testnet-box](https://github.com/freewil/bitcoin-testnet-box.git).
