From: Loic Dachary <loic@dachary.org>
Subject: Crush ruleset for locally repairable codes (LRC)
Date: Sun, 08 Jun 2014 16:30:17 +0200
Message-ID: <53947379.1020407@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1uLSm4lA7J7hdmdCA7DouJBn9pHvHsoN6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:37659 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbaFHOaU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Jun 2014 10:30:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1uLSm4lA7J7hdmdCA7DouJBn9pHvHsoN6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

The draft ruleset creation matching for LRC is documented at

https://github.com/dachary/ceph/commit/2ae645438243232392c11fd80fd960f622=
1fd2a0#diff-5518964bc98a094a784ce2d17a5b0cc1R147

tested at

https://github.com/dachary/ceph/commit/2ae645438243232392c11fd80fd960f622=
1fd2a0#diff-300a5998686e416e9255777f82fe8c57R90

and implemented at

https://github.com/dachary/ceph/commit/2ae645438243232392c11fd80fd960f622=
1fd2a0#diff-e8889adeda9017a36ae4f5000b9c2534R42

There are two points for which your advice would be most appreciated:

* The default ruleset is the same as for jerasure, i.e. host is the failu=
re domain. The primary reason is that it is likely to work anywhere, henc=
e it is a good default. Although it does not match any actual use case, i=
t there is a side effect that can be observed externally (i.e. reduced in=
ter-host bandwidth during recovery) and that matches the expected benefit=
=2E It would be an actual benefit if machines were connected to a hub but=
 that is unlikely to be the case nowadays ;-)

* Control of the crush ruleset steps is made explicit and disconnected fr=
om the description of the layers. Trying to link the encoding steps to th=
e crush description creates confusion because the logic is different. The=
 crush ruleset is designed first, thinking about failure domains. The era=
sure code processing is designed next, using the N OSDs provided by crush=
=2E  Hopefully the examples and logic documented at

https://github.com/dachary/ceph/commit/2ae645438243232392c11fd80fd960f622=
1fd2a0#diff-5518964bc98a094a784ce2d17a5b0cc1R20

make sense to the Ceph operator.=20

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--1uLSm4lA7J7hdmdCA7DouJBn9pHvHsoN6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOUc3kACgkQ8dLMyEl6F22X9wCcD5DKyIPYBLOUTrEpjt5iYeW7
tjAAoKMDYnhpjpU/UxlaiV5mTz8Fzc+P
=fV1T
-----END PGP SIGNATURE-----

--1uLSm4lA7J7hdmdCA7DouJBn9pHvHsoN6--
