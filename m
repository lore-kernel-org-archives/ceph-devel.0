From: Loic Dachary <loic@dachary.org>
Subject: Erasure code library summary
Date: Tue, 18 Jun 2013 14:22:59 +0200
Message-ID: <51C05123.8000002@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E7B3A98EA16FDC2354DA1FF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42910 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab3FRMXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 08:23:01 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 72F5D26394
	for <ceph-devel@vger.kernel.org>; Tue, 18 Jun 2013 14:22:59 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E7B3A98EA16FDC2354DA1FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

TL;DR: use jerasure 1.2 with Reed-Solomon to code/decode/repair an object=
, and upgrade to 2.0 when available.

Disclaimer: I'm no expert ;-) The terms are explained in wikipedia[1].

Using Reed-Solomon object O is encoded by dividing it into consecutive ch=
uncks O1, O2, ... ON and computing parity blocks P1, P2, ... PK.  Reading=
 the original content of object O is a simple concatenation of O1, O2, ..=
=2E ON. If O2 or P2 are lost, they can be repaired/reconstructed using O1=
 ... ON and P1 ... PK. If the use case is mostly reading objects and repa=
irs are at least 1000 times less likely than normal operations, being abl=
e to read the object from non-coded chuncks is attractive.=20

Reed-Solomon is significantly more expensive to encode ( 100MB/s order of=
 magnitude on a single 2.5Ghz core ) than fountain codes with the current=
 jerasure implementation[2]. However, gf-complete[3] that will be used in=
 the upcoming version of jerasure significantly improves performances ( 2=
 to 10 times faster ) and the difference becomes negligible.=20

Reed-Solomon coding family is the only one that can keep the chuncks unen=
coded and therefore concatenable.

The jerasure library is packaged and being worked on by the author at the=
 moment. All other Free Software implementations are either not packaged =
or not maintained.=20

The license[4] of jerasure is compatible with the license of Ceph.

Performances depend on the parameters to the Reed-Solomon functions but t=
hey will also be influenced by the buffer sizes used when calling the enc=
oding functions: smaller buffers will mean more calls and more overhead.

Open questions:

* Does Mojette Transform [5] have compelling qualities compared to other =
code families ?
* Do hierarchical codes [6] have compelling qualities ? Implementing them=
 would require a different API. To be effective they need to take into ac=
count the context in which an object is stored where the other code only =
require the object itself.
* I have not experiemented with the jerasure API yet

Feedback and criticisms are welcome :-)

[1] http://en.wikipedia.org/wiki/Erasure_code
[2] jerasure 1.2 http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627.ht=
ml
[3] gf-complete http://web.eecs.utk.edu/~plank/plank/papers/CS-13-703.htm=
l
[4] jerasure license https://github.com/tsuraan/Jerasure/blob/master/Lice=
nse.txt
[5] Mojette Transform http://en.wikipedia.org/wiki/Mojette_Transform
[6] hierarchical codes http://www.e-biersack.eu/BPublished/nc_springer.pd=
f


--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig4E7B3A98EA16FDC2354DA1FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHAUSMACgkQ8dLMyEl6F23zxQCeMWXZZd7RxQc09Znt9+ZA22JT
GIEAoLhT34uya3sZcRK1SsR6oUnllp1D
=wrZ1
-----END PGP SIGNATURE-----

--------------enig4E7B3A98EA16FDC2354DA1FF--
