From: Loic Dachary <loic@dachary.org>
Subject: Re: GCC -msse2 portability question
Date: Tue, 25 Mar 2014 10:56:57 +0100
Message-ID: <533152E9.50709@dachary.org>
References: <532F3B0E.2050204@dachary.org> <1395614070.15058.140.camel@pc2>	 <5330A328.9060203@dachary.org> <1395740605.15058.205.camel@pc2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7kUwepMu15IVqbx7pu1wXM6dhJPgTvQR5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:53554 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbaCYJ56 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 05:57:58 -0400
In-Reply-To: <1395740605.15058.205.camel@pc2>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent GUERBY <laurent@guerby.net>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7kUwepMu15IVqbx7pu1wXM6dhJPgTvQR5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

It occurs to me that all we're after is to enable SSE functions such as _=
mm_set_epi32. We're not trying to have the binary optimized in any implic=
it way, it is all explicit. The problem seems to be that -msse4.2 will do=
 both=20

* activate _mm_set_epi32 etc functions=20
* optimize the binary to use sse4.2 instructions

Do you know of a compiler flag that would only=20

* activate _mm_set_epi32 etc functions=20

and not

* optimize the binary to use sse4.2 instructions

? It may be a RTFM question and I apologize for that. Reading http://gcc.=
gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#i386-and-x8=
6-64-Options it looks like this is more or less what --mtune=3Dcorei7-avx=
 would do (because gf-complete uses PCLMUL when available). But it feels =
weird to specify a specific processor model where what we need is a set o=
f features.=20

Thanks for your help :-)

On 25/03/2014 10:43, Laurent GUERBY wrote:
> On Mon, 2014-03-24 at 22:27 +0100, Loic Dachary wrote:
>>
>> On 23/03/2014 23:34, Laurent GUERBY wrote:
>>> http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.h=
tml#i386-and-x86-64-Options
>>>
>>> So unless you want to run your code a very very old x86 32 bit proces=
sor
>>> "-msse" shouldn't be an issue. "-msse2" is similar.
>>
>> This is good to know :) Should I be worried about unintended side effe=
cts of -msse4.2 -mssse3 -msse4.1 or -mpclmul ? These are the flags that g=
f-complete are using, specifically.
>=20
> Hi,
>=20
> SSE4.2 will be available only in more recent
> processors as documented on the page above.
>=20
> If your library already is dynamically checking for processor
> feature I would advise to be conservative in your
> -m flags, ie using what debian would use for maximum
> x86 portability.
>=20
> Sincerely,
>=20
> Laurent
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7kUwepMu15IVqbx7pu1wXM6dhJPgTvQR5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMxUuwACgkQ8dLMyEl6F20UzwCfRZ2ns6f6VZZ3MtHtUCTEciNO
4OwAn29NQ0QSFwuncm7n3RwAlrcUv5Pz
=m7BN
-----END PGP SIGNATURE-----

--7kUwepMu15IVqbx7pu1wXM6dhJPgTvQR5--
