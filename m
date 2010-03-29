From: ales-76@seznam.cz
Subject: Re: Hardware-config suggestions for HDD-based OSD node?
Date: Mon, 29 Mar 2010 07:18:00 +0200 (CEST)
Message-ID: <3500.484.564-14914-1325373445-1269839880@seznam.cz>
References: <23450.1269815817@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
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
To: ceph-devel@lists.sourceforge.net
Cc: =?us-ascii?Q?Craig=20Dunwoody?= <cdunwoody@graphstream.com>
List-Id: ceph-devel.vger.kernel.org

> ------------ P=F9vodn=ED zpr=E1va ------------
> Od: Craig Dunwoody <cdunwoody@graphstream.com>
> P=F8edm=ECt: [ceph-devel] Hardware-config suggestions for HDD-based OSD n=
ode?
> Datum: 29.3.2010 00:37:56

> As number of attached HDDs increases, I would expect to hit a number of
> hardware and software resource limitations in the node.  Certainly the
> achievable sustained throughput of the lowest-level hardware interfaces
> would be only a fraction of the aggregate-peak numbers that I listed
> above.

As to the number of disks, Sun Fire X4500 with 48 SATA disks showed real-wo=
rld performance around 800-1000 MB/s (benchmarks on the web - iSCSI, no Cep=
h). Since it is a amd64 based I guess you can get similar I/O rates from an=
y Intel box on the market today, provided you have enough SATA ports and/or=
 PCI-E slots. One 10gbps NIC should be enough (these are usually two ported=
 anyway). I would say the Linux will not be the bottleneck here even if you=
 use software RAID. Usually it is the network or the protocol that limit th=
e performance.

Regards

Ale=B9 Bl=E1ha

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
