From: Loic Dachary <loic@dachary.org>
Subject: rgw hammer backport : S3ResponseError: 403 Forbidden
Date: Mon, 31 Aug 2015 18:04:11 +0200
Message-ID: <55E47AFB.3030002@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E6s4KUalRGD6kTWqgFSWB4wJOrw6HPOkw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46876 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753302AbbHaQEO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Aug 2015 12:04:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Orit Wasserman <owasserm@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E6s4KUalRGD6kTWqgFSWB4wJOrw6HPOkw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alfredo,

Orit suggested I ask you about the error I'm seeing with two rgw hammer b=
ackports[1]. When merged, https://github.com/ceph/ceph/pull/5387 and http=
s://github.com/ceph/ceph/pull/5714 consistently fail with S3ResponseError=
: 403 Forbidden as shown at http://pulpito.ceph.com/loic-2015-08-31_12:13=
:37-rgw-hammer-backports-loic-fail---basic-multi/1039692/ which was sched=
uled with=20

  filter=3D"rgw/singleton/{overrides.yaml all/radosgw-admin-data-sync.yam=
l frontend/civetweb.yaml rgw_pool_type/ec-profile.yaml}"
  teuthology-suite --priority 101 --suite rgw --filter=3D"$filter" --suit=
e-branch hammer --distro ubuntu --email loic@dachary.org --ceph hammer-ba=
ckports-loic --machine-type plana,burnupi,mira

Your help would be much appreciated.

Cheers

[1] http://tracker.ceph.com/issues/12701

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--E6s4KUalRGD6kTWqgFSWB4wJOrw6HPOkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXkevsACgkQ8dLMyEl6F22fewCePnVSX/kfm1SL8xNcTRwTTrGg
eG0AnRClmL31GBYq0zEZK3BI1ITZIdR/
=OsiE
-----END PGP SIGNATURE-----

--E6s4KUalRGD6kTWqgFSWB4wJOrw6HPOkw--
