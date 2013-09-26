From: Loic Dachary <loic@dachary.org>
Subject: Weekly teuthology meeting #2
Date: Thu, 26 Sep 2013 20:45:13 +0200
Message-ID: <524480B9.8080104@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7609CB7C2DDB1F5565EB1675"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46504 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab3IZSpZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 14:45:25 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id AF02526394
	for <ceph-devel@vger.kernel.org>; Thu, 26 Sep 2013 20:45:19 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7609CB7C2DDB1F5565EB1675
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Today 8pm paris time / CEST was the second teuthology meeting. The genera=
l idea of these meetings is to get together developers using teuthology (=
 or willing to use teuthology ) outside of Inktank and people using it in=
side inktank. The goal is to help transition from an internal tool to som=
ething that's installable and upgradeable by any Ceph developer.=20

The next meeting will be held 8pm paris time / CEST october 3rd, 2013. Th=
e IRC channel is irc.oftc.net#ceph-devel and the conference room is mumbl=
e.upstream-university.org ( http://www.mumble.com/mumble-download.php ). =
It is timeboxed to one hour.

I don't commit to write transcripts of these meetings but here is an idea=
 that was discussed today:

  A teuthology installation is setup on machines that can be
  accessed by external people. Inktank publishes the ssh public key of
  trusted ceph developers. These keys are injected in the teuthology
  machines. When a test fails ( could be a very long running test ),
  the bug report filed on tracker.ceph.com mentions the teuthology
  host to which a developer could connect to get more information from
  the live system. An example would be the problem Mike is facing
  where it appears that RBD with lots of writes and almost no reads resul=
ts
  in fragmentation over a period of days. Difficult to describe and
  even more difficult to reproduce from what can be included in the
  description of an issue. Probably much easier to create a YAML
  scenario and let a few machines online for a few weeks that exhibit
  the problem for Ceph developers to examine.=20


Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.





--------------enig7609CB7C2DDB1F5565EB1675
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlJEgL8ACgkQ8dLMyEl6F212hQCeLA/CqqVAHeLNxwZWhktU6AFb
T6QAoJgCyyifS+QsNsdnkIJ/VISQqkTD
=k0rg
-----END PGP SIGNATURE-----

--------------enig7609CB7C2DDB1F5565EB1675--
