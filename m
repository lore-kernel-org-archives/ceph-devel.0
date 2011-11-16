From: Andre Noll <maan@systemlinux.org>
Subject: Re: v0.38 released
Date: Wed, 16 Nov 2011 10:56:14 +0100
Message-ID: <20111116095614.GK13394@systemlinux.org>
References: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
 <20111115164254.GJ13394@systemlinux.org>
 <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zOcTNEe3AzgCmdo9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:54326 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab1KPJy2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2011 04:54:28 -0500
Content-Disposition: inline
In-Reply-To: <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 11:53, Gregory Farnum wrote:

> > Any plans to address the ENOSPC issue? I gave v0.38 a try and the
> > file system behaves like the older (<=3D 0.36) versions I've tried
> > before when it fills up: The ceph mounts hang on all clients.
>=20
> This is something we hope to address in the future, but we haven't
> come up with a good solution yet. (I haven't seen a good solution in
> other distributed systems either...)

Glad to hear the problem is known and will be addressed. We'd love to
use ceph as a global tmp file system on our cluster, so users *will*
fill it up..

> > But there is progress: Sync is now interuptable (it used to block
> > in D state so that it could not be killed even with SIGKILL), and
> > umount works even if the file system is full. However, subsequent
> > mount attempts then fail with "mount error 5 =3D Input/output error".
> Yay!
>=20
> > Our test setup consists of one mds, one monitor and 8 osds. mds and
> > monitor are on the same node, and this node is not not an osd. All
> > nodes are running Linux-3.0.9 ATM, but I would be willing to upgrade
> > to 3.1.1 if this is expected to make a difference.
> >
> > Here's some output of "ceph -w". Funny enough it reports 770G of free
> > disk space space although the writing process terminated with ENOSPC.
> Right now RADOS (the object store under the Ceph FS) is pretty
> conservative about reporting ENOSPC. Since btrfs is also pretty
> unhappy when its disk fills up, an OSD marks itself as "full" once
> it's reached 95% of its capacity, and once a single OSD goes full then
> RADOS marks itself that way so you don't overfill a disk and have
> really bad things happen. (Hung mounts suck but are a lot better than
> mysterious data loss.)

Six of the eight underlying btrfs for ceph are 500G large, the other
two are 800G. Used disk space varies between 459G and 476G. The peak
476G is on a 500G fs, so this one is 98% full.

The data was written by a single client using stress, which simply
created 5G files in an endless loop. All these files are in the top
level directory.

> Looking at your ceph -s I'm surprised by a few things, though...
> 1) Why do you have so many PGs? 8k/OSD is rather a lot

I can't answer this question, but please have a look at the ceph
config file below. Maybe you can spot something odd in it.

> 2) I wouldn't expect your OSDs to have become so unbalanced that one
> of them hits 95% full when the cluster's only at 84% capacity.

This seems to be due to the fact that roughly the same amount of data
was written to each file system despite of the different file system
sizes. Hence only 60% disk space is used on the two 800G file systems.

> What is this cluster used for? Are you running anything besides the
> Ceph FS on it? (radosgw, maybe?)

Besides the ceph daemons only sshd and sge_execd (for executing
cluster jobs) is running there. Job submission was disabled on these
nodes during the tests, so all systems were completely idle.

Thanks for your help
Andre
---
[global]
	; enable secure authentication
	;auth supported =3D cephx
	;osd journal size =3D 100    ; measured in MB=20

[client] ; userspace client
	debug ms =3D 1
	debug client =3D 10

; You need at least one monitor. You need at least three if you want to
; tolerate any node failures. Always create an odd number.
[mon]
	mon data =3D /var/ceph/mon$id
	; some minimal logging (just message traffic) to aid debugging
	; debug ms =3D 1
	; debug auth =3D 20 ;authentication code

[mon.0]
	host =3D node334
	mon addr =3D 192.168.3.34:6789

; You need at least one mds. Define two to get a standby.
[mds]
	; where the mds keeps it's secret encryption keys
	keyring =3D /var/ceph/keyring.$name
	; debug mds =3D 20
[mds.0]
	host =3D node334

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
	; This is where the btrfs volume will be mounted.
	osd data =3D /var/ceph/osd$id

	keyring =3D /etc/ceph/keyring.$name

	; Ideally, make this a separate disk or partition.  A few GB
 	; is usually enough; more if you have fast disks.  You can use
 	; a file under the osd data dir if need be
 	; (e.g. /data/osd$id/journal), but it will be slower than a
 	; separate disk or partition.
	osd journal =3D /var/ceph/osd$id/journal
	; If the OSD journal is a file, you need to specify the size. This is spec=
ified in MB.
        osd journal size =3D 512

[osd.325]
	host =3D node325
	btrfs devs =3D /dev/ceph/data
[osd.326]
	host =3D node326
	btrfs devs =3D /dev/ceph/data
[osd.327]
	host =3D node327
	btrfs devs =3D /dev/ceph/data
[osd.328]
	host =3D node328
	btrfs devs =3D /dev/ceph/data
[osd.329]
	host =3D node329
	btrfs devs =3D /dev/ceph/data
[osd.330]
	host =3D node330
	btrfs devs =3D /dev/ceph/data
[osd.331]
	host =3D node331
	btrfs devs =3D /dev/ceph/data
[osd.333]
	host =3D node333
	btrfs devs =3D /dev/ceph/data
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--zOcTNEe3AzgCmdo9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7DiL4ACgkQWto1QDEAkw+JjwCcCAaOn81RcWuJiCGa6+9gdoVY
SOsAn33/UohVH+UPIDEnhy0tCDjG2DHr
=Y7x8
-----END PGP SIGNATURE-----

--zOcTNEe3AzgCmdo9--
