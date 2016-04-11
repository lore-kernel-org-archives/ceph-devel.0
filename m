From: Lionel Bouton <lionel-subscription-WTamNBQcZIx7tPAFqOLdPg@public.gmane.org>
Subject: Re: Deprecating ext4 support
Date: Tue, 12 Apr 2016 01:09:44 +0200
Message-ID: <570C2EB8.2060207@bouton.name>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
	<570C1DBC.3040408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <570C1DBC.3040408-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

Le 11/04/2016 23:57, Mark Nelson a =E9crit :
> [...]
> To add to this on the performance side, we stopped doing regular
> performance testing on ext4 (and btrfs) sometime back around when ICE
> was released to focus specifically on filestore behavior on xfs. =

> There were some cases at the time where ext4 was faster than xfs, but
> not consistently so.  btrfs is often quite fast on fresh fs, but
> degrades quickly due to fragmentation induced by cow with
> small-writes-to-large-object workloads (IE RBD small writes).  If
> btrfs auto-defrag is now safe to use in production it might be worth
> looking at again, but probably not ext4.

For BTRFS, autodefrag is probably not performance-safe (yet), at least
with RBD access patterns. At least it wasn't in 4.1.9 when we tested it
last time (the performance degraded slowly but surely over several weeks
from an initially good performing filesystem to the point where we
measured a 100% increase in average latencies and large spikes and
stopped the experiment). I didn't see any patches on linux-btrfs since
then (it might have benefited from other modifications, but the
autodefrag algorithm wasn't reworked itself AFAIK).
That's not an inherent problem of BTRFS but of the autodefrag
implementation though. Deactivating autodefrag and reimplementing a
basic, cautious defragmentation scheduler gave us noticeably better
latencies with BTRFS vs XFS (~30% better) on the same hardware and
workload long term (as in almost a year and countless full-disk rewrites
on the same filesystems due to both normal writes and rebalancing with 3
to 4 months of XFS and BTRFS OSDs coexisting for comparison purposes).
I'll certainly remount a subset of our OSDs autodefrag as I did with
4.1.9 when we will deploy 4.4.x or a later LTS kernel. So I might have
more up to date information in the coming months. I don't plan to
compare BTRFS to XFS anymore though : XFS only saves us from running our
defragmentation scheduler, BTRFS is far more suited to our workload and
we've seen constant improvements in behavior in the (arguably bumpy
until late 3.19 versions) 3.16.x to 4.1.x road.

Other things:

* If the journal is not on a separate partition (SSD), it should
definitely be re-created NoCoW to avoid unnecessary fragmentation. From
memory : stop OSD, touch journal.new, chattr +C journal.new, dd
if=3Djournal of=3Djournal.new (your dd options here for best perf/least
amount of cache eviction), rm journal, mv journal.new journal, start OSD
again.
* filestore btrfs snap =3D false
  is mandatory if you want consistent performance (at least on HDDs). It
may not be felt with almost empty OSDs but performance hiccups appear if
any non trivial amount of data is added to the filesystems.
  IIRC, after debugging surprisingly the snapshot creation didn't seem
to be the actual cause of the performance problems but the snapshot
deletion... It's so bad that the default should probably be false and
not true.

Lionel
