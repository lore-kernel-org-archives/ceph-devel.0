From: Loic Dachary <loic@dachary.org>
Subject: Re: RHEL7 source packages
Date: Sat, 11 Oct 2014 18:16:22 +0200
Message-ID: <543957D6.5040801@dachary.org>
References: <54395059.6030507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NceQJUSlBLTarvJEeq7PmaoN9UbAAaGiU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42670 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752742AbaJKQQ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Oct 2014 12:16:28 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 52493420A2
	for <ceph-devel@vger.kernel.org>; Sat, 11 Oct 2014 18:16:22 +0200 (CEST)
In-Reply-To: <54395059.6030507@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NceQJUSlBLTarvJEeq7PmaoN9UbAAaGiU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[sent mail by mistake, here is the full version ;-]

On 11/10/2014 17:44, Loic Dachary wrote:
> Hi Ceph,
>=20
> I find this line in https://github.com/ceph/ceph/blob/giant/ceph.spec.i=
n#L382
>=20
> %if (0%{?rhel} || 0%{?rhel} < 7)
>=20
> odd because it looks like exactly the same as
>=20
> %if 0%{?rhel}
>=20
> But it has been added a long time ago
>=20
>=20

I filed a bug to followup http://tracker.ceph.com/issues/9747

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NceQJUSlBLTarvJEeq7PmaoN9UbAAaGiU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ5V9YACgkQ8dLMyEl6F23+uQCgsTMyTF7usiOUUIAW8gJsvVo4
p9AAoLxwHARQCAxjG7bC6ixH2CI8VWoF
=YS1V
-----END PGP SIGNATURE-----

--NceQJUSlBLTarvJEeq7PmaoN9UbAAaGiU--
