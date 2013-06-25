From: Loic Dachary <loic@dachary.org>
Subject: Erasure coding implementation : high level description
Date: Tue, 25 Jun 2013 19:41:51 +0200
Message-ID: <51C9D65F.8000507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2F30CE10BD517907ADBAC444"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:35144 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab3FYRly (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jun 2013 13:41:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F30CE10BD517907ADBAC444
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

Paraphrasing what you suggested today :=20

The logic for writing a stripe ( i.e. all the chunks created by the erasu=
re encoding function for a given object or part of a given object if it e=
xceeds the maximum size of a stripe ) for a single object is going to be =
done in a way that is not the same as what we currently have for replicat=
ed objects. The object is consistent when all chunks ( or at least K if K=
+M ) are committed to disk. It may make sense to start writing all the ch=
unks in parallel and when they are acknowledged, send a pg_log event that=
 says : now switch to this new version of the object. To avoid ending up =
with chunks that are partially for one version of the object and other ch=
unks partially for another version of the object and we can't repair any =
of them.=20

I will try to sketch the path for implementing the erasure coding ( inclu=
ding the above ) by adding to https://github.com/dachary/ceph/blob/wip-49=
29/doc/dev/osd_internals/erasure-code.rst

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig2F30CE10BD517907ADBAC444
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHJ1l8ACgkQ8dLMyEl6F211MwCfReevZwwvtudYb+CE6aTn9V2Y
g3wAoKBRHrEd6cwW/q8ZjF8XjzV0s26D
=70LH
-----END PGP SIGNATURE-----

--------------enig2F30CE10BD517907ADBAC444--
