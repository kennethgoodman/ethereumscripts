
brew tap ethereum/ethereum
brew install ethereum

mkdir private_ethereum_node
cd private_ethereum_node

geth account new --keystore . 
geth --datadir ./datadir init ./genesis.json
cp UTC* ./datadir/keystore/


address=$(python -c "import os; fn = os.listdir('./datadir/keystore/'); print(eval(open(fn).readlines()[0])['address'])")

echo '{
   "config": {
      "chainId": 1994,
      "homesteadBlock": 0,
      "eip155Block": 0,
      "eip158Block": 0,
      "byzantiumBlock": 0
   },
   "difficulty": "400",
   "gasLimit": "2000000",
   "alloc": {
      "'$address'": { 
          "balance": "100000000000000000000000" 
      },
   }
}' >> genesis.json

alias startblockchain='geth --datadir ./datadir --networkid 1994 --maxpeers=0 --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain "*" --rpcapi "eth,net,web3" --rpc 2>> myEth.log'

