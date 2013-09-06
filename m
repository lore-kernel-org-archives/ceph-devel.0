From: Loic Dachary <loic@dachary.org>
Subject: teuthology and jenkins
Date: Fri, 06 Sep 2013 15:07:34 +0200
Message-ID: <5229D396.3010601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig81833D0D6D901CDC2702C057"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:55003 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab3IFNRj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Sep 2013 09:17:39 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 1F2ED26395
	for <ceph-devel@vger.kernel.org>; Fri,  6 Sep 2013 15:07:35 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81833D0D6D901CDC2702C057
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I've explored the idea to use jenkins as a remplacement for the queue + a=
rchive mechanism of teuthology. It turns out to be jenkins weak point. As=
 Robert Colins ( who recently wrote a HOWTO on how to replicated the CI i=
nfrastrcture of OpenStack and is confident someone could do the same with=
in a couple of days https://review.openstack.org/#/c/45346/ ) puts it:

"OpenStack uses jenkins for it's core capabilities - running tests in a w=
ork environment, and replaces the scheduler, archiver etc with their own =
to avoid scaking issues with the naive approaches jenkins has".

Robert further suggested that using the OpenStack CI infrastructure would=
 be a good pick for Ceph.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.H



--------------enig81833D0D6D901CDC2702C057
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIp05YACgkQ8dLMyEl6F22vXQCfRHTHhAFSCOFu3M597fw25dL4
RmQAnR9HI9R9Q44DcvXAQ/XZU98SfsBw
=JoQQ
-----END PGP SIGNATURE-----

--------------enig81833D0D6D901CDC2702C057--
