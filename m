From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Hardware-config suggestions for HDD-based OSD node?
Date: Sun, 28 Mar 2010 18:15:08 -0700
Message-ID: <1471eea71003281815m68833d78r42e2387226ccf473@mail.gmail.com>
References: <23450.1269815817@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Craig:
I expect that Sage will have a lot more to offer you in this area, but
for now I have a few responses I can offer off the top of my head. :)
1) It's early days for Ceph. We're going to be offering a public beta
of the object store Real Soon Now that I expect will give us a better
idea of how different hardware scales, but it hasn't been run
long-term on anything larger than some old single- and dual-core
systems since Sage's thesis research.
2) The OSD code will happily eat all the memory you can give it to use
as cache; though the useful cache size/drive will of course depend on
your application. ;)
3) All the failure recovery code right operates on the cosd process
level. You can design the CRUSH layout map in such a way that it won't
put any replicas on the same physical box, but you will need to be
much more careful of such things than if you're running one
process/box. This will also mean that a failure will impact your
network more dramatically-- each box which replicates/leads the failed
box will need to send data to p times as many other processes as if
they were running one process/box. (p being the number of
processes/box) On the upside, that means recovery may be done faster.
4) The less data you store per-process, the more your maintenance
overhead will be. If we've done our jobs right this won't be a problem
at all, but it would mean that any scaling issues appear to you faster
than to others.
5) The OSD supports different directories for the object store and for
the journal. SSDs will give you lots better journaling and thus lower
write latency, though if your applications are happy to do asyn IO I
don't think this should impact bandwidth.
-Greg

On Sun, Mar 28, 2010 at 3:36 PM, Craig Dunwoody
<cdunwoody@graphstream.com> wrote:
>
> I'd be interested to hear from anyone who has suggestions about
> optimizing the hardware config of an HDD-based OSD node for Ceph, using
> currently available COTS hardware components.
>
> More specifically, I'm interested in how one might try for an efficient
> balance among key hardware resources including:
>
> =A0 =A0CPU cores
> =A0 =A0Main-memory throughput and capacity
> =A0 =A0HDD controllers
> =A0 =A0HDDs
> =A0 =A0SSDs for journaling, if any
> =A0 =A0NICs
>
> Some reasonable answers I expect might include:
>
> - =A0 It's very early days for Ceph, no one really knows yet, and the only
> =A0 =A0way to find out is to experiment with real hardware and
> =A0 =A0applications, which is expensive
>
> - =A0 Answer depends a lot on many factors, including:
> =A0 =A0- =A0 Cost/performance tradeoff choices for a particular applicati=
on
> =A0 =A0- =A0 Details of workloads for a particular application
> =A0 =A0- =A0 Details of hardware-component performance characteristics
>
> Seems to me that one of many possible approaches would be to choose a
> particular HDD type (e.g. 2TB 3.5" 7200RPM SAS-6G), and then work toward
> the following goals, recognizing that there are tensions/conflicts among
> these goals:
>
> =A0 =A0Goal G1
> =A0 =A0 =A0 =A0Maximize the incremental improvement in overall FS access
> =A0 =A0 =A0 =A0performance that results from each incremental addition of=
 a
> =A0 =A0 =A0 =A0single HDD.
>
> =A0 =A0Goal G2
> =A0 =A0 =A0 =A0Minimize physical space used per bit of total FS capacity.
>
> =A0 =A0Goal G3
> =A0 =A0 =A0 =A0Minimize total hardware cost per bit of total FS capacity.
>
> I would expect to be able to do well on G1 by stacking up nodes, each
> with a single HDD, single cosd instance, and one or more GigE ports.
> However, I would expect to do better on G2 and G3 by increasing #HDDs
> per node.
>
> Based on currently available server components that are relatively
> inexpensive and convenient to deploy, I can imagine that for some
> applications it might be attractive to stack up 1RU-rackmount nodes,
> each with four HDDs, four cosd instances, and two or more GigE ports.
>
> Beyond that, I'm wondering if it would be possible to serve some
> applications better with a fatter OSD node config. =A0In particular, could
> I improve space-efficiency (G2) and maybe also cost-per-bit (G3) by
> increasing the #HDDs per node until incremental performance contribution
> of each additional HDD (G1) just starts to drop below what I would get
> with only a single HDD per node?
>
> As one really extreme example, at a cost that might be acceptable for
> some applications I could build a single max-configuration node with:
>
> =A0 =A0 2 CPU sockets
> =A0 =A024 CPU threads (2 x 6core x 2thread, or 2 x 12core x 1thread)
> =A0 =A012 DIMMs (currently up to 96GB capacity, up to 85 GByte/sec peak)
> =A0 =A0 3 8port SAS6G HBAs (aggregate 14.4GByte/sec peak to HDDs)
> =A0 =A0 5 2port 10GigE NICs (aggregate 12.5GByte/sec peak to network)
>
> Using appropriate chassis, I could attach a pretty large number of 2TB
> 3.5" 7200RPM SAS-6G HDDs to this node, even hundreds if I wanted to (but
> I wouldn't).
>
> I'm wondering how large I could push the number of attached HDDs, before
> the incremental performance contribution of each HDD starts to drop off.
>
> As number of attached HDDs increases, I would expect to hit a number of
> hardware and software resource limitations in the node. =A0Certainly the
> achievable sustained throughput of the lowest-level hardware interfaces
> would be only a fraction of the aggregate-peak numbers that I listed
> above.
>
> As one very crude calculation, ignoring many other constraints, if I
> thought that I could get all HDDs streaming simultaneously to Ethernet
> at a sustained 100MByte/sec each (I can't), and I thought that I could
> sustain 50% of wire-speed across the ten 10GigE ports, then I'd limit
> myself to about 62 HDDs (6.25 GByte/sec) to avoid worrying about the
> Ethernet interfaces throttling the aggregate streaming throughput of the
> HDDs.
>
> I expect that a more-realistic assumption about max aggregate streaming
> throughput under Ceph would lead to a higher limit on #HDDs based on
> this one consideration.
>
> I would expect that long before reaching 62 HDDs, many other constraints
> would cause the per-HDD performance contribution to drop below the
> single-HDD-per-server level, including:
>
> - =A0 Limitations in CPU throughput
> - =A0 Limitations in main-memory throughput and capacity
> - =A0 Various Linux limitations
> - =A0 Various Ceph limitations
>
> 62 HDDs and 62 cosd instances would be 2.6 cosd instances per CPU
> thread, which seems to me like a lot. =A0I would not be surprised at all
> to receive a recommendation to limit to less than 1.0 cosd instance per
> CPU thread.
>
> I can imagine reducing the number of cosd instances by running each atop
> a multi-HDD btrfs-level stripe, but I expect that might have various
> disadvantages, and I do like the simplicity of one cosd instance per
> btrfs filesystem per HDD.
>
> Realistically, I expect that there might be a sweet-spot at a much more
> moderate number of HDDs per node, with a node hardware config that is
> much less extreme than the example I described above.
>
> I also wonder if perhaps the sweet-spot for #HDDs per OSD node might be
> able to increase over time, as Ceph matures and more tuning is done.
>
> Thanks in advance to anyone for any thoughts/comments on this topic.
> Would appreciate any suggestions on better ways to analyze the
> tradeoffs, and corrections of any fundamental misunderstandings that I
> might have about how Ceph works and how to configure it.
>
> --
> Craig Dunwoody
> GraphStream Incorporated
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
