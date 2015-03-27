From: Loic Dachary <loic@dachary.org>
Subject: Documenting user visible changes
Date: Fri, 27 Mar 2015 13:54:38 +0100
Message-ID: <5515530E.1020404@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="omtaIAo0AqVP42AViq1fro5HCaj1DnJNb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37765 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752631AbbC0Myl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 08:54:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Alistair Israel <aisrael@gmail.com>, Neil Levine <nlevine@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--omtaIAo0AqVP42AViq1fro5HCaj1DnJNb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

It would be nice if the description of an issue contained a paragraph doc=
umenting user visible changes, when relevant. They could be conveniently =
linked from the release notes.=20

Although it could be done when backporting or preparing the release notes=
, it's a significant amount of work, reason why it has not been done for =
all issues so far. I tried on an issue I know well:

   http://tracker.ceph.com/issues/9665#User-description

and another I did not know anything about:

   http://tracker.ceph.com/issues/6228#User-description

Although Alistair proofread it and said http://tracker.ceph.com/issues/62=
28#User-description improves his understanding of the problem and the sol=
ution, it took me a long time to write and I don't find it particularly c=
lear or well written. The next step would be to have it reviewed by someo=
ne else and improve. I'd be happy to do it as part of the backport work, =
to help developers who did not have time or forgot about it. But I suspec=
t that if we have to do it for all issues it won't work because it's too =
much work.

I'm cc'ing Neil because he made me realize how important it is to have us=
er visible changes properly documented.

Any idea you may have are very welcome :-)

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--omtaIAo0AqVP42AViq1fro5HCaj1DnJNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUVUw4ACgkQ8dLMyEl6F22WEgCgueikRJ3JxWeSpayaAZ9PIKRo
i5oAn1G1Jnld/BLY00wKqhkAVWbbkAh9
=bYr1
-----END PGP SIGNATURE-----

--omtaIAo0AqVP42AViq1fro5HCaj1DnJNb--
