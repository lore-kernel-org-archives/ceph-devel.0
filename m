From: Loic Dachary <loic@dachary.org>
Subject: CentOS 7 yum-builddep fails on %if
Date: Wed, 25 Mar 2015 18:55:37 +0100
Message-ID: <5512F699.3000206@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dAHU4nDLuUmjoS8CEeljFKe7HlvIl3JJo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36578 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932548AbbCYRzm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Mar 2015 13:55:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dAHU4nDLuUmjoS8CEeljFKe7HlvIl3JJo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

yum-builddep fails on CentOS 7 on the latest ceph.spec.in with the follow=
ing error:

error: parse error in expression
error: /tmp/install-deps.52/ceph.spec:50: bad %if condition
Bad spec: /tmp/install-deps.52/ceph.spec

which is

%if 0%{_with_systemd}

https://github.com/ceph/ceph/blob/master/ceph.spec.in#L50

It looks good to me though. Any idea why it happens ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--dAHU4nDLuUmjoS8CEeljFKe7HlvIl3JJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUS9pkACgkQ8dLMyEl6F20SOgCcCZhYjBA41EDsX45bDJzkf1+D
fkAAoKzS4MVzvnLbW0v2VQUktjHX+6gQ
=zI4A
-----END PGP SIGNATURE-----

--dAHU4nDLuUmjoS8CEeljFKe7HlvIl3JJo--
