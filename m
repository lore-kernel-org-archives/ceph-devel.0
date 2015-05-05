From: Loic Dachary <loic@dachary.org>
Subject: Configure  dependencies can be the same as make dependencies
Date: Tue, 05 May 2015 10:34:02 +0200
Message-ID: <5548807A.6060103@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pELQCIPWD2Q10xJOhnWfIulXVamCt0NeO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57566 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756782AbbEEIeK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 04:34:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pELQCIPWD2Q10xJOhnWfIulXVamCt0NeO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kefu,

In the context of https://github.com/ceph/ceph/pull/4449 and https://gith=
ub.com/ceph/ceph/pull/4544 I see you're going out of your way to implemen=
t mechanisms that make it possible to require less dependencies when runn=
ing=20

   ./configure

than what is required by

   ./make check

I think the right solution is to require the same set of dependencies, re=
gardless. It can easily be done by running ./install-deps.sh[1].=20

This script is already used in jenkins.ceph.com and saved us from the rec=
urring pain of manually updating the jenkins slaves every time a dependen=
cy was added to either ceph.spec.in or debian/control.=20

Although it is possible to run ./configure with a subset of the dependenc=
ies that are required to run make check, it trades automatic installation=
 of packages for significant manual maintenance. It saves a little disk a=
nd bandwidth every time a dependency is modified in the ceph.spec.in or d=
ebian/control files, which happens a few times a months at most. The work=
 items to manually maintain this difference:

* the set of dependencies that ./configure requires needs to be manually =
maintained, it is not listed anywhere at the moment. It changes less ofte=
n than ceph.spec.in or debian/control but it does change from time to tim=
e
* the configure script has to be engineered to only require dependencies =
(assuming these dependencies are listed somewhere). In other word, every =
time you change the configure script you have to be extra careful to not =
introduce a new dependency, even when it would help implement what you're=
 after in a simpler way.
* the configure script dependencies in the context of CI actually change =
every time you consider using --enable-something because it modifies the =
set of files your tarbal is made of. If the corresponding something is no=
t installed, the configure will likely not do what you want and you'll ha=
ve to add something manually on the CI machine (or use install-deps.sh bu=
t that would defeat the purpose of separating configure dependencies from=
 make dependencies)
* to avoid adding dependencies to configure, it is tempting to forbid fil=
e generation when preparing the tarbal (I'm thinking .8 generation specif=
ically), although it is legitimate for the tarbal generation to involve s=
ome processing and transformation of the sources that require tools to ru=
n
* it is very unlikely a new developer will remember configure dependencie=
s and make dependencies are different and mistakes will be done all the t=
ime, creating needless frustration

Cheers

[1] https://github.com/ceph/ceph/blob/master/install-deps.sh
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--pELQCIPWD2Q10xJOhnWfIulXVamCt0NeO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVIgHoACgkQ8dLMyEl6F214pACfc5ZoZ43ez0GGaRtoaUZwSeNR
VHAAnRFPQMtJwKNxvJTSZHHxh2DoKUuH
=qL5M
-----END PGP SIGNATURE-----

--pELQCIPWD2Q10xJOhnWfIulXVamCt0NeO--
