From: Loic Dachary <loic@dachary.org>
Subject: Enabling contributors to run teuthology suites
Date: Mon, 24 Aug 2015 13:51:47 +0200
Message-ID: <55DB0553.90406@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WJ4vuEFOEjos8qwo6gtN5r81XtlL9J1pN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42810 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754087AbbHXLvu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 07:51:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WJ4vuEFOEjos8qwo6gtN5r81XtlL9J1pN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Maybe we can start an experiment to enable contributors to run their own =
teuthology suites. It would go like this:

* Send an OpenStack credential file to the author of a pull request
* Ask her/him to follow the instructions at https://github.com/dachary/te=
uthology/tree/openstack#openstack-backend to verify it works
* Ask her/him to run and debug a specific suite by providing the command =
line such as

   teuthology-openstack --key-name myself --key-filename ~/Downloads/myse=
lf --suite ceph-disk --suite-branch wip-11881-multipath --filter=3Dubuntu=
_14.04 --ceph wip-11881-multipath

We don't yet have a long term solution to fund this kind of testing, but =
that's not a blocker. It's cheap enough to setup and I'm willing to spend=
 500 euros per month of my own money for the time being. It's really self=
ish of me : enabling contributors will save me time that's worth more tha=
n 500 euros ;-)

The details of how the first account has been setup are at http://tracker=
=2Eceph.com/projects/ceph/wiki/RunTeuthology

What do you think ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WJ4vuEFOEjos8qwo6gtN5r81XtlL9J1pN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXbBVMACgkQ8dLMyEl6F20H1gCeJlll3tVQSruya3+Hr0l6tAe0
Bw8AnRzFkPg5FGz3bh82onzncH27w8e+
=tJhL
-----END PGP SIGNATURE-----

--WJ4vuEFOEjos8qwo6gtN5r81XtlL9J1pN--
