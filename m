From: Loic Dachary <loic@dachary.org>
Subject: teuthology task waiting for machines (> 8h)
Date: Sat, 28 Jun 2014 12:27:06 +0200
Message-ID: <53AE987A.6080500@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lPiTtHCQC2f0KXHNR7qARhcS1lHnqcnn1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59355 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752175AbaF1K1M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jun 2014 06:27:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lPiTtHCQC2f0KXHNR7qARhcS1lHnqcnn1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Zack,

http://pulpito.ceph.com/loic-2014-06-27_18:45:37-upgrade:firefly-x:stress=
-split-wip-8475-testing-basic-plana/329515/

seems to indicate that the tasks cannot obtain the machines it needs:

2014-06-27T17:55:19.072 INFO:teuthology.task.internal:Locking machines...=

2014-06-27T17:55:19.110 INFO:teuthology.task.internal:waiting for more ma=
chines to be free (need 3 see 5)...
2014-06-27T17:55:29.175 INFO:teuthology.task.internal:waiting for more ma=
chines to be free (need 3 see 5)...
=2E..
2014-06-28T03:22:13.745 INFO:teuthology.task.internal:waiting for more ma=
chines to be free (need 3 see 0)...
2014-06-28T03:22:23.787 INFO:teuthology.task.internal:waiting for more ma=
chines to be free (need 3 see 0)...

Is it something expected (for instance when tasks with a higher priorty t=
ake precedence) ? If it is then all that's needed is patience right ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--lPiTtHCQC2f0KXHNR7qARhcS1lHnqcnn1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOumHoACgkQ8dLMyEl6F23+pACdFRwt73xhXIyqVc9i3kl6qan3
pNEAn129e7PFhdoy+xV7nfYAyfqNxVsJ
=E/+W
-----END PGP SIGNATURE-----

--lPiTtHCQC2f0KXHNR7qARhcS1lHnqcnn1--
