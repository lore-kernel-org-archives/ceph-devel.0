From: Loic Dachary <loic@dachary.org>
Subject: teuthology and erasure code pool creation
Date: Sun, 08 Jun 2014 18:00:35 +0200
Message-ID: <539488A3.3070507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cTEOr7Ex6CwBnCL8W1pmi5mIDbPsee2HC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:37711 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbaFHQAi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Jun 2014 12:00:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cTEOr7Ex6CwBnCL8W1pmi5mIDbPsee2HC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Zack,

In order to test locally repairable codes ( described at https://wiki.cep=
h.com/Planning/Blueprints/Giant/Pyramid_Erasure_Code and documented at ht=
tps://github.com/dachary/ceph/commit/2ae645438243232392c11fd80fd960f6221f=
d2a0#diff-5518964bc98a094a784ce2d17a5b0cc1R20 ) it would be a convenient =
to set the erasure code profile without modifying the teuthology code.=20

There are not too many instances of hardcoded parameters:

  https://github.com/ceph/teuthology/blob/master/teuthology/task_util/rad=
os.py#L27
  https://github.com/ceph/teuthology/blob/master/teuthology/task/ceph_man=
ager.py#L732

and it could be generalized. In a nutshell, the definition of an erasure =
coded profile is a set of key value which should default to:

  k: 2
  m: 1
  plugin: jerasure
  ruleset-failure-domain: osd

and=20

  self.raw_cluster_cmd('osd', 'erasure-code-profile', 'set', 'teuthologyp=
rofile', 'ruleset-failure-domain=3Dosd', 'm=3D'+str(ec_m), 'k=3D'+str(ec_=
k))

could be replaced with:
  =20
   self.raw_cluster_cmd('osd', 'erasure-code-profile', 'set', 'teuthology=
profile', **kwargs)

assuming kwargs is the above map parsed from the yaml.=20

Any advice you may have on the implementation would be very welcome :-)

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--cTEOr7Ex6CwBnCL8W1pmi5mIDbPsee2HC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOUiKMACgkQ8dLMyEl6F215WwCdHYSClPEDSNtrA1j7a91mNVBI
SNcAoIRbrcPrPzdq2l4HTSNZqyNBjO0t
=MlZq
-----END PGP SIGNATURE-----

--cTEOr7Ex6CwBnCL8W1pmi5mIDbPsee2HC--
