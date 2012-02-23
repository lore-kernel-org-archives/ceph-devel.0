From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Which SSD method is better for performance?
Date: Thu, 23 Feb 2012 12:02:34 +0100
Message-ID: <4F461CCA.8030703@widodh.nl>
References: <81C477727102DA4E9B2605AC748C495407E36DF6A4@exch10> <4F3A5786.7060006@widodh.nl> <81C477727102DA4E9B2605AC748C495407E36DF792@exch10> <Pine.LNX.4.64.1202191911060.31319@cobra.newdream.net> <81C477727102DA4E9B2605AC748C495407E36DF7B4@exch10> <CAF3hT9Cc2ga7h1xHCXNyhHhE_LV5jMDO=hW=QpiCs5zrf7fw8w@mail.gmail.com> <81C477727102DA4E9B2605AC748C495407E36DF7B7@exch10> <Pine.LNX.4.64.1202211332210.24624@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:36533 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab2BWLCh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 06:02:37 -0500
Received: from [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37] (unknown [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 80DFD3FB56
	for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 12:02:35 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.1202211332210.24624@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/21/2012 10:35 PM, Sage Weil wrote:
> On Tue, 21 Feb 2012, Paul Pettigrew wrote:
>> G'day Greg, thanks for the fast response.
>>
>> Yes, I forgot to explicitly state the Journal would go to SATA Journals in CASE1, and it is easy to appreciate the performance impact of this case as you documented nicely in your response.
>>
>> Re your second point:
>>> The other big advantage an SSD provides is in write latency; if you're
>>> journaling on an SSD you can send things to disk and get a commit back
>>> without having to wait on rotating media. How big an impact that will
>>> make will depend on your other config options and use case, though.
>>
>> Are you able to detail which config options tune this, and an example
>> use case to illustrate?
>
> Actually, I don't think there are many config options to worry about.
>
> The easiest way to see this latency is to do something like
>
>   rados mkpool foo
>   rados -p foo bench 30 write -b 4096 -t 1
>
> which will do a single small sync io at a time.  You'll notice a big
> difference depending on whether your journal is a file, raw partition,
> SSD, or NVRAM.

That is something you have to keep in mind when running your journal on 
an SSD.

If you run your journal on an SSD it's important to underpartition your 
SSD so the wear leveling inside the SSD can do it's job. You could also 
use hdparm to set the HPA (Host Protection Area) on the SSD limiting a 
100GB SSD to for example 16GB.

This gives the SSD spare cells inside which can be used for incoming writes.

SSD's are split into pages, which are normally about 256k. So when you 
write 4k, the whole 256k page has to be erased and re-programmed.

It's the erase which takes time. So when the SSD has spare pages your 
write will go to a already erased page and leaving the discarded page 
for the garbage collector to clean up. That will increase your write speed.

A Intel 80GB SSD for example can do 6600 random 4k writes.

(6600 * 4k) / 1024 = 25MB

So, with 4k writes you'll end up with a maximum performance of 25MB/sec 
on your OSD's journal.

Larger SSD's most of the times have better write performance. The 160GB 
from Intel does 8600 4k writes, the new 250GB SSD's even more.

It's to bad that for example the ZeusIOps are so expensive: 
http://www.stec-inc.com/product/zeusiops.php

Those SSD's are only 8GB, but they do about 50k random writes. We use 
them in a couple of ZFS appliances for the ZIL.

I've been looking for a small SSD with some DDR memory as a write cache, 
but I haven't been able to find an affordable one yet.

>
> When you have many parallel IOs (-t 100), you might also see a difference
> with a raw partition if you enable aio on the journal (journal aio = true
> in ceph.conf).  Maybe.  We haven't tuned that yet.
>
> sage
>
>
>
>>
>> Many thanks
>>
>> Paul
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Gregory Farnum
>> Sent: Tuesday, 21 February 2012 10:50 AM
>> To: Paul Pettigrew
>> Cc: Sage Weil; Wido den Hollander; ceph-devel@vger.kernel.org
>> Subject: Re: Which SSD method is better for performance?
>>
>> On Mon, Feb 20, 2012 at 4:44 PM, Paul Pettigrew<Paul.Pettigrew@mach.com.au>  wrote:
>>> Thanks Sage
>>>
>>> So following through by two examples, to confirm my understanding........
>>>
>>> HDD SPECS:
>>> 8x 2TB SATA HDD's able to do sustained read/write speed of 138MB/s
>>> each 1x SSD able to do sustained read/write speed of 475MB/s
>>>
>>> CASE1
>>> (not using SSD)
>>> 8x OSD's each for the SATA HDD's
>>> Therefore able to parallelise IO operations Sustained write sent to
>>> Ceph of very large file say 500GB (therefore caches all used up and
>>> bottleneck becomes SATA IO speed) Gives 8x 138MB/s = 1,104 MB/s
>>>
>>> CASE 2
>>> (using 1x SSD)
>>> SSD partitioned into 8x separate partitions, 1x for each OSD Sustained
>>> write (with OSD-Journal to SSD) sent to Ceph of very large file (say
>>> 500GB) Write spilt across 8x OSD-Journal partitions on the single SSD
>>> = limited to aggregate of 475MB/s
>>>
>>> ANALYSIS:
>>> If my examples are how Ceph operates, then it is necessary to not exceed a ratio of 3SATA:1SSD, if 4 or more SATA's are used then the SSD becomes the bottleneck.
>>>
>>> Is this analysis accurate? Are there other benefits that SSD provide (including in non-sustained peak write performance use case) that would otherwise justify their usage? What ratios are other users sticking to when deciding for their design?
>>
>> Well, you seem to be leaving out the journals entirely in the first case. You could put them on a separate partition on the SATA disks if you wanted, which (on a modern drive) would net you half the single-stream throughput, or ~552MB/s aggregate.
>>
>> The other big advantage an SSD provides is in write latency; if you're journaling on an SSD you can send things to disk and get a commit back without having to wait on rotating media. How big an impact that will make will depend on your other config options and use case, though.
>> -Greg
>>
>>>
>>> Many thanks all - this is all being rolled up into a new "Ceph SSD" wiki page I will be offering to Sage to include in the main Ceph wiki site.
>>>
>>> Paul
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
>>> Sent: Monday, 20 February 2012 1:16 PM
>>> To: Paul Pettigrew
>>> Cc: Wido den Hollander; ceph-devel@vger.kernel.org
>>> Subject: RE: Which SSD method is better for performance?
>>>
>>> On Mon, 20 Feb 2012, Paul Pettigrew wrote:
>>>> And secondly, should the SSD Journal sizes be large or small?  Ie, is
>>>> say 1G partition per paired 2-3TB SATA disk OK? Or as large an SSD as
>>>> possible? There are many forum posts that say 100-200MB will suffice.
>>>> A quick piece of advice will save us hopefully sever days of
>>>> reconfiguring and benchmarking the Cluster :-)
>>>
>>> ceph-osd will periodically do a 'commit' to ensure that stuff in the journal is written safely to the file system.  On btrfs that's a snapshot, on anything else it's a sync(2).  When the journals hits 50% we trigger a commit, or when a timer expires (I think 30 seconds by default).  There is some overhead associated with the sync/snapshot, so less is generally better.
>>>
>>> A decent rule of thumb is probably to make the journal big enough to consume sustained writes for 10-30 seconds.  On modern disks, that's probably 1-3GB?  If the journal is on the same spindle as the fs, it'll be probably half that...
>>> </hand waving>
>>>
>>> sage
>>>
>>>
>>>
>>>>
>>>> Thanks
>>>>
>>>> Paul
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: ceph-devel-owner@vger.kernel.org
>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wido den
>>>> Hollander
>>>> Sent: Tuesday, 14 February 2012 10:46 PM
>>>> To: Paul Pettigrew
>>>> Cc: ceph-devel@vger.kernel.org
>>>> Subject: Re: Which SSD method is better for performance?
>>>>
>>>> Hi,
>>>>
>>>> On 02/14/2012 01:39 AM, Paul Pettigrew wrote:
>>>>> G'day all
>>>>>
>>>>> About to commence an R&D eval of the Ceph platform having been impressed with the momentum achieved over the past 12mths.
>>>>>
>>>>> I have one question re design before rolling out to metal........
>>>>>
>>>>> I will be using 1x SSD drive per storage server node (assume it is /dev/sdb for this discussion), and cannot readily determine the pro/con's for the two methods of using it for OSD-Journal, being:
>>>>> #1. place it in the main [osd] stanza and reference the whole drive
>>>>> as a single partition; or
>>>>
>>>> That won't work. If you do that all OSD's will try to open the journal.
>>>> The journal for each OSD has to be unique.
>>>>
>>>>> #2. partition up the disk, so 1x partition per SATA HDD, and place
>>>>> each partition in the [osd.N] portion
>>>>
>>>> That would be your best option.
>>>>
>>>> I'm doing the same: http://zooi.widodh.nl/ceph/ceph.conf
>>>>
>>>> the VG "data" is placed on a SSD (Intel X25-M).
>>>>
>>>>>
>>>>> So if I were to code #1 in the ceph.conf file, it would be:
>>>>> [osd]
>>>>> osd journal = /dev/sdb
>>>>>
>>>>> Or, #2 would be like:
>>>>> [osd.0]
>>>>>           host = ceph1
>>>>>           btrfs devs = /dev/sdc
>>>>>           osd journal = /dev/sdb5
>>>>> [osd.1]
>>>>>           host = ceph1
>>>>>           btrfs devs = /dev/sdd
>>>>>           osd journal = /dev/sdb6
>>>>> [osd.2]
>>>>>           host = ceph1
>>>>>           btrfs devs = /dev/sde
>>>>>           osd journal = /dev/sdb7
>>>>> [osd.3]
>>>>>           host = ceph1
>>>>>           btrfs devs = /dev/sdf
>>>>>           osd journal = /dev/sdb8
>>>>>
>>>>> I am asking therefore, is the added work (and constraints) of specifying down to individual partitions per #2 worth it in performance gains? Does it not also have a constraint, in that if I wanted to add more HDD's into the server (we buy 45 bay units, and typically provision HDD's "on demand" i.e. 15x at a time as usage grows), I would have to additionally partition the SSD (taking it offline) - but if it were #1 option, I would only have to add more [osd.N] sections (and not have to worry about getting the SSD with 45x partitions)?
>>>>>
>>>>
>>>> You'd still have to go for #2. However, running 45 OSD's on a single machine is a bit tricky imho.
>>>>
>>>> If that machine fails you would loose 45 OSD's at once, that will put a lot of stress on the recovery of your cluster.
>>>>
>>>> You'd also need a lot of RAM to accommodate those 45 OSD's, at least 48GB of RAM I guess.
>>>>
>>>> A last note, if you use a SSD for your journaling, make sure that you align your partitions which the page size of the SSD, otherwise you'd run into the write amplification of the SSD, resulting in a performance loss.
>>>>
>>>> Wido
>>>>
>>>>> One final related question, if I were to use #1 method (which I would prefer if there is no material performance or other reason to use #2), then that specification (i.e. the "osd journal = /dev/sdb") SSD disk reference would have to be identical on all other hardware nodes, yes (I want to use the same ceph.conf file on all servers per the doco recommendations)? What would happen if for example, the SSD was on /dev/sde on a new node added into the cluster? References to /dev/disk/by-id etc are clearly no help, so should a symlink be used from the get-go? Eg something like "ln -s /dev/sdb /srv/ssd" on one box, and  "ln -s /dev/sde /srv/ssd" on the other box, so that in the [osd] section we could use this line which would find the SSD disk on all nodes "osd journal = /srv/ssd"?
>>>>>
>>>>> Many thanks for any advice provided.
>>>>>
>>>>> Cheers
>>>>>
>>>>> Paul
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

