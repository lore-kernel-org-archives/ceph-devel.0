From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Poor RBD performance as LIO iSCSI target
Date: Mon, 27 Oct 2014 18:11:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410271810060.13498@cobra.newdream.net>
References: <CAHs7Jm06=efPDAT46QmeTCzptqfXYsPEZUzVUixqE-PEXewN5A@mail.gmail.com> <6F3FA899187F0043BA1827A69DA2F7CC020DCD8E@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1760191167-1414458652=:13498"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50749 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaJ1BLe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 21:11:34 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC020DCD8E@shsmsx102.ccr.corp.intel.com>
Content-ID: <alpine.DEB.2.00.1410271811020.13498@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Christopher Spearman <neromaverick@gmail.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org, mchristi@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1760191167-1414458652=:13498
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1410271811021.13498@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2014, Chen, Xiaoxi wrote:
>=20
> Hi Chris,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 I am not the expert of LIO but from your resul=
t, seems RBD/Ceph
> works well(RBD on local system, no iSCSI) and LIO works well(Ramdisk (N=
o
> RBD) -> LIO target) =A0, =A0and if you change LIO to use other interfac=
e (file,
> loopback) to play with RBD, it also works well.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0So seems the issue is in the LIO RBD driv=
er? =A0May be need some
> tuning, or just not optimized enough through .

My guess is that when you use the loopback driver it stops blocking on=20
flush/sync?

Copying Mike and ceph-devel..

sage


> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf O=
f
> Christopher Spearman
> Sent: Tuesday, October 28, 2014 5:24 AM
> To: ceph-users@lists.ceph.com
> Subject: [ceph-users] Poor RBD performance as LIO iSCSI target
>=20
> =A0
>=20
> I've noticed a pretty steep performance degradation when using RBDs wit=
h
> LIO. I've tried a multitude of configurations to see if there are any
> changes in performance and I've only found a few that work (sort of).
>=20
> Details about the systems being used:
>=20
> =A0- All network hardware for data is 10gbe, there is some management o=
n 1gbe,
> but I can assure that it isn't being used (perf & bwm-ng shows this)
> =A0- Ceph version 0.80.5
> =A0- 20GB RBD (for our test, prod will be much larger, the size doesn't=
 seem
> to matter tho)
> =A0- LIO version 4.1.0, RisingTide
> =A0- Initiator is another linux system (However I've used ESXi as well =
with no
> difference)
> =A0- We have 8 OSD nodes, each with 8 2TB OSDs, 64 OSDs total
> =A0=A0 * 4 nodes are in one rack 4 in another, crush maps have been con=
figured
> with this as well
> =A0=A0 * All OSD nodes are running Centos 6.5
> =A0- 2 Gateway nodes on HP Proliant blades (but I've only been using on=
e for
> testing, however the problem does exist on both)
> =A0=A0 * All gateway nodes are running Centos 7
>=20
> I've tested a multitude of things, mainly to see where the issue lies.
>=20
> =A0- The performance of the RBD as a target using LIO
> =A0- The performance of the RBD itself (no iSCSI or LIO)
> =A0- LIO performance by using a ramdisk as a target (no RBD involved)
> =A0- Setting the RBD up with LVM, then using a logical volume from that=
 as a
> target with LIO
> =A0- Setting the RBD up in RAID0 & RAID1 (single disk, using mdadm), th=
en
> using that volume as a target with LIO
> =A0- Mounting the RBD as ext4, then using a disk image and fileio as a =
target
> =A0- Mounting the RBD as ext4, then using a disk image as a loop device=
 and
> blockio as a target
> =A0- Setting the RBD up as a loop device, then setting that up as a tar=
get
> with LIO
>=20
> =A0- What tested with bad performance (Reads ~25-50MB/s - Writes ~25-50=
MB/s)
> =A0=A0 * RBD setup as target using LIO
> =A0=A0 * RBD -> LVM -> LIO target
> =A0=A0 * RBD -> RAID0/1 -> LIO target
> =A0- What tested with good performance (Reads ~700-800MB/s - Writes
> ~400-700MB/s)
> =A0=A0 * RBD on local system, no iSCSI
> =A0=A0 * Ramdisk (No RBD) -> LIO target
> =A0=A0 * RBD -> Mounted ext4 -> disk image -> LIO fileio target
> =A0=A0 * RBD -> Mounted ext4 -> disk image -> loop device -> LIO blocki=
o target
> =A0=A0 * RBD -> loop device -> LIO target
>=20
> I'm just curious if anybody else has experienced these issues or has an=
y
> idea what's going on or has any suggestions on fixing this. I know usin=
g
> loop devices sounds like a solution, but we hit a brick wall with the f=
act
> loop devices are single threaded. The intent is to use this with VMWare=
 ESXi
> with the 2 gateways setup as a path to the target block devices. I'm no=
t
> opposed to using something somewhat kludgy, provided we can still use
> multipath iSCSI within VMWare
>=20
> Thanks for any help anyone can provide!
>=20
>=20
>=20
--557981400-1760191167-1414458652=:13498--
