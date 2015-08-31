From: Loic Dachary <loic@dachary.org>
Subject: New ceph-qa-suite : ceph-disk
Date: Mon, 31 Aug 2015 18:19:51 +0200
Message-ID: <55E47EA7.2050600@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nLO9Igf7WpDbNeL1FSiVAsAQQeWQw6laE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46891 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753307AbbHaQTy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Aug 2015 12:19:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nLO9Igf7WpDbNeL1FSiVAsAQQeWQw6laE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

There is a new suite at https://github.com/ceph/ceph-qa-suite/tree/master=
/suites/ceph-disk. It would be great if it could be added to the nightlie=
s[1] as follows:

  teuthology-suite -v -c infernalis -m vps -s ceph-disk

Cheers

P.S. I know you're on vacation, it can wait for your return ;-)

[1] nightlies http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nLO9Igf7WpDbNeL1FSiVAsAQQeWQw6laE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXkfqcACgkQ8dLMyEl6F23bqQCfZcBx0gVQcXoU0DIZTeHr6ejC
NmIAn2vkzRVCByy/2GIvs4tj/F9jtLCk
=JAgs
-----END PGP SIGNATURE-----

--nLO9Igf7WpDbNeL1FSiVAsAQQeWQw6laE--
