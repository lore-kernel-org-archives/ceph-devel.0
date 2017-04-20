From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: another scrub bug? blocked for > 10240.948831 secs
Date: Thu, 20 Apr 2017 20:58:20 +0200
Message-ID: <b8e72ba6-919b-e9f2-9fd3-577cb7ab6389@brockmann-consult.de>
References: <94127293-3ba3-8bb8-db43-604b6a54eb55@brockmann-consult.de>
 <alpine.DEB.2.11.1704171316150.10661@piezo.novalocal>
 <456cafe7-ecaa-5c62-ca82-6c09a2b06ae7@brockmann-consult.de>
 <alpine.DEB.2.11.1704201421120.6575@piezo.novalocal>
 <d0b1c505-8ccd-dfbf-2dd8-c44fc3f7b96e@brockmann-consult.de>
 <alpine.DEB.2.11.1704201617120.6575@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:54411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943312AbdDTS5y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Apr 2017 14:57:54 -0400
In-Reply-To: <alpine.DEB.2.11.1704201617120.6575@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 04/20/17 18:19, Sage Weil wrote:
> On Thu, 20 Apr 2017, Peter Maloney wrote:
>> On 04/20/17 16:23, Sage Weil wrote:
>>> On Thu, 20 Apr 2017, Peter Maloney wrote:
>>>> On 04/17/17 15:18, Sage Weil wrote:
>>>>> Next time you see it, can you capture the output of 'ceph daemon osd.NNN 
>>>>> ops' so we can see what steps the request went through?  Also, any 
>>>>> additional or more specific clues as to what might have triggered it would 
>>>>> help.
>>>>>
>>>>> Thanks!
>>>>> sage
>>>>>
>>>> Here, we go...
>>>>
>>>>> ...
>>>>>
>>>>> {
>>>>>     "ops": [
>>>>>         {
>>>>>             "description": "replica scrub(pg:
>>>>> 4.2d,from:0'0,to:79873'5433886,epoch:79873,start:4:b46a9ab4:::rbd_data.43e4a9238e1f29.00000000000019fe:e438,end:4:b46a9ab4:::rbd_data.43e4a9238e1f29.00000000000019fe:e43a,chunky:1,deep:1,seed:4294967295,version:6)",
>>>>>             "initiated_at": "2017-04-19 23:22:37.568657",
>>>>>             "age": 30563.826540,
>>>>>             "duration": 30563.826803,
>>>>>             "type_data": [
>>>>>                 "reached pg",
>>>>>                 [
>>>>>                     {
>>>>>                         "time": "2017-04-19 23:22:37.568657",
>>>>>                         "event": "initiated"
>>>>>                     },
>>>>>                     {
>>>>>                         "time": "2017-04-19 23:22:37.568769",
>>>>>                         "event": "queued_for_pg"
>>>>>                     },
>>>>>                     {
>>>>>                         "time": "2017-04-19 23:22:37.568814",
>>>>>                         "event": "reached_pg"
>>>>>                     }
>>>>>                 ]
>>>>>             ]
>>>>>         }
>>>>>     ],
>>>>>     "num_ops": 1
>>>>> }
>>>>>
>>>> to me that looks kinda non-useful... anything else you need? (I think
>>>> I'll leave this one alone for a while in case you reply soon and want
>>>> something)
>>> Hmm.  Yeah, not terribly helpful.  Can you attach a 'ceph osd dump -f 
>>> json-pretty' for epoch 79870 through 79880, as well as the latest?
>>>
>>> My best guess is this is an interaction with snap trimming; the osdmap 
>>> should indicate if a snap was deleted right around then.
>>>
>>> Thanks!
>>> sage
>> I restarted some osds which cleared the previous block...but here is a
>> new one.
>>
>>> 2017-04-20 17:13:20.650929 osd.9 10.3.0.132:6807/1084881 4776 :
>>> cluster [WRN] 1 slow requests, 1 included below; oldest blocked for >
>>> 2560.473108 secs
>>> 2017-04-20 17:13:20.650933 osd.9 10.3.0.132:6807/1084881 4777 :
>>> cluster [WRN] slow request 2560.473108 seconds old, received at
>>> 2017-04-20 16:30:40.177787: replica scrub(pg:
>>> 4.27,from:0'0,to:83264'5292979,epoch:83264,start:4:e45da22f:::rbd_data.4d3c7e2ae8944a.000000000000388e:0,end:4:e45da2cc:::rbd_data.46820b238e1f29.0000000000008bf4:e5c4,chunky:1,deep:0,seed:4294967295,version:6)
>>> currently reached_pg
>>>
>>
>> And some osd dump stuff....which seems all the same. Which fields are
>> you looking for? And are you sure you want the epoch around that time,
>> not 2560 seconds before?
> The epoch number came from the scrub op that got blocked ("epoch:83264" 
> from the op string), so it should be right around then...
I understand that, so I used a different range in this one since it's a
new blocked request. (and made it automatic so a large range is easy and
made it huge since it wasn't any different when I looked manually)

And I see that the log always has the same epoch for the request...not
the current epoch. So I guess it's not 2560 seconds before that. And
found the problem...my script didn't use $n in the actual dump so it
repeated the same dump ;)

So here's a proper dump. I hope you find the problem.

> oldx=
> for n in {83244..83290}; do
>     x=$(ceph osd dump "$n" -f json-pretty | jq ".pools | .[] |
> select(.pool == 4)" | grep snap)
>     if [ "$x" != "$oldx" ]; then
>         echo $n
>         echo "$x"
>     fi
>     oldx="$x"
> done

> 83244
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58814,
>   "snap_epoch": 83244,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4cd,e4cf~1,e4d1~1,e4d3~1,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~
 1,e5b1~1,e5b3~1,e5b5~1,e5b7~1,e5b9~1,e5bb~1,e5bd~1]",
> 83253
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58815,
>   "snap_epoch": 83253,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4cf,e4d1~1,e4d3~1,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~
 1,e5b3~1,e5b5~1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1]",
> 83254
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58816,
>   "snap_epoch": 83254,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4cf,e4d1~1,e4d3~1,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~
 1,e5b3~1,e5b5~1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1]",
> 83257
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58817,
>   "snap_epoch": 83257,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d1,e4d3~1,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~
 1,e5b5~1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1]",
> 83258
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58818,
>   "snap_epoch": 83258,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d1,e4d3~1,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~
 1,e5b5~1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1]",
> 83259
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58819,
>   "snap_epoch": 83259,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~
 1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1]",
> 83260
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58820,
>   "snap_epoch": 83260,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~
 1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1]",
> 83269
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58821,
>   "snap_epoch": 83269,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~
 1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1]",
> 83270
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58822,
>   "snap_epoch": 83270,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~
 1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1]",
> 83271
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58823,
>   "snap_epoch": 83271,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~
 1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1]",
> 83276
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58824,
>   "snap_epoch": 83276,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~1,e563~1,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~
 1,e5b7~1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1]",
> 83277
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58825,
>   "snap_epoch": 83277,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c9~1]",
> 83278
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58826,
>   "snap_epoch": 83278,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~1,e5c9~2]",
> 83279
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58827,
>   "snap_epoch": 83279,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~2,e5c9~3]",
> 83280
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58828,
>   "snap_epoch": 83280,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~3,e5c9~4]",
> 83281
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58829,
>   "snap_epoch": 83281,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9]",
> 83282
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58830,
>   "snap_epoch": 83282,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9]",
> 83283
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58831,
>   "snap_epoch": 83283,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9]",
> 83284
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58832,
>   "snap_epoch": 83284,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9]",
> 83287
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58833,
>   "snap_epoch": 83287,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9]",
> 83288
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58834,
>   "snap_epoch": 83288,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d3,e4d5~1,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~
 1,e5b9~1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9]",
> 83289
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58835,
>   "snap_epoch": 83289,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d5,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~1,e5b9~
 1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9,e5d3~1]",
> 83290
>   "snap_mode": "selfmanaged",
>   "snap_seq": 58836,
>   "snap_epoch": 83290,
>   "pool_snaps": [],
>   "removed_snaps":
> "[1~e4d5,e4d7~1,e4d9~1,e4db~1,e4dd~1,e4df~1,e4e1~1,e4e3~1,e4e5~1,e4e7~1,e4e9~1,e4eb~1,e4ed~1,e4ef~1,e4f1~1,e4f3~1,e4f5~1,e4f7~1,e4f9~1,e4fb~1,e4fd~1,e4ff~1,e501~1,e503~1,e505~1,e507~1,e509~1,e50b~1,e50d~1,e50f~1,e511~1,e513~1,e515~1,e517~1,e519~1,e51b~1,e51d~1,e51f~1,e521~1,e523~1,e525~1,e527~1,e529~1,e52b~1,e52d~1,e52f~1,e531~1,e533~1,e535~1,e537~1,e539~1,e53b~1,e53d~1,e53f~1,e541~1,e543~1,e545~1,e547~1,e549~1,e54b~1,e54d~1,e54f~1,e551~1,e553~1,e555~1,e557~1,e559~1,e55b~1,e55d~1,e55f~1,e561~3,e565~1,e567~1,e569~1,e56b~1,e56d~1,e56f~1,e571~1,e573~1,e575~1,e577~1,e579~1,e57b~1,e57d~1,e57f~1,e581~1,e583~1,e585~1,e587~1,e589~1,e58b~1,e58d~1,e58f~1,e591~1,e593~1,e595~1,e597~1,e599~1,e59b~1,e59d~1,e59f~1,e5a1~1,e5a3~1,e5a5~1,e5a7~1,e5a9~1,e5ab~1,e5ad~1,e5af~1,e5b1~1,e5b3~1,e5b5~1,e5b7~1,e5b9~
 1,e5bb~1,e5bd~1,e5bf~1,e5c1~1,e5c3~1,e5c5~9,e5d3~1]",


>  but I guess the 
> underlying first question is whether any snap deletion happened anywhere 
> around this period (2560+ sec before the warning, or around the time the 
> op was sent in epoch 83264).  
A snapshot based backup thing ran at 12:00 CEST and took until 18:25
CEST to finish, which overlaps that, and creates and removes 120
snapshots spread throughout the process.
> (And yeah, removed_snaps is the field that 
> matters here!)
>
> Thanks!
> sage


