From: Jonathan Dieter <jdieter@lesbg.com>
Subject: Re: ceph auth add?
Date: Tue, 06 Jul 2010 23:34:20 +0300
Message-ID: <1278448460.2500.13.camel@jdlaptop.lesbg.loc>
References: <1278444535.2500.11.camel@jdlaptop.lesbg.loc>
	 <Pine.LNX.4.64.1007061305590.32371@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Al3gSWQynm6471dEYGSJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55090 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab0GFUe3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jul 2010 16:34:29 -0400
Received: by ewy23 with SMTP id 23so1930753ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jul 2010 13:34:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1007061305590.32371@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--=-Al3gSWQynm6471dEYGSJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-07-06 at 13:07 -0700, Sage Weil wrote:
> On Tue, 6 Jul 2010, Jonathan Dieter wrote:
> > Are there any pointers on how to use "ceph auth add"?  I'm trying to ad=
d
> > a second osd and am running into trouble at the step where I'm supposed
> > to run "ceph auth get osd.1 -o /data/keyring.osd1" at
> > http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction
> >=20
> > It seems that osd.1 isn't in the server's keyring yet, but I haven't
> > worked out how to add it yet.
> >=20
> > Running the following commands on the server:
> > ceph auth add osd.1 --in-file=3D/data/keyring.osd1
>=20
> Try
>=20
>  ceph auth add osd.1 -i /data/keyring.osd1
>=20
> The long form was --in-data instead of --in-file... now fixed in unstable=
. =20
> But you can just use the short form -i.

And that did the trick!  Thanks much.  I've now got two osds and the
second is automatically copying the data.

Jonathan

--=-Al3gSWQynm6471dEYGSJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkwzk0wACgkQH3CnpFdSY1zI4QCfTZUPACqQ6b4HD9IiEDpqV7Fk
QoIAoIFDYac8mnA4NBbZK8UaVvcHEKmR
=G2bI
-----END PGP SIGNATURE-----

--=-Al3gSWQynm6471dEYGSJ--

