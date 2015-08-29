From: Loic Dachary <loic@dachary.org>
Subject: hammer integration branch
Date: Sat, 29 Aug 2015 11:47:10 +0200
Message-ID: <55E17F9E.4060507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d4fUHbJOnJCvrJSVc6OE1iLrNIlQhJAhN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45787 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752135AbbH2JrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Aug 2015 05:47:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d4fUHbJOnJCvrJSVc6OE1iLrNIlQhJAhN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

Good news : upgrade jobs pass when https://github.com/ceph/ceph/pull/5361=
 is not included. We can set it aside for now :-)

Could you update your teuthology run results as explained at http://track=
er.ceph.com/projects/ceph-releases/wiki/HOWTO_describe_a_test_result ? Yo=
u should find that all failures are S3 related. We don't need to be conce=
rned about that, it's an OpenStack specific failure that needs to be sort=
ed out (http://tracker.ceph.com/issues/12471#note-4 probably).

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--d4fUHbJOnJCvrJSVc6OE1iLrNIlQhJAhN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXhf54ACgkQ8dLMyEl6F23rpACdGBFj+q8vM8pFclkjXy7ZwzAw
0bAAn1RdCvlvszLY7R9qJyV2+CbT+RjU
=3BUt
-----END PGP SIGNATURE-----

--d4fUHbJOnJCvrJSVc6OE1iLrNIlQhJAhN--
