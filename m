From: Loic Dachary <loic@dachary.org>
Subject: teuthology-suite and priorities
Date: Mon, 23 Mar 2015 15:20:15 +0100
Message-ID: <5510211F.3020007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MHXXksmMCiTEf9clpLi5ihbweUW9sWOfl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35032 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752546AbbCWOUS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 10:20:18 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MHXXksmMCiTEf9clpLi5ihbweUW9sWOfl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

When scheduling suites that are low priority (giant for instance at http:=
//pulpito.ceph.com/loic-2015-03-23_01:09:31-rados-giant---basic-multi/), =
the --priority 1000 is set because (if I remember correctly) this is the =
standard priority for nightlies. However, it seems to be different becaus=
e this morning the giant suite was running although a hammer suite was sc=
heduled before it (for instance http://pulpito.ceph.com/teuthology-2015-0=
3-22_23:18:01-multimds-hammer-testing-basic-multi/) and was still waiting=
=2E

The giant suite was killed so that it does not interfere with more urgent=
 jobs. Looking at the teuthology jobs there does not seem to be a trace o=
f the priority, probably stored elsewhere.=20

I would be very grateful if you could explain how priorities should be us=
ed.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--MHXXksmMCiTEf9clpLi5ihbweUW9sWOfl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUQIR8ACgkQ8dLMyEl6F214+ACgpmevgx/cutRhKNI6YOpCh897
QnoAn3WLkH/AADjJAJwlo2Lf6aGKSwVj
=i7rn
-----END PGP SIGNATURE-----

--MHXXksmMCiTEf9clpLi5ihbweUW9sWOfl--
