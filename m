From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph 0.23.2 Consolidated questions
Date: Thu, 13 Jan 2011 09:32:22 -0800
Message-ID: <AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
References: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63708 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756901Ab1AMRcY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jan 2011 12:32:24 -0500
Received: by eye27 with SMTP id 27so973790eye.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Jan 2011 09:32:22 -0800 (PST)
In-Reply-To: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 12, 2011 at 5:24 PM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
> 1.
> about the bug track: http://tracker.newdream.net/issues/479
> when using Ext4, I now found that the hang happens when a client runs
> on the same machine as the ceph-system.
> But the hang does not happen when a client runs on different machine.
I haven't looked at any of this closely, but how's your memory use?
One reason we recommend not running clients on the same nodes as OSDs
is because if you run into memory pressure you can deadlock if trying
to write to the Ceph mount.

> 2.
> For benchmarking the entire ceph system in general, could you
> recommend which tools to use, particularly best for Object based
> storages?
Well, I think the tools should mimic whatever workload you expect to run on it!
> Would the block based storage benchmark, e.g., Iometer, be a bad
> choice?, and why and why not?
> I'm running fio (iometer-alike) to do random/sequentail read/write.
Tools like this are common choices, yes.
> I did rados test, too. 'rados -p metadata bench write' command should
> be writing to mds node, but it was doing it on osd nodes (i.e,, same
> as the data node)
I think you're misunderstanding how the MDS data storage works. They
don't store any data locally, all MDS data goes in the metadata pool,
which is stored on the OSDs. Pools are logical groupings of data
within RADOS.

> also, 'seq' crashes with lots of errors.
Hmmm. The rados bencher was always a pretty lightweight and fragile
tool, but you may have more luck if you build the tool in a newer
version of Ceph. Sam made a lot of changes to strengthen that stuff.

> Questions.
> - When journal size = 10000, why does the journal file in the /data/
> shows as 1.8GB ?
Is the journal a consistent 1.8GB, or was that just at one point (like
the end of a run)? IIRC, the journal size is the most space it will
use. A 10GB journal is very generous so probably the data is just
being flushed from the journal to the data store quickly enough that
the OSD doesn't need to keep around 10GB of data to guarantee
consistency in the event of a power failure.
> - Also, journal write ahead or parallel? which mode do I need to set
> for ssd or harddisk? (the plot answers, basically ahead/parallel okay)
In write ahead mode, all data goes to the journal and then to the data
store. In parallel, it gets sent to both at the same time.
Since you're running on ext4, you should be using writeahead as
parallel isn't actually safe. I believe that the OSD is actually
detecting that and switching you to writeahead, there should be a
warning somewhere. If it's not switching, that's a bug!

> - Increasing osds (1 to 3 to 6) doesnt seem to increase any
> performance at all (if so, hardly by a few %).
> - In some cases, 6osds is lower than 3osds (for hdds DD copy in
> particular, 1osd to 3osd increase, but 6osds deteriorates badly)
>
> - so I ended up using 2 nodes, with (1+1, 2+2, and 3+3 osd config),
> and for hdds it seems to have increased linearly for DD.
> - so why is having 6osds in 1 node, is slower than 3+3osds in 2 nodes?
You have some odd constraints here that are probably interacting to
produce strange results:
1) Your journal and your data store are on the same device. You seem
to have enough disks available that I'd recommend separating them.
2) You have multiple cosds sharing network connections. This will
produce some weird interactions in terms of bandwidth usage,
especially if you don't have a hierarchical crushmap which keeps
replicas on different physical hosts.
> I was really expecting to see some linear increase or even visible
> increase as I add more disks, but appears not at all...
In general, I'd recommend running tests with a few more
configurations. Try separating your journal and data store onto
separate disks, and see how your OSDs do then. Try combining all your
disks under your RAID card, running in no-journal mode (how well this
works will correlate directly with how good your RAID card is).

> 4.
> For the PG setup, using a simple ceph.conf (just osd[123] to a single machine)
> and setting the repl to x1, how would I expect the objects to get
> mapped to disks?
> How do I really configure and control how things go?
I'll leave your questions about the CRUSH map to others, except for one note:
The pseudo-random placement of data is one of Ceph's greatest
strengths. It provides you mechanisms for working around this in
certain cases, but if it's something you need to do often you might
want to look into another distributed FS which expects you to be
placing data manually.

> 5.
> Other than the ceph, crush and rados papers, Has there been any ceph
> work done on the applications/performances/benchmark comparisons using
> others?
We haven't done much in-house work benchmarking Ceph recently,
although we hope to start again soon (we're actively looking for QA
people, and this will be part of their job). I've seen a few papers
floating around that test Ceph in comparison to other distributed
FSes, but at this point they're pretty outdated. :)

> Thanks a lot in advance, and again sorry for asking too many.
No problem, we're happy to help!
-Greg
