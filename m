From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Fwd: Client still connect failed leader after that mon down
Date: Mon, 21 Dec 2015 17:49:03 +0800
Message-ID: <CAGkCoN+6_igAC=4QPgmM-0K6sezCK35KQusYR15pyJEJRtmHfg@mail.gmail.com>
References: <CAKZcxgeK8=au4yBxcsP+=ewtFr8_ruZCxUKJtWWSk6eGc-b8Ow@mail.gmail.com>
 <alpine.DEB.2.00.1512170525540.10312@cobra.newdream.net> <56738059.3070505@gmail.com>
 <CAGkCoNKYiJ+KWEg7w-JAF9tq+X9LtWV5X2OJcEp81yF9+Y4W2g@mail.gmail.com>
 <CAKZcxge7gaa7A5M=dg1Ri3WQ9UY7CP0RMenZrHUhGOjQVx7H1Q@mail.gmail.com> <CAKZcxgf+Ghr9TVFAJhs3nQfY==uy6XrtJ-FuT6LCjBK3cGkc5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34183 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbLUJtp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 04:49:45 -0500
Received: by mail-wm0-f49.google.com with SMTP id l126so60922303wml.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 Dec 2015 01:49:44 -0800 (PST)
In-Reply-To: <CAKZcxgf+Ghr9TVFAJhs3nQfY==uy6XrtJ-FuT6LCjBK3cGkc5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com



---------- Forwarded message ----------
=46rom: Jaze Lee <jazeltq@gmail.com>
Date: Mon, Dec 21, 2015 at 4:08 PM
Subject: Re: Client still connect failed leader after that mon down
To: Zhi Zhang <zhang.david2011@gmail.com>


Hello,
I am terrible sorry.
I think we may not need to reconstruct the monclient.{h,cc}, we find
the parameter is mon_client_hunt_interval is very usefull.
When we set mon_client_hunt_interval =3D 0.5=EF=BC=8C the time to run a=
 ceph
command is very small even it first connects the down leader mon.

The first time i ask the question was because we find the parameter
from official site
http://docs.ceph.com/docs/master/rados/configuration/mon-config-ref/.
It is write in this

mon client hung interval

Description:The client will try a new monitor every N seconds until it
establishes a connection.
Type:Double
Default:3.0

And we set it. it is not work.

I think may be it is a slip of pen?
The right configuration parameter should be mon client hunt interval

Can someone please help me to fix this in official site?

Thanks a lot.



2015-12-21 14:00 GMT+08:00 Jaze Lee <jazeltq@gmail.com>:
> right now we use simple msg, and cpeh version is 0.80...
>
> 2015-12-21 10:55 GMT+08:00 Zhi Zhang <zhang.david2011@gmail.com>:
>> Which msg type and ceph version are you using?
>>
>> Once we used 0.94.1 with async msg, we encountered similar issue.
>> Client was trying to connect a down monitor when it was just started
>> and this connection would hung there. This is because previous async
>> msg used blocking connection mode.
>>
>> After we back ported non-blocking mode of async msg from higher ceph
>> version, we haven't encountered such issue yet.
>>
>>
>> Regards,
>> Zhi Zhang (David)
>> Contact: zhang.david2011@gmail.com
>>               zhangz.david@outlook.com
>>
>>
>> On Fri, Dec 18, 2015 at 11:41 AM, Jevon Qiao <scaleqiao@gmail.com> w=
rote:
>>> On 17/12/15 21:27, Sage Weil wrote:
>>>>
>>>> On Thu, 17 Dec 2015, Jaze Lee wrote:
>>>>>
>>>>> Hello cephers:
>>>>>      In our test, there are three monitors. We find client run ce=
ph
>>>>> command will slow when the leader mon is down. Even after long ti=
me, a
>>>>> client run ceph command will also slow in first time.
>>>>> >From strace, we find that the client first to connect the leader=
, then
>>>>> after 3s, it connect the second.
>>>>> After some search we find that the quorum is not change, the lead=
er is
>>>>> still the down monitor.
>>>>> Is that normal?  Or is there something i miss?
>>>>
>>>> It's normal.  Even when the quorum does change, the client doesn't
>>>> know that.  It should be contacting a random mon on startup, thoug=
h, so I
>>>> would expect the 3s delay 1/3 of the time.
>>>
>>> That's because client randomly picks up a mon from Monmap. But what=
 we
>>> observed is that when a mon is down no change is made to monmap(nei=
ther the
>>> epoch nor the members). Is it the culprit for this phenomenon?
>>>
>>> Thanks,
>>> Jevon
>>>
>>>> A long-standing low-priority feature request is to have the client=
 contact
>>>> 2 mons in parallel so that it can still connect quickly if one is =
down.
>>>> It's requires some non-trivial work in mon/MonClient.{cc,h} though=
 and I
>>>> don't think anyone has looked at it seriously.
>>>>
>>>> sage
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> =E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90



--
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
