From: Loic Dachary <loic@dachary.org>
Subject: Relation between crush ruleset and erasure code profile
Date: Thu, 07 Aug 2014 10:06:54 +0200
Message-ID: <53E3339E.1020106@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mp07wriDvNhnUOG4FOKQbpuwUMpe1Dl0C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55254 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754932AbaHGIG6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Aug 2014 04:06:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ma Jianpeng <majianpeng@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mp07wriDvNhnUOG4FOKQbpuwUMpe1Dl0C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Followup from a private conversation so that others can benefit from it]=


Hi,

The erasure code profile is independant from the crush ruleset. It is a d=
escritpion of the parameters that will be used to

* Create the erasure coded crush ruleset if needed
* Create the erasure coded pool

It exists as a separate object because it is used in these two different =
contexts. When you use the=20

   osd crush rule create-erasure

command, it will ask the erasure code plugin to create a meaningfull crus=
h ruleset, based on the content of the profile. When you use the=20

   osd pool create

 command, it will bind the erasure code plugin to the pool and initialize=
 the plugin with the content of the profile.

Does it clarify the relationship between the profile and the crush rulese=
t ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--mp07wriDvNhnUOG4FOKQbpuwUMpe1Dl0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPjM54ACgkQ8dLMyEl6F23NswCePMfLWC1wxKO3YmHenyY/qne3
jD8AnA64AqSuWDbw/A7HKLn4ESQkTiR0
=lLGb
-----END PGP SIGNATURE-----

--mp07wriDvNhnUOG4FOKQbpuwUMpe1Dl0C--
