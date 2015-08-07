From: Loic Dachary <loic@dachary.org>
Subject: OpenStack teuthology backend
Date: Fri, 07 Aug 2015 11:35:20 +0200
Message-ID: <55C47BD8.3020809@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NQjkVDHWp6exUP2G7infFUwkcP0SNtpsH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34780 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751521AbbHGJfX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 05:35:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NQjkVDHWp6exUP2G7infFUwkcP0SNtpsH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

I will do the following while you're on vacation next week:

 * make openstack a sub package
 * use py.test instead of testtools
 * make the user configurable

I will be on vacation during the last two weeks of august but I'll be abl=
e to address any additional concerns afterwards. Please let me know if I =
forgot something.

https://github.com/ceph/teuthology/pull/592

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--NQjkVDHWp6exUP2G7infFUwkcP0SNtpsH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXEe9gACgkQ8dLMyEl6F20loQCffeKTu2HV28ynuZw2JsLR2tYF
A3YAoLnN+1Y6CFU2df3qAv+6mgUSpnyZ
=M6kT
-----END PGP SIGNATURE-----

--NQjkVDHWp6exUP2G7infFUwkcP0SNtpsH--
