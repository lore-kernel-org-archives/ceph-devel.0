From: Sage Weil <sage@newdream.net>
Subject: Re: [OLD ceph-devel] Hardware-config suggestions for
	HDD-based OSD node?
Date: Mon, 29 Mar 2010 14:26:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003291405030.26550@cobra.newdream.net>
References: <23450.1269815817@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <23450.1269815817@n20.hq.graphstream.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Craig Dunwoody <cdunwoody@graphstream.com>
Cc: ceph-devel@vger.kernel.org, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Hi Craig,

On Sun, 28 Mar 2010, Craig Dunwoody wrote:
> -   It's very early days for Ceph, no one really knows yet, and the only
>     way to find out is to experiment with real hardware and
>     applications, which is expensive

Generally, this is where we are at.  :) I have just a few other things to 
add to this thread.

First, the cosd daemon is pretty heavily multithreaded, at various levels.  
There are threads for handling network IO, for processing reads, for 
serializing and preparing writes, and for journaling and applying writes 
to disk.  A single properly tuned cosd daemon can probably keep all your 
cores busy.  The thread pool sizes are all configurable, though, so you 
can also run multiple daemons per machine.

I would be inclined to pool multiple raw disks together with btrfs for 
each cosd instance as that will let btrfs replicate its metadata 
(and/or data) and recover from disk errors.  That will generally be faster 
than having ceph rereplicate all of the node's data.

The other performance consideration is the osd journaling.  If low latency 
writes are a concern, the journal can be placed on a separate device.  
That can be a raw disk device (dedicated spindle), although you generally 
pay the full rotational latency each time cosd sends accumulated items to 
the disk (some smarts that tries to time the disk rotation and adjusts the 
next write accordingly could probably improve this).  It also wastes an 
entire disk for a journal that doesn't need to get that big.

The journal can also be put on an NVRAM device, like a Micro Memory card.  
These are a bit hard to come by, but they're fast.

An SSD is probably the most cost effective option.  Cheap models are 
probably fine, too, since all writes are sequential and probably won't 
work the firmware very hard.

My suspicion is that the most frequent performance limiter is going to be 
the network.  Any node with 2 or more disks can outrun a GigE link with 
streaming io, and 10GigE deployments aren't all that common yet.  Cheap 
switches with narrow backplanes also tend to a bottleneck.

In the end, it's really going to come down to the workload.  How hot/cold 
is the data?  Maybe 1gps per 100TB osd is fine, maybe it's not.  How much 
RAM is going to be a cost/benefit question, which depends on how skewed 
the access distribution is (more skewed = more effective caching, whereas 
caches will be almost useless with a truly flat access distribution).

> I would expect that long before reaching 62 HDDs, many other constraints
> would cause the per-HDD performance contribution to drop below the
> single-HDD-per-server level, including:
> 
> -   Limitations in CPU throughput
> -   Limitations in main-memory throughput and capacity
> -   Various Linux limitations
> -   Various Ceph limitations

The last thing I'll mention is that the cosd code isn't very well 
optimized at this point.  At the very least, writes are fully buffered 
(which means at least one memory copy into the page cache).  And there is 
a lot of other stuff going on in preparing and staging writes that could 
be improved performance-wise.

Cheers-
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
