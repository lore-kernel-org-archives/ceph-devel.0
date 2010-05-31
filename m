From: Andre Noll <maan@systemlinux.org>
Subject: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Mon, 31 May 2010 14:51:56 +0200
Message-ID: <20100531125156.GJ1211@skl-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:36183 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab0EaMwQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 May 2010 08:52:16 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

we're trying to give ceph a try on our compute cluster Initial stress
tests passed without problems, but over the weekend a couple of cosd
processes died and now access to the ceph mount point blocks and
mounting the ceph dir fails with

	mount: 192.168.1.141:6789,192.168.1.145:6789,192.168.1.150:6789:/: can't r=
ead superblock

Attempts to restart the cosd on the affected storage nodes fails with

	# /usr/local/bin/cosd -f -i 6 -c /etc/ceph/ceph.conf
	 ** WARNING: Ceph is still under heavy development, and is only suitable f=
or **
	 **          testing and review.  Do not trust it with important data.    =
   **
	starting osd6 at 0.0.0.0:6800/2685 osd_data /var/ceph/osd6 /var/ceph/osd6/=
journal
	terminate called after throwing an instance of 'std::bad_alloc'
	  what():  std::bad_alloc
	Aborted

Stracing the cosd process shows that it calls mmap() with silly values
for the "fd" and the "length" parameter:

	mmap(NULL, 18446744073709436928, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANO=
NYMOUS, -1, 0) =3D -1 ENOMEM (Cannot allocate memory)

I briefly looked at the source code and noticed that raw_mmap_pages()
in include/buffer.h of seems to call mmap() with an unsigned int
rather than with a size_t as the second (length) parameter. Since

	18446744073709436928 =3D 0xfffffffffffe4000

this looks like an integer overflow. But maybe it is just uninitialized
garbage.

I've tried the v0.20.2 and the testing branch of the ceph git
repo. Both versions of cosd show the same behaviour.

Our ceph file system 5.5T large, we have 7 cosds, 3 cmons and 3 cmds,
see the ceph.conf below for details.

Any idea how to get back the data? If you need further debugging info,
don't hesitate to ask.

Thanks
Andre
---

[global]
	; enable secure authentication
	auth supported =3D cephx
	osd journal size =3D 100    ; measured in MB=20

; You need at least one monitor. You need at least three if you want to
; tolerate any node failures. Always create an odd number.
[mon]
	mon data =3D /var/ceph/mon$id
	; some minimal logging (just message traffic) to aid debugging
	debug ms =3D 1
[mon0]
	host =3D node141
	mon addr =3D 192.168.1.141:6789
[mon1]
	host =3D node145
	mon addr =3D 192.168.1.145:6789
[mon2]
	host =3D node150
	mon addr =3D 192.168.1.150:6789

; You need at least one mds. Define two to get a standby.
[mds]
	; where the mds keeps it's secret encryption keys
	keyring =3D /var/ceph/keyring.$name
[mds0]
	host =3D node141
[mds1]
	host =3D node145
[mds2]
	host =3D node150

; osd
;  You need at least one.  Two if you want data to be replicated.
;  Define as many as you like.
[osd]
	; This is where the btrfs volume will be mounted.
	osd data =3D /var/ceph/osd$id

	; Ideally, make this a separate disk or partition.  A few GB
 	; is usually enough; more if you have fast disks.  You can use
 	; a file under the osd data dir if need be
 	; (e.g. /data/osd$id/journal), but it will be slower than a
 	; separate disk or partition.
	osd journal =3D /var/ceph/osd$id/journal

[osd0]
	host =3D node141
[osd1]
	host =3D node145
[osd2]
	host =3D node150
[osd3]
	host =3D node146
[osd4]
	host =3D node147
[osd5]
	host =3D node149
[osd6]
	host =3D node142
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMA7DsWto1QDEAkw8RAvq7AJ0a8BiT6QYbcSWXhnWXeGFHHE250QCfQy/z
aoniABAMK/m8ajrzv7o/rG4=
=TQFZ
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
