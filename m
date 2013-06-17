From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 2/2] Enable fscache as an optional feature of ceph.
Date: Mon, 17 Jun 2013 13:43:00 -0400
Message-ID: <CANP1eJGuUAQeb84yK=3y6_tCa-Ay9Pa2gvMo7Pq2F3gGr9CdGA@mail.gmail.com>
References: <CANP1eJHwS2gjP=adgr-iJz3pw4LvZMs7PKDqrkTM2c4OimEeTg@mail.gmail.com>
	<alpine.DEB.2.00.1305281010270.16097@cobra.newdream.net>
	<CANP1eJGsCZcR00Bfbfswsfpz9gabXL57smTU3++QZdn_grQ7MA@mail.gmail.com>
	<CAKxz0mzP8p94hMc0RTzaa_gA-PwCoWFUkTba9zNc65+A6VEtLQ@mail.gmail.com>
	<CANP1eJHZskoMVa3KBGMHvxEfNcAJQdDK4ou47meaBDYzPVa=xg@mail.gmail.com>
	<CAKxz0mxQzYOk0uazXc9KjT1yr=-fk3YCprATChBPeqtv62_gug@mail.gmail.com>
	<CANP1eJGxbfdYhJcwz5uPWdQWTWMhHcueQcuhh3kQduyB5Y+ULg@mail.gmail.com>
	<CAKxz0mzgBYTd+bXGkP1jT5K0dcF-eL4H=vESM6CDe5gOPWBeAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:58338 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3FQRnB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jun 2013 13:43:01 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so7664219iec.21
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jun 2013 10:43:01 -0700 (PDT)
In-Reply-To: <CAKxz0mzgBYTd+bXGkP1jT5K0dcF-eL4H=vESM6CDe5gOPWBeAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elso Andras <elso.andras@gmail.com>
Cc: ceph-devel@vger.kernel.org

Elso,

It does cache the data to the file, thus it may not be useful for your
situation. By default the ceph filesystem already uses the (in memory)
page cache provided by linux kernel. So if that's all you want, than
you're good with the current implementation.

Generally large sequential data transfers will not be improved
(although there's cases where we observed improvements). The
motivation for us to implement fscache has been the following
use-case.

We have a large distributed analytics databases (built in house) and
we have a few different access patterns present. First, there's
seemingly random access on the compressed indexes. Second, there's
also random access in the column data files for extent indexes.
Finally, there's either sequential or random access over the actual
data (depending on the query).

In our cases the machines that run the database have multiple large
SSD drives in a raid0 configuration. We're using it the SSD drives for
scratch storage (housekeeping background jobs) and the ceph fscache.
In some conditions we can get up to 1GB/s reads from these SSD drives.

We're currently in our last stages of deploying this to production.
And for most workloads our query performance for data stored locally
versus on ceph backed by fscache is pretty much the same. Our biggest
gain probably comes from much lower latency to get metadata and
indexes to make the query due the large number random iops the SSD
drives afford us. I'm going to published some updates numbers compared
to previous quick and dirty prototype.

I realize that's not going to be the case for everybody. However, if
you have a data access pattern that follows the 80/20 rule or the
zipfan distribution and fast local disks for caching this is a great.

Thanks,
- Milosz


On Mon, Jun 17, 2013 at 1:09 PM, Elso Andras <elso.andras@gmail.com> wrote:
> Hi,
>
> Oh, i forgot about this daemon... but this daemon cache the data to
> file. Thus it's useless, the caching to disk is more slow than the
> whole osds.
>
> Elbandi
>
> 2013/6/17 Milosz Tanski <milosz@adfin.com>:
>> Elbandi,
>>
>> It looks like it's trying to use fscache (from the stats) but there's
>> no data. Did you install, configure and enable the cachefilesd daemon?
>> It's the user-space component of fscache. It's the only officially
>> supported fsache backed by Ubuntu, RHEL & SUSE. I'm guessing that's
>> your problem since I don't see any of the bellow lines in your dmesg
>> snippet.
>>
>> [2049099.198234] CacheFiles: Loaded
>> [2049099.541721] FS-Cache: Cache "mycache" added (type cachefiles)
>> [2049099.541727] CacheFiles: File cache on md0 registered
>>
>> - Milosz
>>
>> On Mon, Jun 17, 2013 at 11:47 AM, Elso Andras <elso.andras@gmail.com> wrote:
>>> Hi,
>>>
>>>
>>>> 1) In the graphs you attached what am I looking at? My best guess is that
>>>> it's traffic on a 10gigE card, but I can't tell from the graph since there's
>>>> no labels.
>>> Yes, 10G traffic on switch port. So "incoming" means server-to-switch,
>>> "outgoing" means switch-to-server. No separated card for ceph traffic
>>> :(
>>>
>>>> 2) Can you give me more info about your serving case. What application are
>>>> you using to serve the video (http server)? Are you serving static mp4 files
>>>> from Ceph filesystem?
>>> lighttpd server with mp4 streaming mod
>>> (http://h264.code-shop.com/trac/wiki/Mod-H264-Streaming-Lighttpd-Version2),
>>> the files lives on cephfs.
>>> there is a speed limit, controlled by mp4 mod. the bandwidth is the
>>> video bitrate value.
>>>
>>> mount options:
>>> name=test,rsize=0,rasize=131072,noshare,fsc,key=client.test
>>>
>>> rsize=0 and rasize=131072 is a tested, with other values there was 4x
>>> incoming (from osd) traffic than outgoing (to internet) traffic.
>>>
>>>> 3) What's the hardware, most importantly how big is your partition that
>>>> cachefilesd is on and what kind of disk are you hosting it on (rotating,
>>>> SSD)?
>>> there are 5 osd servers: HP DL380 G6, 32G ram, 16 X HP sas disk (10k
>>> rpm) with raid0. bonding two 1G interface together.
>>> (In previous life, this hw could serve the ~2.3G traffic with raid5
>>> and three bonding interface)
>>>
>>>> 4) Statistics from fscache. Can you paste the output /proc/fs/fscache/stats
>>>> and /proc/fs/fscache/histogram.
>>>
>>> FS-Cache statistics
>>> Cookies: idx=1 dat=8001 spc=0
>>> Objects: alc=0 nal=0 avl=0 ded=0
>>> ChkAux : non=0 ok=0 upd=0 obs=0
>>> Pages  : mrk=0 unc=0
>>> Acquire: n=8002 nul=0 noc=0 ok=8002 nbf=0 oom=0
>>> Lookups: n=0 neg=0 pos=0 crt=0 tmo=0
>>> Invals : n=0 run=0
>>> Updates: n=0 nul=0 run=0
>>> Relinqs: n=2265 nul=0 wcr=0 rtr=0
>>> AttrChg: n=0 ok=0 nbf=0 oom=0 run=0
>>> Allocs : n=0 ok=0 wt=0 nbf=0 int=0
>>> Allocs : ops=0 owt=0 abt=0
>>> Retrvls: n=2983745 ok=0 wt=0 nod=0 nbf=2983745 int=0 oom=0
>>> Retrvls: ops=0 owt=0 abt=0
>>> Stores : n=0 ok=0 agn=0 nbf=0 oom=0
>>> Stores : ops=0 run=0 pgs=0 rxd=0 olm=0
>>> VmScan : nos=0 gon=0 bsy=0 can=0 wt=0
>>> Ops    : pend=0 run=0 enq=0 can=0 rej=0
>>> Ops    : dfr=0 rel=0 gc=0
>>> CacheOp: alo=0 luo=0 luc=0 gro=0
>>> CacheOp: inv=0 upo=0 dro=0 pto=0 atc=0 syn=0
>>> CacheOp: rap=0 ras=0 alp=0 als=0 wrp=0 ucp=0 dsp=0
>>>
>>> No histogram, i try to build to enable this.
>>>
>>>> 5) dmesg lines for ceph/fscache/cachefiles like:
>>> [  264.186887] FS-Cache: Loaded
>>> [  264.223851] Key type ceph registered
>>> [  264.223902] libceph: loaded (mon/osd proto 15/24)
>>> [  264.246334] FS-Cache: Netfs 'ceph' registered for caching
>>> [  264.246341] ceph: loaded (mds proto 32)
>>> [  264.249497] libceph: client31274 fsid 1d78ebe5-f254-44ff-81c1-f641bb2036b6
>>>
>>>
>>> Elbandi
