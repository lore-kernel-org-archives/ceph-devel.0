From: Andre Noll <maan@systemlinux.org>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Fri, 4 Jun 2010 10:45:21 +0200
Message-ID: <20100604084521.GO1211@skl-net.de>
References: <20100531125156.GJ1211@skl-net.de> <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net> <20100602081044.GY1212@skl-net.de> <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:37608 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab0FDIpd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jun 2010 04:45:33 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 11:19, Sage Weil Wrote
> Okay, it looks like there is a corrupt PG log.  Can you tar up the=20
> $osd_data/current/meta directory, and then 'f 8' and 'p /x info.pgid' fro=
m=20
> gdb (to figure out which pg it's loading)?

It's in decode_nohead():

	...
	Program received signal SIGABRT, Aborted.
	[Switching to Thread 0x7ff115b566f0 (LWP 5045)]
	0x00007ff1146e9095 in raise () from /lib/libc.so.6
	(gdb) f 8
	#8  0x0000000000540920 in PG::read_log (this=3D0x7ff1104b6460,
	store=3D<value optimized out>) at ./include/cstring.h:120
	120         _data =3D new char[_len + 1];
	(gdb) p /x info.pgid
	$1 =3D {v =3D {preferred =3D {v =3D 0xffff}, ps =3D {v =3D 0x1bf}, pool =
=3D {v =3D 0x0}}}

> There is an open bug for pglog corruption, but I haven't been able to=20
> identify where it's actually happening.

How can one determine the pg from the above output? BTW: cosd has
/var/ceph/osd6/current/commit_op_seq open and this file contains the
number 1103797. Does that tell us anything?

> Generally speaking, once you identify the bad pg, you can just delete the=
=20
> offending pglog and data directory from the osd, restart, and it will=20
> recover.  Provided you haven't corrupted both copies of the same pg on=20
> different osds.  Or more often than not, there is more than one corrupted=
=20
> log, and you have to repeat the process a few times.

That's valuable information, thanks. It should probably be documented
somewhere.

> This is probably the sort of corruption that we should log but not crash=
=20
> on, so that the osd can continue to start up (and just skip the offending=
=20
> pg).  I'll open an issue for that in the tracker.

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMCL0hWto1QDEAkw8RAtHNAJ9ZfpEBj22YiXLWeyYADnxxT7wNFQCgjjJz
FpGB9TxFi4zcsqLd+OUfjUo=
=Ja48
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--
