From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph 0.23.2 Consolidated questions
Date: Mon, 17 Jan 2011 17:04:47 +1300
Message-ID: <AANLkTim6KkUoPY-c_kbcKvc80raG+6gDU4ouu7WBcf9n@mail.gmail.com>
References: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
	<AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:39181 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab1AQEEy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Jan 2011 23:04:54 -0500
Received: by qyk12 with SMTP id 12so5314341qyk.19
        for <ceph-devel@vger.kernel.org>; Sun, 16 Jan 2011 20:04:48 -0800 (PST)
In-Reply-To: <AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

>> 2.
>> For benchmarking the entire ceph system in general, could you
>> recommend which tools to use, particularly best for Object based
>> storages?
> Well, I think the tools should mimic whatever workload you expect to run on it!
>> Would the block based storage benchmark, e.g., Iometer, be a bad
>> choice?, and why and why not?
>> I'm running fio (iometer-alike) to do random/sequentail read/write.
> Tools like this are common choices, yes.

Great, so I'll use the opensource spc-1 benchmark, too.
I'm testing dbench also, will see how it goes..

>> Questions.
>> - When journal size = 10000, why does the journal file in the /data/
>> shows as 1.8GB ?
> Is the journal a consistent 1.8GB, or was that just at one point (like
> the end of a run)? IIRC, the journal size is the most space it will
> use. A 10GB journal is very generous so probably the data is just
> being flushed from the journal to the data store quickly enough that
> the OSD doesn't need to keep around 10GB of data to guarantee
> consistency in the event of a power failure.
I find that the journal sizes are consistent up to about 2040, after
things starts to get weird.
So this is what I get when I set journal size
size 1000 - 1 GB
size 2000 - 2 GB
size 2050 - 0 MB
size 2500 - 0 MB
size 3000 - 0 MB
size 4000 - 0 MB
size 5000 - 904 MB
size 10000 - 1.8 GB
when journal gets the 0 MB then I obviously get the 'unable to open
superblock' error.


>> - Increasing osds (1 to 3 to 6) doesnt seem to increase any
>> performance at all (if so, hardly by a few %).
>> - In some cases, 6osds is lower than 3osds (for hdds DD copy in
>> particular, 1osd to 3osd increase, but 6osds deteriorates badly)
>>
>> - so I ended up using 2 nodes, with (1+1, 2+2, and 3+3 osd config),
>> and for hdds it seems to have increased linearly for DD.
>> - so why is having 6osds in 1 node, is slower than 3+3osds in 2 nodes?
> You have some odd constraints here that are probably interacting to
> produce strange results:
> 1) Your journal and your data store are on the same device. You seem
> to have enough disks available that I'd recommend separating them.

If it was a journaling issue, hmm, the ddplot still shows .. (see hdd-no1)
no journal 1osd  - 68.5 MB/s
no journal 3osds - 68.4 MB/s
no journal 6osds - 67.7 MB/s

Even without the journal, there's no linear or alike improvements.
If possible, I'd like to keep the journal in the same disk.. Using the
'extra' disk for the journal (or perhaps even using tmpfs) doesn't
sound appealing as far as performance measurements are concerned, at
least in some fair-testing sense.
It's leveraging too much..?; then any other fs or disks can do this as
well to improve, correct me please?
I'm really mainly testing for a single, easy and reliable out-of-box
setup, and would like to add more osds to see the clear increments of
performance. But I haven't yet managed to get this.

> 2) You have multiple cosds sharing network connections. This will
> produce some weird interactions in terms of bandwidth usage,
> especially if you don't have a hierarchical crushmap which keeps
> replicas on different physical hosts.
The real major concern was the performance scalability, I was testing
all x1, no replications.
And as the ddplot and benchmark plot shows, there's just no evidence
of any scalability,
(and I did x2 as well)

>> I was really expecting to see some linear increase or even visible
>> increase as I add more disks, but appears not at all...
> In general, I'd recommend running tests with a few more
> configurations. Try separating your journal and data store onto
> separate disks, and see how your OSDs do then. Try combining all your
> disks under your RAID card, running in no-journal mode (how well this
> works will correlate directly with how good your RAID card is).

Ok, I will try this, :]
For the HDD osds, I should then use an extra dedicated SSD just for
journal purpose? If so, then wouldn't the benchmark results be just
the measurement of this SSD in the end?
The RAID card is quite a good one (512MB ddr2 ram with battery), I
wanted to stay away from any RAID0/1 configuration, basically leaving
up to ceph/osd to handle!.
The only reason why all of the disks (SSDs and HDDs) are connected to
RAID card is because of the typical server-grade environment (3U
supporting 16 disks), and the internal SATAs are only limited to 6.
I know there's a clear performance difference between the HW vs SW
controllers (mainly the ram). Currently all of the disks are already
advantaged by the RAID. so the previous plot results should already be
'better' than the internal SATA.


>
>> 4.
>> For the PG setup, using a simple ceph.conf (just osd[123] to a single machine)
>> and setting the repl to x1, how would I expect the objects to get
>> mapped to disks?
>> How do I really configure and control how things go?
> I'll leave your questions about the CRUSH map to others, except for one note:
> The pseudo-random placement of data is one of Ceph's greatest
> strengths. It provides you mechanisms for working around this in
> certain cases, but if it's something you need to do often you might
> want to look into another distributed FS which expects you to be
> placing data manually.

Right, say if I have say 10 objects, how would this be written/read to
the 2osds? for both 1x and 2x.
By default configuration, x2 with 2osds, will make the objects reside
on each osd (basically identical to the mirrored)
If not, how to manually configure (OSDs) to behave like RAID 0 and 1 ?
Can you give me an example please?
Seeing the crush example on the wiki 'A CRUSH map with 12 hosts, 4
hosts per rack and 3 racks',
It just shows the hierarchy and doesn't say which part will be used
for e.g., 1x, 2x or 3x replc, and so on..
and as I understand, 4 types of buckets are useful for adding/removing?
Again, the cpus and ram usages are not the bottleneck when running the
benchmark I see.
I think Sage's crush talked about multiple take and emit, so do I need
like take root1, and take root2 ?

Thanks a lot.
DJ
