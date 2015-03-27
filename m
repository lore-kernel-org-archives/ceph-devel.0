From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology-suite and priorities
Date: Fri, 27 Mar 2015 09:07:26 +0100
Message-ID: <55150FBE.9070604@dachary.org>
References: <5510211F.3020007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8hL0WHDKkgesDEgklu7r4rK3SOGoUJwAl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37605 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753737AbbC0IHa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 04:07:30 -0400
In-Reply-To: <5510211F.3020007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8hL0WHDKkgesDEgklu7r4rK3SOGoUJwAl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I still do not understand what I missed with priorities but I re-schedule=
d

http://pulpito.ceph.com/loic-2015-03-27_09:03:04-rados-giant---basic-mult=
i
http://pulpito.ceph.com/loic-2015-03-27_09:01:25-rados-giant---basic-mult=
i
http://pulpito.ceph.com/loic-2015-03-27_08:40:06-rgw-giant---basic-multi

with priority 1000. Let see if it runs before the nightlies again or if i=
t behaves ;-)

Cheers

On 23/03/2015 15:20, Loic Dachary wrote:
> Hi,
>=20
> When scheduling suites that are low priority (giant for instance at htt=
p://pulpito.ceph.com/loic-2015-03-23_01:09:31-rados-giant---basic-multi/)=
, the --priority 1000 is set because (if I remember correctly) this is th=
e standard priority for nightlies. However, it seems to be different beca=
use this morning the giant suite was running although a hammer suite was =
scheduled before it (for instance http://pulpito.ceph.com/teuthology-2015=
-03-22_23:18:01-multimds-hammer-testing-basic-multi/) and was still waiti=
ng.
>=20
> The giant suite was killed so that it does not interfere with more urge=
nt jobs. Looking at the teuthology jobs there does not seem to be a trace=
 of the priority, probably stored elsewhere.=20
>=20
> I would be very grateful if you could explain how priorities should be =
used.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8hL0WHDKkgesDEgklu7r4rK3SOGoUJwAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEUEARECAAYFAlUVD74ACgkQ8dLMyEl6F20RsQCgkDbw8aFBY8cWxszUaMLIidR3
4LcAmPnj4BU8Rd1174oLDrus/5k584Q=
=1Ar0
-----END PGP SIGNATURE-----

--8hL0WHDKkgesDEgklu7r4rK3SOGoUJwAl--
