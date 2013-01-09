From: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Subject: Re: recoverying from 95% full osd
Date: Wed, 9 Jan 2013 15:47:28 +0600
Message-ID: <CAD5ewrr7tiVTR3zna_iKqzg-GfwmERey1g4dn92yMA6fQNaaYw@mail.gmail.com>
References: <CAD5ewroRv5-F0ZxBUmXqjz77zNenHQsrBacJ7LgXCqyduoxHsQ@mail.gmail.com>
	<CAPYLRzjv2tjndJCAgCqj8uBcGdC4vCiU1hd3oG2MdqLA7fW3Yg@mail.gmail.com>
	<CAD5ewrrKB0kxMDq2Hg-XStQUdVhjtgTWvmb3OoZTzHcZ3wpUrQ@mail.gmail.com>
	<alpine.DEB.2.00.1301082251590.2227@cobra.newdream.net>
	<778D42BCC03C4BB589117CE6FB62B5D6@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:34985 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380Ab3AIJr3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 04:47:29 -0500
Received: by mail-vc0-f176.google.com with SMTP id fo13so1332367vcb.35
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 01:47:29 -0800 (PST)
In-Reply-To: <778D42BCC03C4BB589117CE6FB62B5D6@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> How many pgs do you have? ('ceph osd dump | grep ^pool').
>
> I believe this is it. 384 PGs, but three pools of which only one (or maybe a second one, sort of) is in use. Automatically setting the right PG counts is coming some day, but until then being able to set up pools of the right size is a big gotcha. :(
> Depending on how mutable the data is, recreate with larger PG counts on the pools in use. Otherwise we can do something more detailed.
> -Greg

hm... what would be recommended PG size per pool ?

chef@cephgw:~$ ceph osd lspools
0 data,1 metadata,2 rbd,
chef@cephgw:~$ ceph osd pool get data pg_num
PG_NUM: 128
chef@cephgw:~$ ceph osd pool get metadata pg_num
PG_NUM: 128
chef@cephgw:~$ ceph osd pool get rbd pg_num
PG_NUM: 128

according to the http://ceph.com/docs/master/rados/operations/placement-groups/

                (OSDs * 100)
Total PGs = ------------
                   Replicas

I have 3 OSDs and 2 replicas for each object, which gives recommended PG = 150

will it make much difference to set 150 instead of 128 or I should
base on different values?

btw, just one more off-topic question:

chef@ceph-node03:~$ ceph pg dump| egrep -v '^(0\.|1\.|2\.)'| column -t
dumped             all        in         format     plain
version            113906
last_osdmap_epoch  323
last_pg_scan       1
full_ratio         0.95
nearfull_ratio     0.85
pg_stat            objects    mip        degr       unf    bytes
  log           disklog   state     state_stamp  v  reported  up
acting  last_scrub  scrub_stamp  last_deep_scrub  deep_scrub_stamp
pool               0          74748      0          0      0
  286157692336  17668034  17668034
pool               1          618        0          0      0
  131846062     6414518   6414518
pool               2          0          0          0      0
  0             0         0
sum                75366      0          0          0
286289538398  24082552      24082552
osdstat            kbused     kbavail    kb         hb     in
  hb            out
0                  157999220  106227596  264226816  [1,2]  []
1                  185604948  78621868   264226816  [0,2]  []
2                  219475396  44751420   264226816  [0,1]  []
sum                563079564  229600884  792680448

pool 0 (data) is used for data storage
pool 1 (metadata) is used for metadata storage

what is pool 2 (rbd) for? looks like it's absolutely empty.


>
>>
>> You might also adjust the crush tunables, see
>>
>> http://ceph.com/docs/master/rados/operations/crush-map/?highlight=tunable#tunables
>>
>> sage
>>

Thanks for the link, Sage I set tunable values according to the doc.
Btw, online document is missing magical param for crushmap which
allows those scary_tunables )



--
...WBR, Roman Hlynovskiy
