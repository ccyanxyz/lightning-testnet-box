BITCOIND=bitcoind
BITCOINCLI=bitcoin-cli
LND=lightningd
LNCLI=lightning-cli
B1_FLAGS=
B2_FLAGS=
B3_FLAGS=
B4_FLAGS=
B1=-datadir=node1 $(B1_FLAGS)
B2=-datadir=node2 $(B2_FLAGS)
B3=-datadir=node3 $(B2_FLAGS)
B4=-datadir=node4 $(B2_FLAGS)
L1=--conf /root/lightning-testnet-box/node1/lightning/lightning.conf
L2=--conf /root/lightning-testnet-box/node2/lightning/lightning.conf
L3=--conf /root/lightning-testnet-box/node3/lightning/lightning.conf
L4=--conf /root/lightning-testnet-box/node4/lightning/lightning.conf
BLOCKS=1
ADDRESS=
AMOUNT=
ACCOUNT=

start-bitcoind:
	$(BITCOIND) $(B1) -daemon
	$(BITCOIND) $(B2) -daemon
	$(BITCOIND) $(B3) -daemon
	$(BITCOIND) $(B4) -daemon

start-lightningd:
	$(LND) $(L1) --daemon
	$(LND) $(L2) --daemon
	$(LND) $(L3) --daemon
	$(LND) $(L4) --daemon

generate:
	$(BITCOINCLI) $(B1) generate $(BLOCKS)

getinfo:
	$(BITCOINCLI) $(B1) -getinfo
	$(BITCOINCLI) $(B2) -getinfo
	$(BITCOINCLI) $(B3) -getinfo
	$(BITCOINCLI) $(B4) -getinfo

sendfrom1:
	$(BITCOINCLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	$(BITCOINCLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom3:
	$(BITCOINCLI) $(B3) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom4:
	$(BITCOINCLI) $(B4) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	$(BITCOINCLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	$(BITCOINCLI) $(B2) getnewaddress $(ACCOUNT)

address3:
	$(BITCOINCLI) $(B3) getnewaddress $(ACCOUNT)

address4:
	$(BITCOINCLI) $(B4) getnewaddress $(ACCOUNT)

stop:
	$(BITCOINCLI) $(B1) stop
	$(BITCOINCLI) $(B2) stop
	$(BITCOINCLI) $(B3) stop
	$(BITCOINCLI) $(B4) stop

clean:
	find node1/regtest/* -not -name 'server.*' -delete
	find node2/regtest/* -not -name 'server.*' -delete
	find node3/regtest/* -not -name 'server.*' -delete
	find node4/regtest/* -not -name 'server.*' -delete
