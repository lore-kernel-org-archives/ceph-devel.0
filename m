From: Jonathan Dieter <jdieter@lesbg.com>
Subject: Re: ceph 0.44+ and leveldb
Date: Wed, 11 Apr 2012 18:04:19 +0300
Message-ID: <1334156659.2114.25.camel@jdlaptop.lesbg.loc>
References: <1333689498.19737.11.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1204060943510.3020@cobra.newdream.net>
	 <1333741995.2114.15.camel@jdlaptop.lesbg.loc>
	 <Pine.LNX.4.64.1204092232550.26893@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ZjBJCeLdyZkmA3DbEFKi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35984 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab2DKPE2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 11:04:28 -0400
Received: by wibhq7 with SMTP id hq7so988807wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 08:04:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204092232550.26893@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Laszlo Boszormenyi <gcs@debian.hu>, ceph-devel@vger.kernel.org


--=-ZjBJCeLdyZkmA3DbEFKi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-04-09 at 22:36 -0700, Sage Weil wrote:
> Hi Laszlo, Jonathan,
>=20
> configure will now accept a --with-system-leveldb flag that will use the=
=20
> installed libleveldb.  For Debian, we just need to update debian/rules an=
d=20
> add libsnappy-dev and libleveldb-dev to the build depends.
>=20
> Jonathan, I'm not doing anything to the .spec file yet either, since=20
> presumably leveldb needs to be packaged first.
>=20
> The change is in the next and master branches, so it'll be there for=20
> v0.45 (which I plan to release tomorrow).

Thanks much!  I'll see what it will take to get leveldb into Fedora.

Jonathan

--=-ZjBJCeLdyZkmA3DbEFKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAk+FnXMACgkQH3CnpFdSY1xeDQCeK0YpogZkfQINp3HkddNAh4Dx
+NgAn1GkOcubLZV7TY+MgJOTKocLgMet
=d4+m
-----END PGP SIGNATURE-----

--=-ZjBJCeLdyZkmA3DbEFKi--

