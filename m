From: Loic Dachary <loic@dachary.org>
Subject: hammer/firefly backports upgrade suite
Date: Wed, 29 Jul 2015 23:34:08 +0200
Message-ID: <55B946D0.3070308@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NuNSpUMjnRw1iVnFv9B9sfeobb4w8sroA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58434 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754083AbbG2VeN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 17:34:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NuNSpUMjnRw1iVnFv9B9sfeobb4w8sroA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan & Abhishek,

It turns out the mistake was to use upgrade/firefly-x and upgrade/hammer-=
x instead of upgrade/firelfy and upgrade/hammer. When -c hammer-backports=
 or -c firefly-backports is given to teuthology-suite, it will upgrade to=
 this version, from older versions of the same stable branch.

I've updated:

http://tracker.ceph.com/issues/11644#upgrade
http://tracker.ceph.com/issues/11990#upgrade

whith the fix and they are running (using the OpenStack cluster though, t=
here may be issues with the firefly upgrade suite but the hammer upgrade =
suite must run fine, it has run at http://ceph.aevoo.fr:8081/ enough time=
s to suggest there are no OpenStack specific issues).

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--NuNSpUMjnRw1iVnFv9B9sfeobb4w8sroA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW5RtAACgkQ8dLMyEl6F20niwCghScXVwZdGmycbb4lcjFhT5SU
UYAAn2VxekKKcWSGOPQUIBUFH2ZSHGRK
=3VfW
-----END PGP SIGNATURE-----

--NuNSpUMjnRw1iVnFv9B9sfeobb4w8sroA--
