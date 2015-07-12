From: Loic Dachary <loic@dachary.org>
Subject: New member in the stable releases team
Date: Sun, 12 Jul 2015 13:48:30 +0200
Message-ID: <55A2540E.8090604@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TCldXsAxC9gDt0c9eLFIJOA1nkWWtmGC4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48755 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751131AbbGLLsd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jul 2015 07:48:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, David Casier <david.casier@aevoo.fr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TCldXsAxC9gDt0c9eLFIJOA1nkWWtmGC4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan & Abhishek,

Let me introduce you to David Casier who agreed to help us with the stabl=
e releases by running the hammer upgrade suite for Ubuntu 14.04 on his te=
uthology setup at http://ceph.aevoo.fr:8081/ (using the OpenStack / teuth=
ology installation run by his company).

The idea we discussed this morning is that David will watch the hammer br=
anch and run the upgrade suite whenever there is a new commit. I suppose =
he could also run the suite on hammer-backports when it is needed. This i=
s the first time someone is committed to help by running teuthology suite=
s, we'll need to figure out the details as we go.

Although this is a small part of the stable release workflow, this is a n=
ovel way of contributing and I'm glad it's happening. It also made me rea=
lize that there is no place where the roles of each member of the stable =
release team is listed. I've added a who's who section at:

    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Whos-who

which reflects my view of the roles we have. Although it requires a littl=
e maintenance, the roles do not vary that much and I expect it won't requ=
ire an update more than a dozen time a year.=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--TCldXsAxC9gDt0c9eLFIJOA1nkWWtmGC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWiVA4ACgkQ8dLMyEl6F217oACfUlCnsRLfmTfhA8RjFZp6EHls
X7EAoMRL4q0sfL2dgkmzrUPJc2FDBZHO
=9Abz
-----END PGP SIGNATURE-----

--TCldXsAxC9gDt0c9eLFIJOA1nkWWtmGC4--
