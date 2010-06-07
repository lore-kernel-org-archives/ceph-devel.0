From: Andre Noll <maan@systemlinux.org>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Mon, 7 Jun 2010 10:07:54 +0200
Message-ID: <20100607080754.GU1211@skl-net.de>
References: <20100531125156.GJ1211@skl-net.de> <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net> <20100602081044.GY1212@skl-net.de> <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net> <20100604084521.GO1211@skl-net.de> <Pine.LNX.4.64.1006040944331.2384@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEk28Nl/eckWL8CC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:45289 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab0FGIIF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jun 2010 04:08:05 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006040944331.2384@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--vEk28Nl/eckWL8CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 09:48, Sage Weil Wrote
> On Fri, 4 Jun 2010, Andre Noll wrote:
> > On Wed, Jun 02, 11:19, Sage Weil Wrote
> > > Okay, it looks like there is a corrupt PG log.  Can you tar up the=20
> > > $osd_data/current/meta directory, and then 'f 8' and 'p /x info.pgid'=
 from=20
> > > gdb (to figure out which pg it's loading)?
> >=20
> > It's in decode_nohead():
> >=20
> > 	...
> > 	Program received signal SIGABRT, Aborted.
> > 	[Switching to Thread 0x7ff115b566f0 (LWP 5045)]
> > 	0x00007ff1146e9095 in raise () from /lib/libc.so.6
> > 	(gdb) f 8
> > 	#8  0x0000000000540920 in PG::read_log (this=3D0x7ff1104b6460,
> > 	store=3D<value optimized out>) at ./include/cstring.h:120
> > 	120         _data =3D new char[_len + 1];
> > 	(gdb) p /x info.pgid
> > 	$1 =3D {v =3D {preferred =3D {v =3D 0xffff}, ps =3D {v =3D 0x1bf}, poo=
l =3D {v =3D 0x0}}}
>=20
> The pgid's format like $pool.$ps[p$preferred] (where the preferred bit=20
> only shows up if >=3D 0).  In hex.  So the pgid above is 0.1bf, and the=
=20
> corrupted log should be current/meta/pglog_0.1bf_0.  If you send me that=
=20
> file (off list) I can see what the corruption looks like.

Thanks for the explanation. I'll send it off-list in a minute.
It's 361K large.

> If you want to try to bring the osd up without that pg, you can move that=
=20
> pglog file and current/0.1bf to some other temp directory and restart=20
> cosd.

Did not work. It recreated that file and then crashed for the same
reason. The gdb output is identical, but the file contents have
changed. I'll send the new pglog_0.1bf_0 as well.

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--vEk28Nl/eckWL8CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMDKjaWto1QDEAkw8RAutsAJ9O9UBPO2hLcpNh2o46zOjpDFTaUgCZAW5e
zxgy62il249ETQZUgYTGG/s=
=qXGx
-----END PGP SIGNATURE-----

--vEk28Nl/eckWL8CC--
