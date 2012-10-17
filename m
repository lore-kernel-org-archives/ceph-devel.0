From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: v0.53 released
Date: Wed, 17 Oct 2012 13:26:43 +0200
Message-ID: <507E95F3.10508@filoo.de>
References: <alpine.DEB.2.00.1210161647550.5342@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-6.de-punkt.de ([93.190.64.36]:32809 "EHLO
	mail-6.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab2JQL0q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 07:26:46 -0400
In-Reply-To: <alpine.DEB.2.00.1210161647550.5342@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage, *,

after having some trouble with the journals - had to erase the partitio=
n=20
and redo a ceph... --mkjournal - I started my testing... Everything fin=
e.

--- 8-< ---
2012-10-17 12:54:11.167782 7febab24a780  0 filestore(/data/osd0) mount:=
=20
enabling PARALLEL journal mode: btrfs, SNAP_CREATE_V2 detected and=20
'filestore btrfs snap' mode is enabled
2012-10-17 12:54:11.191723 7febab24a780  0 journal  kernel version is 3=
=2E5.0
2012-10-17 12:54:11.191907 7febab24a780  1 journal _open /dev/sdb1 fd=20
27: 1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D 1
2012-10-17 12:54:11.201764 7febab24a780  0 journal  kernel version is 3=
=2E5.0
2012-10-17 12:54:11.201924 7febab24a780  1 journal _open /dev/sdb1 fd=20
27: 1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D 1
--- 8-< ---

And the other minute I started my fairly destructive testing, 0.52 neve=
r=20
ever failed on that. And then a loop started with
--- 8-< ---

2012-10-17 12:59:15.403247 7feba5fed700  0 -- 10.0.0.11:6801/29042 >>=20
10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :57922 pgs=3D3 cs=3D1 l=3D0=
).fault,=20
initiating reconnect
2012-10-17 12:59:17.280143 7feb950cc700  0 -- 10.0.0.11:6801/29042 >>=20
10.0.0.12:6804/17972 pipe(0x17f2240 sd=3D29 :49431 pgs=3D3 cs=3D1 l=3D0=
).fault=20
with nothing to send, going to standby
2012-10-17 12:59:18.288902 7feb951cd700  0 -- 10.0.0.11:6801/29042 >>=20
10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :37519 pgs=3D3 cs=3D2 l=3D0=
).connect=20
claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node!
2012-10-17 12:59:18.297663 7feb951cd700  0 -- 10.0.0.11:6801/29042 >>=20
10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :34833 pgs=3D3 cs=3D2 l=3D0=
).connect=20
claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node!
2012-10-17 12:59:18.303215 7feb951cd700  0 -- 10.0.0.11:6801/29042 >>=20
10.0.0.12:6801/17706 pipe(0x55a2240 sd=3D34 :35169 pgs=3D3 cs=3D2 l=3D0=
).connect=20
claims to be 0.0.0.0:6801/5738 not 10.0.0.12:6801/17706 - wrong node!
--- 8-< ---

leading to high CPU-load on node2 ( IP 10.0.0.11). The destructive part=
=20
happens on node3 ( IP 10.0.0.12).

Procedure is as always just kill some OSDs and start over again...=20
Happened now twice, so I would call it reproducable ;)

Kind regards,

Oliver.


On 10/17/2012 01:48 AM, Sage Weil wrote:
> Another development release of Ceph is ready, v0.53. We are getting p=
retty
> close to what will be frozen for the next stable release (bobtail), s=
o if
> you would like a preview, give this one a go. Notable changes include=
:
>
>   * librbd: image locking
>   * rbd: fix list command when more than 1024 (format 2) images
>   * osd: backfill reservation framework (to avoid flooding new osds w=
ith
>     backfill data)
>   * osd, mon: honor new 'nobackfill' and 'norecover' osdmap flags
>   * osd: new 'deep scrub' will compare object content across replicas=
 (once
>     per week by default)
>   * osd: crush performance improvements
>   * osd: some performance improvements related to request queuing
>   * osd: capability syntax improvements, bug fixes
>   * osd: misc recovery fixes
>   * osd: fix memory leak on certain error paths
>   * osd: default journal size to 1 GB
>   * crush: default root of tree type is now 'root' instead of 'pool' =
(to
>     avoid confusiong wrt rados pools)
>   * ceph-fuse: fix handling for .. in root directory
>   * librados: some locking fixes
>   * mon: some election bug fixes
>   * mon: some additional on-disk metadata to facilitate future mon ch=
anges
>     (post-bobtail)
>   * mon: throttle osd flapping based on osd history (limits osdmap
>     "thrashing" on overloaded or unhappy clusters)
>   * mon: new 'osd crush create-or-move ...' command
>   * radosgw: fix copy-object vs attributes
>   * radosgw: fix bug in bucket stat updates
>   * mds: fix ino release on abort session close, relative getattr pat=
h, mds
>     shutdown, other misc items
>   * upstart: stop jobs on shutdown
>   * common: thread pool sizes can now be adjusted at runtime
>   * build fixes for Fedora 18, CentOS/RHEL 6
>
> The big items are locking support in RBD, and OSD improvements like d=
eep
> scrub (which verify object data across replicas) and backfill reserva=
tions
> (which limit load on expanding clusters). And a huge swath of bugfixe=
s and
> cleanups, many due to feeding the code through scan.coverity.com (the=
y
> offer free static code analysis for open source projects).
>
> v0.54 is now frozen, and will include many deployment-related fixes
> (including a new ceph-deploy tool to replace mkcephfs), more bugfixes=
 for
> libcephfs, ceph-fuse, and the MDS, and the fruits of some performance=
 work
> on the OSD.
>
> You can get v0.53 from the usual locations:
>
>   * Git at git://github.com/ceph/ceph.git
>   * Tarball at http://ceph.com/download/ceph-0.53.tar.gz
>   * For Debian/Ubuntu packages, see http://ceph.com/docs/master/insta=
ll/debian
>   * For RPMs, see http://ceph.com/docs/master/install/rpm
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
