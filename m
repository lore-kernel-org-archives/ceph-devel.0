From: Loic Dachary <loic@dachary.org>
Subject: Re: [Teuthology] Upgrade hammer on ubuntu : all passed
Date: Tue, 21 Jul 2015 00:24:05 +0200
Message-ID: <55AD7505.2070907@dachary.org>
References: <55ACD3DB.2050606@aevoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QDQL03niJ7BWCt8TFv3spPWk3su6w0WeL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53280 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757060AbbGTWYJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 18:24:09 -0400
In-Reply-To: <55ACD3DB.2050606@aevoo.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Casier AEVOO <david.casier@aevoo.fr>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QDQL03niJ7BWCt8TFv3spPWk3su6w0WeL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

Would you agree to run a similar suite against the hammer-backports branc=
h ? It already is scheduled http://pulpito.ceph.com/loic-2015-07-20_16:52=
:10-upgrade:hammer-x-hammer-backports-distro-basic-multi/ but maybe you c=
an complete it faster. The command is:

teuthology-suite --ceph hammer-backports --machine-type openstack --suite=
 upgrade/hammer-x --filter ubuntu_14.04 $HOME/src/ceph-qa-suite_master/ma=
chine_types/vps.yaml $(pwd)/teuthology/test/integration/archive-on-error.=
yaml

Cheers

On 20/07/2015 12:56, David Casier AEVOO wrote:
> Hi all,
> Good news for upgrade hammer on Ubuntu :
> http://ceph.aevoo.fr:8081/ubuntu-2015-07-19_05:44:18-upgrade:hammer-ham=
mer---basic-openstack/
> All jobs are passed.
>=20
> David
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QDQL03niJ7BWCt8TFv3spPWk3su6w0WeL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWtdQUACgkQ8dLMyEl6F20TdACfbQsi5/hT8qiluZUTAkztm6b8
tO4AnidGhF/Yj6N13Jv9VsRGBuVUC/cp
=Mjlb
-----END PGP SIGNATURE-----

--QDQL03niJ7BWCt8TFv3spPWk3su6w0WeL--
