From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology config file
Date: Fri, 17 Oct 2014 05:55:29 -0700
Message-ID: <544111C1.2030504@dachary.org>
References: <656229825.13656.1413543806937.JavaMail.yahoo@jws10601b.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="e0MKXAM1FCWX2XBGsntsjsMW8b3DGBDOQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47404 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752171AbaJQMzh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Oct 2014 08:55:37 -0400
In-Reply-To: <656229825.13656.1413543806937.JavaMail.yahoo@jws10601b.mail.bf1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Z <david.z1003@yahoo.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e0MKXAM1FCWX2XBGsntsjsMW8b3DGBDOQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi David,

Zack is the ultimate authority on teuthology but I'm happy to give my non=
 authoritative opinion ;-) Moving the discussion to ceph-devel as ceph-qa=
 is more about the QA results than QA discussion, if I understand correct=
ly.

On 17/10/2014 04:03, David Z wrote:
> Hi Loic, or ceph-qa,
>=20
> We are trying to adopt teuthology for our test purpose. We are referrin=
g to the README of teuthology (
> https://github.com/ceph/teuthology/), but still meet some problems to r=
un this framework completely on our hardware. So we would like to ask you=
 for some help.
>=20
> Q1: How do you trigger all the test cases? Is there one unique config f=
ile containing all the tasks, so only need one trigger? Could you please =
share us your config files used to run regression test?

Triggering everything is going to create a massive number of jobs and is =
probably not what you want.

> Q2: Is there any other guidances except README, could help us more easi=
er to use this framework?

There is not much more but I think Zack recently updated documentation. A=
nd teuthology has never been easier to use so you should succeed. To begi=
n with I would recommend that you do not setup the lock server nor pulpit=
o and focus exclusively on teuthology itself. You do not even need to con=
cern yourself with provisioning targets: just run 3 or 5 vms and manually=
 create a target file for teuthology to work with.

http://dachary.org/?p=3D2204 is ancient but it should still work and get =
you started.

Cheers
> Thanks.
>=20
> Regards,
> David Zhang=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--e0MKXAM1FCWX2XBGsntsjsMW8b3DGBDOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRBEcEACgkQ8dLMyEl6F21/YgCgjSFAQDMS5LqrJjo3318JSVBm
1LcAoJ+nEV24EWrblKab8REWkK0Lfqtk
=ttc2
-----END PGP SIGNATURE-----

--e0MKXAM1FCWX2XBGsntsjsMW8b3DGBDOQ--
