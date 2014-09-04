From: Loic Dachary <loic@dachary.org>
Subject: Re: ARM NEON optimisations for gf-complete/jerasure/ceph-erasure
Date: Thu, 04 Sep 2014 17:57:55 +0200
Message-ID: <54088C03.10900@dachary.org>
References: <20140904144237.GK2591@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3rHQDlmc0DPkjVU588Fj719PRONk1UPW9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44953 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751183AbaIDP6D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Sep 2014 11:58:03 -0400
In-Reply-To: <20140904144237.GK2591@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3rHQDlmc0DPkjVU588Fj719PRONk1UPW9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Janne,

On 04/09/2014 16:42, Janne Grunau wrote:
> Hi,
>=20
> I've started writing ARM/AArch64 NEON optimizations for gf-complete. =20
> http://git.jannau.net/gf-complete.git/log/?h=3Dneon has proof of concep=
t=20
> AArch64 NEON optimisations for w8.
>=20
> Implemented methods are so far the carry-less/polynomial multiplication=
=20
> and the split table. The polynomial multiplication is reasonable fast=20
> for region multiplications (~2000MB/s on an Apple A7 at 1.3GHz) since=20
> NEON has a 8-bit to 16-bit SIMD polynomial multiplication.
>=20
> The split table method is still faster though, 5700MB/s on the same CPU=
=2E =20
> I'm actually surprised by that since it is faster (per cycle) than the =

> Core i7-3770 from gf-complete's manual (page 14). That suggests that=20
> SSE3 code might not be optimal.
>=20
> I'm currently working on integrating NEON into the build system and the=
n=20
> will extend the existing code to work on ARMv7-a too. Those two are=20
> straight forward. There are a couple of other issues I would like to=20
> discuss before I start to work on them.
>=20
> The #if/#ifdefs in the source are starting to make the source hard to=20
> read then more than one optimization is added. Separating arch specific=

> implementations from each other and from the generic implementation=20
> works reasonable well for the multimedia related projects I have=20
> experience with (libav/FFmpeg, x264). There would be arch specific init=
=20
> functions which set the appropriate function pointers. The neon=20
> optimisations would then live in w8_arm.c which would be only compiled =

> for arm. If someone has another idea how to avoid the #ifdefs I'm open =

> for that too.

Would it be possible to make use of ifunc ( https://gcc.gnu.org/onlinedoc=
s/gcc-4.7.2/gcc/Function-Attributes.html#index-g_t_0040code_007bifunc_007=
d-attribute-2529 ) to chose the function depending on CPU features ?

http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#=
i386-and-x86-64-Options

http://www.spinics.net/lists/ceph-devel/msg18452.html

Cheers

> I'm currently using the SSE/NOSSE region option which is bogus. I'm=20
> wondering whether I should just rename that SIMD/NOSIMD (not really tru=
e=20
> since the carry less operations for w64 and w128 only use the SIMD=20
> instruction set but are single data). That would need to have backward =

> compatibility for SSE/NOSSE. The other option would be to add=20
> NEON/NONEON flags.
>=20
> I'm sure I find other issues to discuss when I start integrating the=20
> NEON optimisations into jerasure and ceph.
>=20
> thanks
>=20
> Janne
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--3rHQDlmc0DPkjVU588Fj719PRONk1UPW9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQIjAMACgkQ8dLMyEl6F22ouQCeJQSiJri7Y+d1rN874/z1tOEP
+hAAn3A8py+wO3EUtir5ICNrpNoRW7z7
=APFy
-----END PGP SIGNATURE-----

--3rHQDlmc0DPkjVU588Fj719PRONk1UPW9--
