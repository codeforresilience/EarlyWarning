EarlyWarning
============

This repository is for 'Code for Resilience'.

## Web APIs

### GET /voices/receipt.xml

受付コールの発話内容、発信前にtwilioからリクエストがくる。まずは固定ファイルでOK。

#### Response

Sample

```
HTTP/1.1 200 OK
Content-Type: text/xml; charset=utf-8
Date: Sat, 08 Feb 2014 07:22:11 GMT
Transfer-Encoding: chunked
Vary: Accept-Encoding

<?xml version="1.0" encoding="UTF-8"?>
<Response>
<Say language="ja-JP" voice="alice">VOICE U R L の設定を変更することでこの文章を変更できます。</Say>
<Pause length="1"/>
<Say language="ja-JP" voice="alice">仕様のことでご不明点が御座いましたらご連絡ください。</Say>
</Response>
```


### POST /receipt

- twilioからの通話受信後のsend back
- Content-Type: x-www-form-urlencoded

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

#### Response

200かえせばOK?


### POST /publish

警報発令

- ContentType: application/json

#### Parameters



#### Sample


