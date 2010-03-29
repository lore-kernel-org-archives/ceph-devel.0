From: =?UTF-8?B?QWxlxaEgQmzDoWhh?= <ales-76@seznam.cz>
Subject: Re: Hardware-config suggestions for HDD-based OSD node?
Date: Mon, 29 Mar 2010 17:46:49 +0200
Message-ID: <20100329174649.f9d79f2b.ales-76@seznam.cz>
References: <3500.484.564-14914-1325373445-1269839880@seznam.cz>
	<27770.1269867625@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <27770.1269867625@n20.hq.graphstream.com>
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

On Mon, 29 Mar 2010 15:00:25 +0200 (CEST)
Craig Dunwoody <cdunwoody@graphstream.com> wrote:

Hello Craig,

Sure raw numbers for a hardware are often very impressive, but
it is up to the software to squeeze the performance out of it.
Experimenting is always the best way to find out, but you can search
the web to get the picture. I suggest taking a look at Lustre
setups - the architecture is very similar, they also use mostly
of-the-shelf componenst. Apparently the common Lustre OSD is rather fat
- plenty of disks divided into several RAID groups, very much like the
X4500. Then againg, HPC people are mostly focused on
streaming writes, so if your application differs then your point of
diminishing returns might be elsewhere.

Ales Blaha

> 
> Hello Ales,
> 
> Thanks for your comments.  Because it is relatively simple to scale-up
> various hardware resources in an OSD node, even up to extreme levels as
> I described, I look forward to being able to do experiments of adding
> various resources to an OSD node until a point of diminishing returns.
> 
> Unfortunately, this starts to get expensive for experiments with many
> OSD nodes. Also, any such results will also depend on characteristics of
> application workload.
> 
> Craig Dunwoody
> GraphStream Incorporated
> 
> ales writes:
> >As to the number of disks, Sun Fire X4500 with 48 SATA disks showed
> >real-world performance around 800-1000 MB/s (benchmarks on the web -
> >iSCSI, no Ceph). Since it is a amd64 based I guess you can get similar
> >I/O rates from any Intel box on the market today, provided you have
> >enough SATA ports and/or PCI-E slots. One 10gbps NIC should be enough
> >(these are usually two ported anyway). I would say the Linux will not be
> >the bottleneck here even if you use software RAID. Usually it is the
> >network or the protocol that limit the performance.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
