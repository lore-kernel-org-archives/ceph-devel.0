From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-ci.git?
Date: Mon, 18 May 2015 19:10:59 +0200
Message-ID: <555A1D23.9090402@dachary.org>
References: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net> <55599E24.6040208@dachary.org> <555A135F.301@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pSuwWRnuv5K01wCqdieoijgATLIFCedRr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37235 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751206AbbERRLF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2015 13:11:05 -0400
In-Reply-To: <555A135F.301@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pSuwWRnuv5K01wCqdieoijgATLIFCedRr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/05/2015 18:29, John Spray wrote:>=20
>=20
> On 18/05/2015 09:09, Loic Dachary wrote:
>> One problem with promoting http://github.com/ceph/ceph to that role is=
 that while the migration is in progress there will be two queues of pull=
 requests, the new one at http://github.com/ceph-ci/ceph and the old one =
at http://github.com/ceph/ceph. Given our current flow of pull requests t=
he migration will probably take about three months. And after that, since=
 it's not possible to forbid pull requests on github.com (you can disable=
 issues but not pull requests on a given repository) there will forever b=
e a flow of misdirected pull requests against the old repository.
> If I understand correctly, this is not an issue as pull requests would =
still be against the original ceph repository.  The ceph-ci repository wo=
uld be where people could push their branches directly to have them built=
, and then they could create a PR to the ceph repository (either from the=
ir branch on ceph-ci or their original branch in their own github repo).
>=20
> So my workflow as a developer would be to write some code locally, push=
 my branch to /jcsp/ceph to "save" it, push it to /ceph/ceph-ci to have t=
he gitbuilders pick it up and build it, and then ultimately make a PR to =
/ceph/ceph to merge it.
>=20
> Apologies in advance for muddying the water if I've got any of that wro=
ng :-)

I think you got it right, I misunderstood the original proposal.=20

+1 on the original proposal then. It's less work than having a ceph-relea=
se repository. Sorry for the noise :-)

>=20
> Cheers,
> John

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--pSuwWRnuv5K01wCqdieoijgATLIFCedRr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVaHSMACgkQ8dLMyEl6F21qqACfQByJZFFAf4Jh9Ny2Os+89hO6
Aq4AnisSq2nonfFUQa4eLJGYNxJ0Ao/0
=G/Ju
-----END PGP SIGNATURE-----

--pSuwWRnuv5K01wCqdieoijgATLIFCedRr--
