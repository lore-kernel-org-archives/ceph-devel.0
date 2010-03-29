From: Craig Dunwoody <cdunwoody@graphstream.com>
Subject: Re: Hardware-config suggestions for HDD-based OSD node?
Date: Mon, 29 Mar 2010 06:00:25 -0700
Message-ID: <27770.1269867625@n20.hq.graphstream.com>
References: <3500.484.564-14914-1325373445-1269839880@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 29 Mar 2010 07:18:00 +0200."
	<3500.484.564-14914-1325373445-1269839880@seznam.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ales-76@seznam.cz
Cc: cdunwoody@graphstream.com, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


Hello Ales,

Thanks for your comments.  Because it is relatively simple to scale-up
various hardware resources in an OSD node, even up to extreme levels as
I described, I look forward to being able to do experiments of adding
various resources to an OSD node until a point of diminishing returns.

Unfortunately, this starts to get expensive for experiments with many
OSD nodes. Also, any such results will also depend on characteristics of
application workload.

Craig Dunwoody
GraphStream Incorporated

ales writes:
>As to the number of disks, Sun Fire X4500 with 48 SATA disks showed
>real-world performance around 800-1000 MB/s (benchmarks on the web -
>iSCSI, no Ceph). Since it is a amd64 based I guess you can get similar
>I/O rates from any Intel box on the market today, provided you have
>enough SATA ports and/or PCI-E slots. One 10gbps NIC should be enough
>(these are usually two ported anyway). I would say the Linux will not be
>the bottleneck here even if you use software RAID. Usually it is the
>network or the protocol that limit the performance.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
