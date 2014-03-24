From: Loic Dachary <loic@dachary.org>
Subject: Re: GCC -msse2 portability question
Date: Mon, 24 Mar 2014 22:27:04 +0100
Message-ID: <5330A328.9060203@dachary.org>
References: <532F3B0E.2050204@dachary.org> <1395614070.15058.140.camel@pc2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8ClIcGH1dUC1scf1hCkqdctisE1Tt4bkk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:53139 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaCXV1K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Mar 2014 17:27:10 -0400
In-Reply-To: <1395614070.15058.140.camel@pc2>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent GUERBY <laurent@guerby.net>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8ClIcGH1dUC1scf1hCkqdctisE1Tt4bkk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 23/03/2014 23:34, Laurent GUERBY wrote:
> On Sun, 2014-03-23 at 20:50 +0100, Loic Dachary wrote:
>> Hi Laurent,
>>
>> In the context of optimizing erasure code functions implemented by
>> Kevin Greenan (cc'ed) and James Plank at
>> https://bitbucket.org/jimplank/gf-complete/ we ran accross a question
>> you may have the answer to: can gcc -msse2 (or -msse* for that matter
>> ) have a negative impact on the portability of the compiled binary
>> code ?=20
>>
>> In other words, if a code is compiled without -msse* and runs fine on
>> all intel processors it targets, could it be that adding -msse* to the=

>> compilation of the same source code generate a binary that would fail
>> on some processors ? This is assuming no sse specific functions were
>> used in the source code.
>>
>> In gf-complete, all sse specific instructions are carefully protected
>> to not be run on a CPU that does not support them. The runtime
>> detection is done by checking CPU id bits ( see
>> https://bitbucket.org/jimplank/gf-complete/pull-request/7/probe-intel-=
sse-features-at-runtime/diff#Lsrc/gf_intel.cT28 )
>>
>> The corresponding thread is at:
>>
>> https://bitbucket.org/jimplank/gf-complete/pull-request/4/defer-the-de=
cision-to-use-a-given-sse/diff#comment-1479296
>>
>> Cheers
>>
>=20
> Hi Loic,
>=20
> The GCC documentation is here with lists of architecture supporting
> sse/sse2:
>=20
> http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.htm=
l#i386-and-x86-64-Options
>=20
> So unless you want to run your code a very very old x86 32 bit processo=
r
> "-msse" shouldn't be an issue. "-msse2" is similar.

This is good to know :) Should I be worried about unintended side effects=
 of -msse4.2 -mssse3 -msse4.1 or -mpclmul ? These are the flags that gf-c=
omplete are using, specifically.

Cheers

>=20
> -mtune=3Dxxx with xxx being a recent arch could be interesting for you
> because it keeps compatibility with the generic arch while tuning
> resulting code on the specific arch (for example the current fashionabl=
e
> arch like corei7).
>=20
> For alibrary you can choose the code you execute a load/run time
> for a specific function by using the STT_GNU_IFUNC feature :
>=20
> http://vger.kernel.org/~davem/cgi-bin/blog.cgi/2010/02/07
> http://gcc.gnu.org/onlinedocs/gcc-4.7.2/gcc/Function-Attributes.html#in=
dex-g_t_0040code_007bifunc_007d-attribute-2529
>=20
> I believe recent GLIBC use this feature to tune
> some performance/arch sensitive functions.
>=20
> Sincerely,
>=20
> Laurent
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8ClIcGH1dUC1scf1hCkqdctisE1Tt4bkk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMwoysACgkQ8dLMyEl6F233kwCdF7yGUYeP+5k4wj1/iV2M1b/l
rSoAn0hJtqhCIuqB82Khkgac5TsXbZqq
=eXtR
-----END PGP SIGNATURE-----

--8ClIcGH1dUC1scf1hCkqdctisE1Tt4bkk--
