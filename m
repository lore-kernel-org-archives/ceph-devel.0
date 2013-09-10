From: Loic Dachary <loic@dachary.org>
Subject: Teuthology queuing & archiving (was: teuthology and jenkins)
Date: Tue, 10 Sep 2013 18:32:56 +0200
Message-ID: <522F49B8.6070103@dachary.org>
References: <5229D396.3010601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE80C0CFBCFC48920492DF39"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58953 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab3IJQc7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Sep 2013 12:32:59 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 3BF3D26394
	for <ceph-devel@vger.kernel.org>; Tue, 10 Sep 2013 18:32:57 +0200 (CEST)
In-Reply-To: <5229D396.3010601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE80C0CFBCFC48920492DF39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

In the context of the OpenStack CI, James E. Blair wrote http://git.opens=
tack.org/cgit/openstack-infra/nodepool/tree/ which is described in the No=
depool part of http://amo-probos.org/post/15 It seems a good an minimal c=
andidate to provision machines. I'm on irc.freenode.net#openstack-infra w=
here all these tools are discussed and will try to understand more about =
"gear".

Cheers

On 06/09/2013 15:07, Loic Dachary wrote:
> Hi,
>=20
> I've explored the idea to use jenkins as a remplacement for the queue +=
 archive mechanism of teuthology. It turns out to be jenkins weak point. =
As Robert Colins ( who recently wrote a HOWTO on how to replicated the CI=
 infrastrcture of OpenStack and is confident someone could do the same wi=
thin a couple of days https://review.openstack.org/#/c/45346/ ) puts it:
>=20
> "OpenStack uses jenkins for it's core capabilities - running tests in a=
 work environment, and replaces the scheduler, archiver etc with their ow=
n to avoid scaking issues with the naive approaches jenkins has".
>=20
> Robert further suggested that using the OpenStack CI infrastructure wou=
ld be a good pick for Ceph.
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigFE80C0CFBCFC48920492DF39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIvSbgACgkQ8dLMyEl6F20sxQCbBkCxi4ITUmWY1r7IMuvPqQJw
s5oAoLG1qYLajFfRdaX/gatA1PqCw2n7
=Kwlx
-----END PGP SIGNATURE-----

--------------enigFE80C0CFBCFC48920492DF39--
