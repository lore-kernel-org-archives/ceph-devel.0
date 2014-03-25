From: Loic Dachary <loic@dachary.org>
Subject: Re: GCC -msse2 portability question
Date: Tue, 25 Mar 2014 20:21:28 +0100
Message-ID: <5331D738.9030409@dachary.org>
References: <532F3B0E.2050204@dachary.org>	<5331D41B.5040001@dachary.org> <CA+AFVBhpOZEPehsd4qHCBr4aRzv60ZW8LzRwKsduUrZmLV1wxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mLo40Kooa6VetcktTkXwREuosTUGK36fw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:54145 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbaCYTVh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 15:21:37 -0400
In-Reply-To: <CA+AFVBhpOZEPehsd4qHCBr4aRzv60ZW8LzRwKsduUrZmLV1wxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Laurent Guerby <laurent@guerby.net>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mLo40Kooa6VetcktTkXwREuosTUGK36fw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 25/03/2014 20:13, Kevin Greenan wrote:
> +1=20
>=20
> Yeah, that sounds better...  Let's keep this as simple as possible. =20

I'll rework the https://bitbucket.org/jimplank/gf-complete/pull-request/4=
/defer-the-decision-to-use-a-given-sse accordingly.

Would it be sensible to compile with SSE optimizations only if all are av=
ailable ( SSE2, SSSE3, SSE4, SSE4_PCMUL ) and not attempt to distinguish =
betweel SSSE3 being available but not SSE4_PCMUL etc. From what I underst=
and at this point that kind of distinction is going to be difficult to ma=
nage anyway.

Is it too simplistic ?=20

>=20
> -kevin
>=20
>=20
> On Tue, Mar 25, 2014 at 12:08 PM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:
>=20
>     Andreas Peters suggested another approach, which makes sense to me =
: have one plugin with SSE optimizations enabled, another without them an=
d chose at runtime between the two.
>=20
>     What do you think ?
>=20
>     On 23/03/2014 20:50, Loic Dachary wrote:
>     > Hi Laurent,
>     >
>     > In the context of optimizing erasure code functions implemented b=
y Kevin Greenan (cc'ed) and James Plank at https://bitbucket.org/jimplank=
/gf-complete/ we ran accross a question you may have the answer to: can g=
cc -msse2 (or -msse* for that matter ) have a negative impact on the port=
ability of the compiled binary code ?
>     >
>     > In other words, if a code is compiled without -msse* and runs fin=
e on all intel processors it targets, could it be that adding -msse* to t=
he compilation of the same source code generate a binary that would fail =
on some processors ? This is assuming no sse specific functions were used=
 in the source code.
>     >
>     > In gf-complete, all sse specific instructions are carefully prote=
cted to not be run on a CPU that does not support them. The runtime detec=
tion is done by checking CPU id bits ( see https://bitbucket.org/jimplank=
/gf-complete/pull-request/7/probe-intel-sse-features-at-runtime/diff#Lsrc=
/gf_intel.cT28 )
>     >
>     > The corresponding thread is at:
>     >
>     > https://bitbucket.org/jimplank/gf-complete/pull-request/4/defer-t=
he-decision-to-use-a-given-sse/diff#comment-1479296
>     >
>     > Cheers
>     >
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--mLo40Kooa6VetcktTkXwREuosTUGK36fw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMx1zsACgkQ8dLMyEl6F23tYQCglYlY6QYecEYYduK6Ixk55MIm
gXAAn3Z5ZMpmU9uZBLutf8KcByIRiavn
=msud
-----END PGP SIGNATURE-----

--mLo40Kooa6VetcktTkXwREuosTUGK36fw--
