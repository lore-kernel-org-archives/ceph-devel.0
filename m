From: Craig Dunwoody <cdunwoody@graphstream.com>
Subject: Re: Hardware-config suggestions for HDD-based OSD node?
Date: Sun, 28 Mar 2010 18:48:42 -0700
Message-ID: <24299.1269827322@n20.hq.graphstream.com>
References: <1471eea71003281815m68833d78r42e2387226ccf473@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 28 Mar 2010 18:15:08 PDT."
	<1471eea71003281815m68833d78r42e2387226ccf473@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: cdunwoody@graphstream.com, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


Hello Greg,

-   Thanks very much for your comments.

-   I will look forward to learning more about this as your team
    and others starts to test Ceph on a wider range of hardware
    configs.

-   I can see how for some applications, amount of main memory capacity
    available per HDD for caching, might become a significant constraint
    on max #HDDs that can be supported cost-efficiently per OSD node.

-   One thing I could conclude is that at least until more is known, there
    might be extra benefit from configuring nodes to allow for extra
    flexibility in the quantity of installed hardware resources (CPU,
    memory, HBA, NIC, HDD, SSD, etc.), such that these could be adjusted
    appropriately in response to measurements of how specific
    applications perform.

-- 
Craig Dunwoody
GraphStream Incorporated

greg writes:
>I expect that Sage will have a lot more to offer you in this area, but
>for now I have a few responses I can offer off the top of my head. :)
>1) It's early days for Ceph. We're going to be offering a public beta
>of the object store Real Soon Now that I expect will give us a better
>idea of how different hardware scales, but it hasn't been run
>long-term on anything larger than some old single- and dual-core
>systems since Sage's thesis research.
>2) The OSD code will happily eat all the memory you can give it to use
>as cache; though the useful cache size/drive will of course depend on
>your application. ;)
>3) All the failure recovery code right operates on the cosd process
>level. You can design the CRUSH layout map in such a way that it won't
>put any replicas on the same physical box, but you will need to be
>much more careful of such things than if you're running one
>process/box. This will also mean that a failure will impact your
>network more dramatically-- each box which replicates/leads the failed
>box will need to send data to p times as many other processes as if
>they were running one process/box. (p being the number of
>processes/box) On the upside, that means recovery may be done faster.
>4) The less data you store per-process, the more your maintenance
>overhead will be. If we've done our jobs right this won't be a problem
>at all, but it would mean that any scaling issues appear to you faster
>than to others.
>5) The OSD supports different directories for the object store and for
>the journal. SSDs will give you lots better journaling and thus lower
>write latency, though if your applications are happy to do asyn IO I
>don't think this should impact bandwidth.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
