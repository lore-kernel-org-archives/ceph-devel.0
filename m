From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ideal hardware spec?
Date: Mon, 27 Aug 2012 20:18:08 -0500
Message-ID: <503C1C50.90404@inktank.com>
References: <20120822135530.GB10015@csail.mit.edu> <5034EFAA.2050804@inktank.com> <CAJ_JamB5vtgt5TWOHhd-AZfDR7aL5QNKhy1Br-RLYF5PerF88A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38699 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab2H1BSN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 21:18:13 -0400
Received: by ialo24 with SMTP id o24so9547660ial.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 18:18:12 -0700 (PDT)
In-Reply-To: <CAJ_JamB5vtgt5TWOHhd-AZfDR7aL5QNKhy1Br-RLYF5PerF88A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Curtis C." <serverascode@gmail.com>
Cc: Jonathan Proulx <jon@csail.mit.edu>, ceph-devel@vger.kernel.org

On 08/27/2012 07:02 PM, Curtis C. wrote:
> On Wed, Aug 22, 2012 at 8:41 AM, Mark Nelson<mark.nelson@inktank.com>  wrote:
>> On 08/22/2012 08:55 AM, Jonathan Proulx wrote:
>>>
>>> Hi All,
>>
>>
>> Hi Jonathon!
>>
>>
>>>
>>> Yes I'm asking the impossible question, what is the "best" hardware
>>> confing.
>>
>>
>> That is the impossible question. :)
>>
>>
>>>
>>> I'm looking at (possibly) using ceph as backing store for images and
>>> volumes on OpenStack as well as exposing at least the object store for
>>> direct use.
>>>
>>> The openstack cluster exists and is currently in the early stages of
>>> use by researchers here, approx 1500 vCPU (counts hyperthreads
>>> actually 768 physical cores) and 3T or RAM across 64 physical nodes.
>>>
>>> On the object store side it would be a new resource for usand hard to
>>> say what people would do with it except that it would be many
>>> different things and the use profile would be constantly changing
>>> (which is true of all our existing storage).
>>>
>>> In this sense, even though it's a "private cloud" the somewhat
>>> unpredictable useage profile gives it some charateristics of a small
>>> public cloud.
>>>
>>> Size wise I'm hoping to start out with 3 monitors  and  5(+) OSD nodes
>>> to end up with a 20-30T 3x replicated storage (call me paranoid).
>>>
>>> So the monitor specs seem relatively easy to come up with.  For the
>>> OSDs it looks like
>>> http://ceph.com/docs/master/install/hardware-recommendations suggests
>>> 1 drive, 1 core and  2G RAM per OSD (with multiple OSDs per storage
>>> node).  On list discussions seem to frequently include an SSD for
>>> journaling (which is similar to what we do for our current ZFS back
>>> NFS storage).
>>>
>>> I'm hoping to wrap the hardware in a grant and willing to experiment a
>>> bit with different software configurations to tune it up when/if I get
>>> the hardware in.  So my imediate concern is a hardware spec that will
>>> ahve a reasonable processor:memory:disk ratio and opinions (or better
>>> data) on the utility of SSD.
>>
>>
>> Before I joined up with Inktank, I was prototyping a private openstack cloud
>> for HPC applications at a supercomputing site.  We similarly were pursuing
>> grant funding.  I know how it goes!
>>
>>
>>>
>>> First is the documented core to disk ratio still current best
>>> practice?  Given a platform with more drive slots could 8 cores handle
>>> more disk? would that need/like more memory?
>>
>>
>> The big thing is the CPU and memory needed during recovery.  During standard
>> operation you shouldn't be pushing the CPU too hard unless you are really
>> pushing data through fast and have many drives per node, or have severely
>> underspecced the CPU.
>>
>> Given that you are only shooting for around 90TB of space across 5+ osd
>> nodes, you should be able to get away with 12 2TB+ drive 2U boxes. That's
>> probably the closest thing we have right now to a "standard" configuration.
>> We use a single 6-core 2.8GHz AMD operation chip in each node with 16GB of
>> memory.  It might be worth bumping that up to 24-32GB of memory for very
>> large deployments with lots of OSDs.
>>
>> In terms of controller we are using Dell H700 cards which are similar to LSI
>> 9260s, but I think there is a good chance that it may actually be better to
>> use H200s (ie LSI 9211-8i or similar) with the IT/JBOD mode firmware.
>> That's one of the commonly used cards in ZFS builds too and has a pretty
>> good reputation.
>>
>> I've actually got a supermicro SC847a chassis and a whole bunch of various
>> SATA/SAS/RAID controllers I'm testing now in different configurations.
>> Hopefully I should have some data soon.  For now, our best tested
>> configuration is with 12 drive nodes.  Smaller 1U nodes may be an option as
>> well, but not very dense.
>>
>
> I've worked a bit with a Supermicro 36 drive bay chassis, though I've
> since moved on from the organization we had them in place at. I quite
> liked them. Wrote a bit of a blog post about them too
> (http://serverascode.com/2012/06/07/36-hot-swappable-day-supermicro-chassis.html)
> so I'm excited to see Inktank trying them out.
>

I really like this chassis.  It's one of the nicer ones that I've worked 
with.  The drives in the back could be a deal breaker for some, but I 
think it's a decent trade-off for what you get.

> The place I currently work at is a big OpenStack user and thinking
> about Ceph, but is not, as of yet, interested in a chassis like the
> Supermicro, so please post about your findings. :)
>
> Thanks,
> Curtis.
>

So far I've only been doing single controller tests with an onboard LSI 
SAS2208 and an external SAS2008 card (9211-8i).  The SAS2008 is actually 
slightly faster.  With 6 7200rpm SATA drives and 2 Intel 520 SSDs for 
journals I can do nearly 600MB/s with 1x replication and 4MB requests 
via rados bench.

I've got a couple of other cards to test (An Areca 1680, LSI SAS2308, 
and a Marvel based highpoint rocketraid card).  After that I'll start in 
on multiple controllers and more drives.  I also got the bracket I 
needed in for my 1U client node so I should be able to start in on 2x 
bonded 10GbE tests.

Hopefully I can convince the powers that be to let me fill out the 
SC847a chassis and maybe buy another one if the tests look good. ;)

>>
>>>
>>> Have SSD been shown to speed performance with this architecture?
>>
>>
>> Yes, but in different ways depending on how you use them.  SSDs for data
>> storage tend to help mitigate some of the seek behavior issues we've seen on
>> the filestore.  This isn't really a reasonable solution for a lot of people
>> though.
>>
>> In terms of the journal, the biggest benefit that SSDs provide is high
>> throughput, so you can load multiple journals onto 1 SSD and cram more OSDs
>> into one box.  Depending on how much you trust your SSDs, you could try
>> either a 10 disk + 2 SSD or a 9 disk + SSD configuration.  Keep in mind that
>> this will be writing a lot of data to the SSDs, so you should try to
>> undersubscribe them to lengthen the lifespan.  For testing I'm doing 3
>> journals per 180GB Intel 520 SSD.
>>
>>
>>>
>>> If so given the 8 drive slot example with seven OSDs presented in the
>>> docs what is the liklihood that using a high performance SSD for the
>>> OS image and also cutting journal/log partitions out of it for the
>>> remaining 7 2-3T near line SAS drives?
>>
>>
>> Just keep in mind that in this case you're total throughput will likely be
>> limited by the SSD unless you get a very fast one (or are using 1GbE or have
>> some other bottleneck).
>>
>>
>>>
>>> Thanks,
>>> -Jon
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Mark
