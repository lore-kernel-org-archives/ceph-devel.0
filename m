From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Sat, 16 Apr 2011 00:38:51 +0200
Message-ID: <4DA8C8FB.5050106@provocation.net>
References: <4DA85AA6.8050707@provocation.net> <3704E18884CB47E081E09984151ACC7B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:33489 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab1DOWjB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2011 18:39:01 -0400
In-Reply-To: <3704E18884CB47E081E09984151ACC7B@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/15/2011 10:21 PM, Gregory Farnum wrote:

> Can you give me more details about how your cluster was behaving at 
> that time? I can't quite match up what I'm seeing in the logs with 
> your description -- looks like node02 ran out of disk space for 
> logging at ~4:06:30 but I can't see from the logs why they were 
> passing leadership back and forth...

I have a hunch what might have happened, but please keep in mind that
I don't know ceph at all, so I'm much more likely to bark up a wrong
tree than the right one.

node01 is a Fujitsu Siemens C620, P4 3GHz, 2 GB RAM retrofitted with a
40-euro 2,5" SATA disk. It's a small and silent little box perfect for
testing stuff on, but not really a great performer. It runs the ceph
monitor and the only client. It looks like this:

[root@node01 ~]# df -m
Filesystem           1M-blocks      Used Available Use% Mounted on
/dev/sda1                15019      8267      5990  58% /
tmpfs                      993         0       993   0% /dev/shm
/dev/sda2                 7510      1308      5821  19% /var
/dev/sda5                15019       547     13710   4% /var/log
/dev/mapper/sda6        261029      1408    246362   1% /mnt/osd
192.168.178.100:6789:/
                        514984      2815    486009   1% /vol

where /mnt/osd is the raw ext4 store and /vol is the ceph-mount of it.

node02 is a Fujitsu Siemens RX-200 S2 with two dual-core 3GHz Xeon CPUs,
4 GB RAM and two SCSI 320 disks. If the amount of noise it makes is any
measure of its performance, it's in the LINPACK top 10.

My CRUSH rules say min_size 2 for all data types, meant to force a full
replication of everything to both nodes.

Last night I was copying an archived news spool of text-only newsgroups
to the ceph store with 'rsync -a spooldir node01:/vol/'. I have just over
a million files there, most of them between 1 and 2 KB in size. I noticed
a huge load on node01, top reporting a load of 15 to 25, but I let it grind
on anyway, until rsync got stuck and I gave up and went to bed. I never
checked the load on node02, but we can take it for granted that it was
way much lower.

Now, the cause of this tremendous load is a separate issue in itself, but
my hunch is that it might have triggered the chain of events that lead to
journal corruption. At 04:28 last night I wrote the following to this list,
but saved it as a draft instead of sending it because I wasn't sure I was
interpreting the log correctly:

===
2011-04-15 04:14:29.810679    pg v1605: 528 pgs: 528 active+clean; 452 MB data, 2011 MB used, 475 GB / 502 GB avail
2011-04-15 04:14:34.937142   log 2011-04-15 04:14:34.581267 mon0 192.168.178.100:6789/0 18 : [INF] osd0 192.168.178.100:6801/2615 failed (by osd1 192.168.178.101:6801/4630)
2011-04-15 04:14:35.118217    pg v1606: 528 pgs: 528 active+clean; 452 MB data, 2011 MB used, 475 GB / 502 GB avail
2011-04-15 04:14:39.899001   log 2011-04-15 04:14:39.645393 mon0 192.168.178.100:6789/0 19 : [INF] osd0 192.168.178.100:6801/2615 failed (by osd1 192.168.178.101:6801/4630)
2011-04-15 04:14:40.046747    pg v1607: 528 pgs: 528 active+clean; 453 MB data, 2011 MB used, 475 GB / 502 GB avail

While external host X is copying files to ceph node 0 which replicates on
node 1, node 1 claims that node 0 is dead, which it it isn't, and node 0
believes it and goes belly up.
===

Reading a bit of http://ceph.newdream.net/weil-thesis.pdf today, I noticed
this (page 127):

 The cluster initially elects a leader to serialize map updates and manage
 consistency. Once elected, the leader begins by requesting the map epochs
 stored by each monitor. Monitors have a fixed amount of time T (currently
 two seconds) to respond to the probe and join the quorum. The leader ensures
 that a majority of the monitors are active and that it has the most recent
 map epoch (requesting incremental updates from other monitors as necessary),
 and then begins distributing short-term leases to active monitors.

So I'm thinking now, what if node02, which I assume was alert and responsive,
was querying node01 and node01, because of the huge load that it was under,
was not responding within 2 seconds? Would node02 then tell all other nodes
that node01 is dead and node01 actually believe it, although the obituary was
about itself and it very well knew that it was alive and struggling?

If that is what happened, it would explain the passing of control back and
fro. In my mind it still doesn't explain the journal corruption, but that
might just mean that I need to do more reading.

As for the load, I'm copying the same news spool again today and I found
that 'rsync -a --bwlimit=20 spooldir node01:/vol/' gives a steady load of
2-3 on node01 and just around 1 on node02. That 20 is KBps, a ridiculously
low transfer speed, but the only way to space apart ceph's write operations.

> ...or why nothing happened between 4:06 and 4:33.

I had half an eye on ceph while doing other unrelated things. I saw rsync
hanging, checked some, but not all the logs, wrote the unposted posting
above, and then gave up and called it a day. 04:06 is probably the time
when the log partition filled up on node02 and 04:33 is likely the time
when I stopped ceph and shut down the machines. I think everything was hung
during that time, or rather deadlocked.

Z


