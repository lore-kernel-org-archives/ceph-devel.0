From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: osd not in tree
Date: Fri, 16 Nov 2012 16:18:25 +0800
Message-ID: <CAJiejCSiz54N8mzLB1SQyOr9ObsQ4aE4=ZaUahpkd3cOw4X+qA@mail.gmail.com>
References: <CAJiejCR3CocWucemBR1++dAohOASLSidnwCc9G=2cREFuTTXXQ@mail.gmail.com>
 <50A5EE14.6070108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60135 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab2KPISp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 03:18:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so3241629iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 00:18:45 -0800 (PST)
In-Reply-To: <50A5EE14.6070108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/11/16 Josh Durgin <josh.durgin@inktank.com>:
> On 11/15/2012 11:21 PM, Drunkard Zhang wrote:
>>
>> I installed mon x1, mds x1 and osd x11 in one host, then add some osd
>> from other hosts, But they are not in osd tree, also not usable, how
>> can I fix this?
>>
>> The crush command I used:
>> ceph osd crush set 11 osd.11 3 pool=data datacenter=dh-1L, room=room1,
>> row=02, rack=05, host=squid87-log13
>
>
> Remove the commas in that command and it'll work. I fixed the docs for
> this.
>
> Josh

Got no luck. osd.11.log said nothing useful. Do I have to edit
crushmap manually? If so, how should I define host's 'id' value, I
cannot find docs from ceph.com/docs since yesterday, where's that
gone?

squid87-log13 ~ # ceph osd crush set 11 osd.11 3 pool=data
datacenter=dh-1L room=room1 row=02 rack=05 host=squid87-log13
updated item id 11 name 'osd.11' weight 3 at location
{datacenter=dh-1L,host=squid87-log13,pool=data,rack=05,room=room1,row=02}
to crush map
squid87-log13 ~ # ceph osd tree
dumped osdmap tree epoch 467
# id weight type name up/down reweight
-1 36 pool default
-3 36 rack unknownrack
-2 36 host log3
0 3 osd.0 up 3
1 3 osd.1 up 3
2 3 osd.2 up 3
3 3 osd.3 up 3
4 3 osd.4 up 3
5 3 osd.5 up 3
6 3 osd.6 up 3
7 3 osd.7 up 3
8 3 osd.8 up 3
9 3 osd.9 up 3
10 3 osd.10 up 3

11 0 osd.11 up 3
12 0 osd.12 up 3
13 0 osd.13 up 3
14 0 osd.14 up 3
