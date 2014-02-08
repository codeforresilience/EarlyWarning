EarlyWarning
============

This repository is for 'Code for Resilience'.

## Web APIs


### /receipt

twilioからのsend back

#### Request

x-www-form-urlencoded

#### Parameters

Key | Sample Value |
--- | --- | ---
AccountSid | ACbfae1408e8fdb5cb177a468840c534ce | 
ToZip | 
FromState | 
Called | +819070376915 | 
FromCountry | JP | 
CallerCountry | JP | 
CalledZip | 
Direction | outbound-api | 
FromCity | 
CalledCountry | JP | 
CallerState | 
CallSid | CA431d7174432cd2a30b30364b433b8256 | 
CalledState | 
From | +815031318881 | 
CallerZip | 
FromZip | 
CallStatus | in-progress | 
ToCity | 
ToState | 
To | +819070376915 | 
ToCountry | JP | 
CallerCity | 
ApiVersion | 2010-04-01 | 
Caller | +815031318881 | 
CalledCity | 

#### Sample

```
HTTP POST http://xxx.heroku.com/receipt

AccountSid=ACbfae1408e8fdb5cb177a468840c534ce&ToZip=&FromState=&Called=%2B819070376915&FromCountry=JP&CallerCountry=JP&CalledZip=&Direction=outbound-api&FromCity=&CalledCountry=JP&CallerState=&CallSid=CA431d7174432cd2a30b30364b433b8256&CalledState=&From=%2B815031318881&CallerZip=&FromZip=&CallStatus=in-progress&ToCity=&ToState=&To=%2B819070376915&ToCountry=JP&CallerCity=&ApiVersion=2010-04-01&Caller=%2B815031318881&CalledCity=
```


### /publish

警報発令

#### Request

application/json


#### Sample


