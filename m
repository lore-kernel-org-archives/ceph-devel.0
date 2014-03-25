From: Loic Dachary <loic@dachary.org>
Subject: Re: GCC -msse2 portability question
Date: Tue, 25 Mar 2014 20:08:11 +0100
Message-ID: <5331D41B.5040001@dachary.org>
References: <532F3B0E.2050204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="N1w2n560iQdHusnFRf7kIF8hJTWs9R1Eq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:54125 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbaCYTIU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 15:08:20 -0400
In-Reply-To: <532F3B0E.2050204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Guerby <laurent@guerby.net>, Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N1w2n560iQdHusnFRf7kIF8hJTWs9R1Eq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andreas Peters suggested another approach, which makes sense to me : have=
 one plugin with SSE optimizations enabled, another without them and chos=
e at runtime between the two.=20

What do you think ?

On 23/03/2014 20:50, Loic Dachary wrote:
> Hi Laurent,
>=20
> In the context of optimizing erasure code functions implemented by Kevi=
n Greenan (cc'ed) and James Plank at https://bitbucket.org/jimplank/gf-co=
mplete/ we ran accross a question you may have the answer to: can gcc -ms=
se2 (or -msse* for that matter ) have a negative impact on the portabilit=
y of the compiled binary code ?=20
>=20
> In other words, if a code is compiled without -msse* and runs fine on a=
ll intel processors it targets, could it be that adding -msse* to the com=
pilation of the same source code generate a binary that would fail on som=
e processors ? This is assuming no sse specific functions were used in th=
e source code.
>=20
> In gf-complete, all sse specific instructions are carefully protected t=
o not be run on a CPU that does not support them. The runtime detection i=
s done by checking CPU id bits ( see https://bitbucket.org/jimplank/gf-co=
mplete/pull-request/7/probe-intel-sse-features-at-runtime/diff#Lsrc/gf_in=
tel.cT28 )
>=20
> The corresponding thread is at:
>=20
> https://bitbucket.org/jimplank/gf-complete/pull-request/4/defer-the-dec=
ision-to-use-a-given-sse/diff#comment-1479296
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--N1w2n560iQdHusnFRf7kIF8hJTWs9R1Eq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMx1B4ACgkQ8dLMyEl6F23edACgvPq0KsrD8FPli0hanOAcjf20
8PkAn286OBn3h1+MhX1v7QJlPbcsfUpg
=Yu6B
-----END PGP SIGNATURE-----

--N1w2n560iQdHusnFRf7kIF8hJTWs9R1Eq--
