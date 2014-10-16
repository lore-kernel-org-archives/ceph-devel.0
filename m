From: Loic Dachary <loic@dachary.org>
Subject: vstart.sh crashes MON with --paxos-propose-interval=0.01 and one
 MDS
Date: Thu, 16 Oct 2014 15:52:47 -0700
Message-ID: <54404C3F.4030904@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6Svc9602uRtXAwBQbCEa8QstCbABg4lCo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47054 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752553AbaJPWwz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 18:52:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Svc9602uRtXAwBQbCEa8QstCbABg4lCo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi John,

I would be gratefull if you could take a quick look at http://tracker.cep=
h.com/issues/9794 . It is bisected to the reduction of pg and I'm able to=
 reproduce it in a ubuntu-14.04 docker fresh install. For some reason it =
does not happen in gitbuilder but I think you can reproduce it locally no=
w.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--6Svc9602uRtXAwBQbCEa8QstCbABg4lCo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRATD8ACgkQ8dLMyEl6F20RcQCgqPDU5n6D7kc/tQz4CRrJlDLl
m70AoJz3fW/H/uImrT5mbHdPNusIQKhf
=pFZA
-----END PGP SIGNATURE-----

--6Svc9602uRtXAwBQbCEa8QstCbABg4lCo--
