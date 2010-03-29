From: Craig Dunwoody <cdunwoody@graphstream.com>
Subject: Re: [OLD ceph-devel] Hardware-config suggestions for
	HDD-based OSD node?
Date: Mon, 29 Mar 2010 15:54:09 -0700
Message-ID: <3084.1269903249@n20.hq.graphstream.com>
References: <Pine.LNX.4.64.1003291405030.26550@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 29 Mar 2010 14:26:16 PDT."
	<Pine.LNX.4.64.1003291405030.26550@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: cdunwoody@graphstream.com, ceph-devel@vger.kernel.org, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


Hello Sage,

Thanks very much for your comments.

I can see it making sense to set up btrfs to stripe across multiple HDDs
and replicate metadata.  I'd be more reluctant to replicate file data
inside the fault domain of a single OSD node, because I feel I would get
more benefit from that (relatively expensive) redundancy by putting it
in a separate node.

In general, I expect that Ceph will end up getting used across a very
diverse set of applications, and accordingly there might be a lot of
variation among applications in terms of specific performance
limitations that people run up against.

I would agree that when designing a storage system for any set of
applications, it's certainly quite a challenge to characterize the
expected workload (which might very well also change over time), and
then come up with a particular configuration of currently-available
off-the-shelf hardware and software building-blocks that one hopes could
support that workload more efficiently than other currently-available
alternatives.

Almost all of the storage systems that my company currently builds end
up in HPC-type setups that already natively have relatively fat network
pipes for cluster-interconnect (e.g. 32Gbps InfiniBand and/or 10Gbps
Ethernet), and there is a natural desire to try to fill up fatter pipes
using fatter storage bricks.

That said, I can imagine that even for this kind of situation, it might
sometimes be more efficient to fan out to a larger number of thinner
network pipes and thinner storage bricks.

Perhaps some future Ceph optimizations will be most helpful for thinner
OSD-brick setups, and others will be more important for fatter OSD
bricks that are trying to fill fatter network pipes.  Fortunately, it
appears that there are still plenty of optimizations left to do in Ceph
that are likely to benefit a very wide range of appplications and
hardware configs.

Craig Dunwoody
GraphStream Incorporated

sage writes:
>Generally, this is where we are at.  :) I have just a few other things to 
>add to this thread.
>
>First, the cosd daemon is pretty heavily multithreaded, at various levels.  
>There are threads for handling network IO, for processing reads, for 
>serializing and preparing writes, and for journaling and applying writes 
>to disk.  A single properly tuned cosd daemon can probably keep all your 
>cores busy.  The thread pool sizes are all configurable, though, so you 
>can also run multiple daemons per machine.
>
>I would be inclined to pool multiple raw disks together with btrfs for 
>each cosd instance as that will let btrfs replicate its metadata 
>(and/or data) and recover from disk errors.  That will generally be faster 
>than having ceph rereplicate all of the node's data.
>
>The other performance consideration is the osd journaling.  If low latency 
>writes are a concern, the journal can be placed on a separate device.  
>That can be a raw disk device (dedicated spindle), although you generally 
>pay the full rotational latency each time cosd sends accumulated items to 
>the disk (some smarts that tries to time the disk rotation and adjusts the 
>next write accordingly could probably improve this).  It also wastes an 
>entire disk for a journal that doesn't need to get that big.
>
>The journal can also be put on an NVRAM device, like a Micro Memory card.  
>These are a bit hard to come by, but they're fast.
>
>An SSD is probably the most cost effective option.  Cheap models are 
>probably fine, too, since all writes are sequential and probably won't 
>work the firmware very hard.
>
>My suspicion is that the most frequent performance limiter is going to be 
>the network.  Any node with 2 or more disks can outrun a GigE link with 
>streaming io, and 10GigE deployments aren't all that common yet.  Cheap 
>switches with narrow backplanes also tend to a bottleneck.
>
>In the end, it's really going to come down to the workload.  How hot/cold 
>is the data?  Maybe 1gps per 100TB osd is fine, maybe it's not.  How much 
>RAM is going to be a cost/benefit question, which depends on how skewed 
>the access distribution is (more skewed = more effective caching, whereas 
>caches will be almost useless with a truly flat access distribution).
>
>The last thing I'll mention is that the cosd code isn't very well 
>optimized at this point.  At the very least, writes are fully buffered 
>(which means at least one memory copy into the page cache).  And there is 
>a lot of other stuff going on in preparing and staging writes that could 
>be improved performance-wise.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
