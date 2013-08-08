From: Loic Dachary <loic@dachary.org>
Subject: github pull requests, comments and rebase
Date: Thu, 08 Aug 2013 12:06:36 +0200
Message-ID: <52036DAC.5040106@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9EEB9617284AF1301552FEFE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:36044 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934100Ab3HHKGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 06:06:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9EEB9617284AF1301552FEFE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

During the discussions about continuous integration at the CDS this week =
( http://youtu.be/cGosx5zD4FM?t=3D1h16m05s ) you mentionned that github w=
as able to keep track of the successive versions of a pull request commit=
, even in the case of a rebase. I just tried the following:

a) comment on commit associated to https://github.com/ceph/ceph/pull/455 =
( both inline and at the end of the commit )
b) Christophe rebased the associated commit against master and git push -=
-force to publish it
c) The original commit  does not show up in https://github.com/ceph/ceph/=
pull/455  and the new commit, result of the rebase, https://github.com/kr=
i5/ceph/commit/051b0c3e15c98714b95fca5cb7838de9614dc8e3 does not display =
my inline comments.

Do you to know a different workflow that would allow rebase and keep trac=
k of the different versions / comments of the pull request ? Something si=
milar to what you have in gerrit with https://review.openstack.org/#/c/22=
708/ for example where you can see and compare the patch sets.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enig9EEB9617284AF1301552FEFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIDba0ACgkQ8dLMyEl6F222EQCcCZ9Knng8yZ1575fWV6pSFPBT
wz0AnjCkv6DzwWvePLVrf70Cran9pSGQ
=j7LI
-----END PGP SIGNATURE-----

--------------enig9EEB9617284AF1301552FEFE--
