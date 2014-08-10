From: Loic Dachary <loic@dachary.org>
Subject: Swift tests failing randomly
Date: Sun, 10 Aug 2014 10:46:37 +0200
Message-ID: <53E7316D.3090808@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tEuWJ3cR8h6wlfUs8CcfvCj5HJSlNF4Vg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56883 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751194AbaHJIqp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Aug 2014 04:46:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tEuWJ3cR8h6wlfUs8CcfvCj5HJSlNF4Vg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

In the past few months the swift tests failed randomly and I was unfortun=
ately unable to figure out why. Here are a few examples:

    http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:st=
ress-split-wip-9025-chunk-remapping-testing-basic-vps/406944
    http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:st=
ress-split-wip-9025-chunk-remapping-testing-basic-vps/406941
    http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:st=
ress-split-wip-9025-chunk-remapping-testing-basic-vps/406946
    http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly-x:st=
ress-split-wip-9025-chunk-remapping-testing-basic-vps/406947

and it has happened on every upgrade test run since I can remember. I fai=
l to see a pattern and cannot figure out what the real problem is. It wou=
ld be really great if you could take a look. Even a hunch or a tip would =
be greatly appreciated :-)=20

You can find more context in=20

http://tracker.ceph.com/issues/8988
http://tracker.ceph.com/issues/8016
http://tracker.ceph.com/issues/7799

and discussions at

http://www.spinics.net/lists/ceph-devel/msg19933.html

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--tEuWJ3cR8h6wlfUs8CcfvCj5HJSlNF4Vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPnMW0ACgkQ8dLMyEl6F22OwQCfYbvf0UJ0S76oR6UFDYdtuXOy
cVUAoMapDQ8948pPEnWtBAcSEM0xZfGU
=Ux+K
-----END PGP SIGNATURE-----

--tEuWJ3cR8h6wlfUs8CcfvCj5HJSlNF4Vg--
