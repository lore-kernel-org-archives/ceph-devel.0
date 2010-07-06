From: Jonathan Dieter <jdieter@lesbg.com>
Subject: ceph auth add?
Date: Tue, 06 Jul 2010 22:28:55 +0300
Message-ID: <1278444535.2500.11.camel@jdlaptop.lesbg.loc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Z1IsIMs7IbzJTPLrCNRr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61327 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab0GFT5J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jul 2010 15:57:09 -0400
Received: by wwb24 with SMTP id 24so2178218wwb.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jul 2010 12:57:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-Z1IsIMs7IbzJTPLrCNRr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Are there any pointers on how to use "ceph auth add"?  I'm trying to add
a second osd and am running into trouble at the step where I'm supposed
to run "ceph auth get osd.1 -o /data/keyring.osd1" at
http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction

It seems that osd.1 isn't in the server's keyring yet, but I haven't
worked out how to add it yet.

Running the following commands on the server:
ceph auth add osd.1 --in-file=3D/data/keyring.osd1
ceph auth add osd.1 /data/keyring.osd1
ceph auth add osd.1 < /data/keyring.osd1

all give me variants of

10.07.06 22:23:58.953255 7f3cffc5f710 monclient(hunting): found mon0
10.07.06 22:23:58.953509 mon <- [auth,add,osd.1]
10.07.06 22:23:58.953702 mon0 -> 'error decoding keyring' (-22)

# ceph auth list
mon.
	key: AQ**********************************+w=3D=3D
mds.ceph-server-01
	key: AQ**********************************zA=3D=3D
	caps: [mds] allow
	caps: [mon] allow rwx
	caps: [osd] allow *
osd.0
	key: AQ**********************************Ug=3D=3D
	caps: [mon] allow rwx
	caps: [osd] allow *
client.admin
	key: AQ**********************************zg=3D=3D
	caps: [mds] allow
	caps: [mon] allow *
	caps: [osd] allow *
' (0)

# cauthtool --list /data/keyring.osd1
osd.1
	key: AQ**********************************GA=3D=3D
	auid: 18***************15
	caps: [mon] allow rwx
	caps: [osd] allow *

--=-Z1IsIMs7IbzJTPLrCNRr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkwzg/cACgkQH3CnpFdSY1wgVgCeJGclKkVTAnOUk5yq7Nyj3bCp
4pIAmgLndHEhREyH/9JA1B7Ej4UDWrNh
=eUMH
-----END PGP SIGNATURE-----

--=-Z1IsIMs7IbzJTPLrCNRr--

