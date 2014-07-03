From: Loic Dachary <loic@dachary.org>
Subject: Testing remapping for locally repairable codes
Date: Thu, 03 Jul 2014 13:02:56 +0200
Message-ID: <53B53860.4070601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XhttRqo5s8i1wGcNxwRkhP6VOlR9rQhTV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36740 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751198AbaGCLDD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 07:03:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XhttRqo5s8i1wGcNxwRkhP6VOlR9rQhTV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

After https://github.com/ceph/ceph/pull/1890 is properly tested and merge=
d, "remapping for locally repairable codes" https://github.com/ceph/ceph/=
pull/1911 will follow. Should it be tested with the rados suite as well a=
s upgrade/firefly-x ? http://pulpito.ceph.com/compare/?branch=3Dmaster&su=
ite=3Drados seem to indicate that the rados suite has not been run agains=
t master recently which makes it more difficult to sort out errors relate=
d to the patch itself.=20

Do you have a suggestion ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--XhttRqo5s8i1wGcNxwRkhP6VOlR9rQhTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO1OGEACgkQ8dLMyEl6F23J9QCgj5J+syer4xxnZ8jqSMiCWNky
r2oAoIpmHieQzZroWfqHqMdzx7aW1rgj
=GCaO
-----END PGP SIGNATURE-----

--XhttRqo5s8i1wGcNxwRkhP6VOlR9rQhTV--
