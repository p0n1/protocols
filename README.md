# Loopring Protocol Smart Contracts

## Lint Solidity Files

```
npm install -g solium
solium --dir contracts
```

## Compile


If you are using Windows:
```
npm install --global --production windows-build-tools
```

Then run the following commands from project's root directory:
 
```
npm install -g truffle@3.4.11
npm install -g ethereumjs-testrpc@4.1.3
npm install -g typescript
npm install
npm run compile
```
    
## Run Unit Tests  
* run `npm run testrpc` from project's root directory in terminal.  
* run `npm run test` from project's root directory in another terminal window.  
