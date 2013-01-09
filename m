From: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Subject: Re: recoverying from 95% full osd
Date: Wed, 9 Jan 2013 10:19:36 +0600
Message-ID: <CAD5ewroefhXifqMk2cxiNCFx1TOALKL4n-GB5OcxiQ29ze0s3A@mail.gmail.com>
References: <CAD5ewroRv5-F0ZxBUmXqjz77zNenHQsrBacJ7LgXCqyduoxHsQ@mail.gmail.com>
	<50EC464B.4090607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:63470 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489Ab3AIETh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 23:19:37 -0500
Received: by mail-vc0-f182.google.com with SMTP id fy27so1180358vcb.27
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 20:19:36 -0800 (PST)
In-Reply-To: <50EC464B.4090607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello Mark,

ok, adding another osd is a good option, however my initial plan was
to raise full ratio watermark and remove unnecessary data. it' clear
for me that overfilling one of osd will cause big problems to the fs
consistency.
But... 2 other OSDs are still having plenty of space. what is the
difference between having pretty fresh OSD with plenty of space and
using current OSDs with plenty of fresh space from ceph point of view?


surprisingly my setup is rather standard ) all according to the online manuals

chef@ceph-node01:~$ ceph -s
   health HEALTH_ERR 1 full osd(s)
   monmap e4: 3 mons at
{a=192.168.7.11:6789/0,b=192.168.7.12:6789/0,c=192.168.7.13:6789/0},
election epoch 242, quorum 0,1,2 a,b,c
   osdmap e321: 3 osds: 3 up, 3 in full
    pgmap v113335: 384 pgs: 384 active+clean; 305 GB data, 614 GB
used, 141 GB / 755 GB avail
   mdsmap e4599: 1/1/1 up {0=a=up:active}, 2 up:standby

If I get it correct I have 384 PGs.


my crushmap is also pretty straightforward:


chef@ceph-node03:~$ ./get_crushmap.sh
got crush map from osdmap epoch 321
# begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 pool

# buckets
host ceph-node01 {
    id -2        # do not change unnecessarily
    # weight 1.000
    alg straw
    hash 0    # rjenkins1
    item osd.0 weight 1.000
}
host ceph-node02 {
    id -4        # do not change unnecessarily
    # weight 1.000
    alg straw
    hash 0    # rjenkins1
    item osd.1 weight 1.000
}
host ceph-node03 {
    id -5        # do not change unnecessarily
    # weight 1.000
    alg straw
    hash 0    # rjenkins1
    item osd.2 weight 1.000
}
rack unknownrack {
    id -3        # do not change unnecessarily
    # weight 3.000
    alg straw
    hash 0    # rjenkins1
    item ceph-node01 weight 1.000
    item ceph-node02 weight 1.000
    item ceph-node03 weight 1.000
}
pool default {
    id -1        # do not change unnecessarily
    # weight 3.000
    alg straw
    hash 0    # rjenkins1
    item unknownrack weight 3.000
}

# rules
rule data {
    ruleset 0
    type replicated
    min_size 1
    max_size 10
    step take default
    step chooseleaf firstn 0 type host
    step emit
}
rule metadata {
    ruleset 1
    type replicated
    min_size 1
    max_size 10
    step take default
    step chooseleaf firstn 0 type host
    step emit
}
rule rbd {
    ruleset 2
    type replicated
    min_size 1
    max_size 10
    step take default
    step chooseleaf firstn 0 type host
    step emit
}

# end crush map


actually I have a theory for this strange data distribution. The whole
stuff is running in a virtualized environment. each ceph-node is
running on it's own physical server, however overall load for every
server is pretty much different. the node with 95% used OSD is running
on the least loaded system. Could it be that additional i/o waits for
the other systems are causing ceph to write data to the least loaded
osd node?



2013/1/8 Mark Nelson <mark.nelson@inktank.com>:
> On 01/08/2013 04:42 AM, Roman Hlynovskiy wrote:
>>
>> Hello,
>>
>> I am running ceph v0.56 and at the moment trying to recover ceph which
>> got completely stuck after 1 osd got filled by 95%. Looks like the
>> distribution algorithm is not perfect since all 3 OSD's I user are
>> 256Gb each, however one of them got filled faster than others:
>>
>> osd-1:
>> Filesystem            Size  Used Avail Use% Mounted on
>> /dev/mapper/vg00-osd  252G  173G   80G  69% /var/lib/ceph/osd/ceph-0
>>
>> osd-2:
>> Filesystem            Size  Used Avail Use% Mounted on
>> /dev/mapper/vg00-osd  252G  203G   50G  81% /var/lib/ceph/osd/ceph-1
>>
>> osd-3:
>> Filesystem            Size  Used Avail Use% Mounted on
>> /dev/mapper/vg00-osd  252G  240G   13G  96% /var/lib/ceph/osd/ceph-2
>>
>>
>> by the moment mds is showing the following behaviour:
>> 2013-01-08 16:25:47.006354 b4a73b70  0 mds.0.objecter  FULL, paused
>> modify 0x9ba63c0 tid 23448
>> 2013-01-08 16:26:47.005211 b4a73b70  0 mds.0.objecter  FULL, paused
>> modify 0xca86c30 tid 23449
>>
>> so, it does not respond to any mount requests
>>
>> I've played around with all types of commands like:
>> ceph mon tell \* injectargs '--mon-osd-full-ratio 98'
>> ceph mon tell \* injectargs '--mon-osd-full-ratio 0.98'
>>
>> and
>>
>> 'mon osd full ratio = 0.98' in mon configuration for each mon
>>
>> however
>>
>> chef@ceph-node03:/var/log/ceph$ ceph health detail
>> HEALTH_ERR 1 full osd(s)
>> osd.2 is full at 95%
>>
>> mds still believes 95% is the threshold, so no responses to mount
>> requests.
>>
>> chef@ceph-node03:/var/log/ceph$ rados -p data bench 10 write
>>   Maintaining 16 concurrent writes of 4194304 bytes for at least 10
>> seconds.
>>   Object prefix: benchmark_data_ceph-node03_3903
>> 2013-01-08 16:33:02.363206 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa467ff0 tid 1
>> 2013-01-08 16:33:02.363618 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa468780 tid 2
>> 2013-01-08 16:33:02.363741 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa468f88 tid 3
>> 2013-01-08 16:33:02.364056 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa469348 tid 4
>> 2013-01-08 16:33:02.364171 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa469708 tid 5
>> 2013-01-08 16:33:02.365024 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa469ac8 tid 6
>> 2013-01-08 16:33:02.365187 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46a2d0 tid 7
>> 2013-01-08 16:33:02.365296 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46a690 tid 8
>> 2013-01-08 16:33:02.365402 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46aa50 tid 9
>> 2013-01-08 16:33:02.365508 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46ae10 tid 10
>> 2013-01-08 16:33:02.365635 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46b1d0 tid 11
>> 2013-01-08 16:33:02.365742 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46b590 tid 12
>> 2013-01-08 16:33:02.365868 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46b950 tid 13
>> 2013-01-08 16:33:02.365975 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46bd10 tid 14
>> 2013-01-08 16:33:02.366096 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46c0d0 tid 15
>> 2013-01-08 16:33:02.366203 b6be3710  0 client.9958.objecter  FULL,
>> paused modify 0xa46c490 tid 16
>>     sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg
>> lat
>>       0      16        16         0         0         0         -
>> 0
>>       1      16        16         0         0         0         -
>> 0
>>       2      16        16         0         0         0         -
>> 0
>>
>> rados doesn't work.
>>
>> chef@ceph-node03:/var/log/ceph$ ceph osd reweight-by-utilization
>> no change: average_util: 0.812678, overload_util: 0.975214. overloaded
>> osds: (none)
>>
>> this one also.
>>
>>
>> is there any chance to recover ceph?
>
>
> Hi,
>
> There may be other ways to fix it, but one method might be to simply add
> another OSD so the data gets redistributed.  I wouldn't continue to modify
> osd full ratio up.  I think Sam's said in the past it can make a minor
> problem into a very big problem if you fill an OSD all the way. Another
> option that may (or may not) work as a temporary solution is to change the
> osd weights.
>
> Having said that, I'm curious to know how many PGs you have?  Do you have a
> custom crush map?  That distribution is pretty skewed!
>
> Thanks,
> Mark



-- 
...WBR, Roman Hlynovskiy
