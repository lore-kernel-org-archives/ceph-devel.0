From: Craig Dunwoody <cdunwoody@graphstream.com>
Subject: Hardware-config suggestions for HDD-based OSD node?
Date: Sun, 28 Mar 2010 15:36:57 -0700
Message-ID: <23450.1269815817@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
Cc: cdunwoody@graphstream.com
List-Id: ceph-devel.vger.kernel.org


I'd be interested to hear from anyone who has suggestions about
optimizing the hardware config of an HDD-based OSD node for Ceph, using
currently available COTS hardware components.

More specifically, I'm interested in how one might try for an efficient
balance among key hardware resources including:

    CPU cores
    Main-memory throughput and capacity
    HDD controllers
    HDDs
    SSDs for journaling, if any
    NICs

Some reasonable answers I expect might include:

-   It's very early days for Ceph, no one really knows yet, and the only
    way to find out is to experiment with real hardware and
    applications, which is expensive

-   Answer depends a lot on many factors, including:
    -   Cost/performance tradeoff choices for a particular application
    -   Details of workloads for a particular application
    -   Details of hardware-component performance characteristics

Seems to me that one of many possible approaches would be to choose a
particular HDD type (e.g. 2TB 3.5" 7200RPM SAS-6G), and then work toward
the following goals, recognizing that there are tensions/conflicts among
these goals:

    Goal G1
        Maximize the incremental improvement in overall FS access
        performance that results from each incremental addition of a
        single HDD.

    Goal G2
        Minimize physical space used per bit of total FS capacity.

    Goal G3
        Minimize total hardware cost per bit of total FS capacity.

I would expect to be able to do well on G1 by stacking up nodes, each
with a single HDD, single cosd instance, and one or more GigE ports.
However, I would expect to do better on G2 and G3 by increasing #HDDs
per node.

Based on currently available server components that are relatively
inexpensive and convenient to deploy, I can imagine that for some
applications it might be attractive to stack up 1RU-rackmount nodes,
each with four HDDs, four cosd instances, and two or more GigE ports.

Beyond that, I'm wondering if it would be possible to serve some
applications better with a fatter OSD node config.  In particular, could
I improve space-efficiency (G2) and maybe also cost-per-bit (G3) by
increasing the #HDDs per node until incremental performance contribution
of each additional HDD (G1) just starts to drop below what I would get
with only a single HDD per node?

As one really extreme example, at a cost that might be acceptable for
some applications I could build a single max-configuration node with:
    
     2 CPU sockets
    24 CPU threads (2 x 6core x 2thread, or 2 x 12core x 1thread)
    12 DIMMs (currently up to 96GB capacity, up to 85 GByte/sec peak)
     3 8port SAS6G HBAs (aggregate 14.4GByte/sec peak to HDDs)
     5 2port 10GigE NICs (aggregate 12.5GByte/sec peak to network)

Using appropriate chassis, I could attach a pretty large number of 2TB
3.5" 7200RPM SAS-6G HDDs to this node, even hundreds if I wanted to (but
I wouldn't).

I'm wondering how large I could push the number of attached HDDs, before
the incremental performance contribution of each HDD starts to drop off.

As number of attached HDDs increases, I would expect to hit a number of
hardware and software resource limitations in the node.  Certainly the
achievable sustained throughput of the lowest-level hardware interfaces
would be only a fraction of the aggregate-peak numbers that I listed
above.

As one very crude calculation, ignoring many other constraints, if I
thought that I could get all HDDs streaming simultaneously to Ethernet
at a sustained 100MByte/sec each (I can't), and I thought that I could
sustain 50% of wire-speed across the ten 10GigE ports, then I'd limit
myself to about 62 HDDs (6.25 GByte/sec) to avoid worrying about the
Ethernet interfaces throttling the aggregate streaming throughput of the
HDDs.

I expect that a more-realistic assumption about max aggregate streaming
throughput under Ceph would lead to a higher limit on #HDDs based on
this one consideration.

I would expect that long before reaching 62 HDDs, many other constraints
would cause the per-HDD performance contribution to drop below the
single-HDD-per-server level, including:

-   Limitations in CPU throughput
-   Limitations in main-memory throughput and capacity
-   Various Linux limitations
-   Various Ceph limitations

62 HDDs and 62 cosd instances would be 2.6 cosd instances per CPU
thread, which seems to me like a lot.  I would not be surprised at all
to receive a recommendation to limit to less than 1.0 cosd instance per
CPU thread.

I can imagine reducing the number of cosd instances by running each atop
a multi-HDD btrfs-level stripe, but I expect that might have various
disadvantages, and I do like the simplicity of one cosd instance per
btrfs filesystem per HDD.

Realistically, I expect that there might be a sweet-spot at a much more
moderate number of HDDs per node, with a node hardware config that is
much less extreme than the example I described above.

I also wonder if perhaps the sweet-spot for #HDDs per OSD node might be
able to increase over time, as Ceph matures and more tuning is done.

Thanks in advance to anyone for any thoughts/comments on this topic.
Would appreciate any suggestions on better ways to analyze the
tradeoffs, and corrections of any fundamental misunderstandings that I
might have about how Ceph works and how to configure it.

-- 
Craig Dunwoody
GraphStream Incorporated

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
