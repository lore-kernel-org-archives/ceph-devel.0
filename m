From: Sage Weil <sage@newdream.net>
Subject: Re: Write performance issue under rocksdb kvstore
Date: Tue, 20 Oct 2015 05:47:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510200544430.16833@cobra.newdream.net>
References: <SNT146-W53DA6FBD57581F19D681688C390@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-803166176-1445345264=:16833"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54006 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbJTMrq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 08:47:46 -0400
In-Reply-To: <SNT146-W53DA6FBD57581F19D681688C390@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Z Zhang <zhangz.david@outlook.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-803166176-1445345264=:16833
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2015, Z Zhang wrote:
> Hi Guys,
>=20
> I am trying latest ceph-9.1.0 with rocksdb 4.1 and ceph-9.0.3 with=20
> rocksdb 3.11 as OSD backend. I use rbd to test performance and followin=
g=20
> is my cluster info.
>=20
> [ceph@xxx ~]$ ceph -s
> =A0 =A0 cluster b74f3944-d77f-4401-a531-fa5282995808
> =A0 =A0 =A0health HEALTH_OK
> =A0 =A0 =A0monmap e1: 1 mons at {xxx=3Dxxx.xxx.xxx.xxx:6789/0}
> =A0 =A0 =A0 =A0 =A0 =A0 election epoch 1, quorum 0 xxx
> =A0 =A0 =A0osdmap e338: 44 osds: 44 up, 44 in
> =A0 =A0 =A0 =A0 =A0 =A0 flags sortbitwise
> =A0 =A0 =A0 pgmap v1476: 2048 pgs, 1 pools, 158 MB data, 59 objects
> =A0 =A0 =A0 =A0 =A0 =A0 1940 MB used, 81930 GB / 81932 GB avail
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2048 active+clean
>=20
> All the disks are spinning ones with write cache turning on. Rocksdb's=20
> WAL and sst files are on the same disk as every OSD.

Are you using the KeyValueStore backend?

> Using fio to generate following write load:=A0
> fio -direct=3D1 -rw=3Drandwrite -ioengine=3Dsync -size=3D10M -bs=3D4K -=
group_reporting -directory /mnt/rbd_test/ -name xxx.1 -numjobs=3D1=A0=A0
>=20
> Test result:
> WAL enabled + sync: false + disk write cache: on =A0will get ~700 IOPS.
> WAL enabled + sync: true (default) + disk write cache: on|off =A0will g=
et only ~25 IOPS.
>=20
> I tuned some other rocksdb options, but with no lock.

The wip-newstore-frags branch sets some defaults for rocksdb that I think=
=20
look pretty reasonable (at least given how newstore is using rocksdb).

> I tracked down the rocksdb code and found each writer's Sync operation=20
> would take ~30ms to finish. And as shown above, it is strange that=20
> performance has no much difference no matters disk write cache is on or=
=20
> off.
>=20
> Do your guys encounter the similar issue? Or do I miss something to=20
> cause rocksdb's poor write performance?

Yes, I saw the same thing.  This PR addresses the problem and is nearing=20
merge upstream:

	https://github.com/facebook/rocksdb/pull/746

There is also an XFS performance bug that is contributing to the problem,=
=20
but it looks like Dave Chinner just put together a fix for that.

But... we likely won't be using KeyValueStore in its current form over=20
rocksdb (or any other kv backend).  It stripes object data over key/value=
=20
pairs, which IMO is not the best approach.

sage
--557981400-803166176-1445345264=:16833--
