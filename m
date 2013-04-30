From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: fecpp C++ forward error correction library
Date: Mon, 29 Apr 2013 17:08:18 -0700
Message-ID: <DA7579B5-A82E-431B-99A0-89C4EE58A87E@asgaard.org>
References: <517538D7.6050706@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_77274BC4-943E-4239-9AC4-F191206C4497_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.emailarray.com ([69.28.212.198]:39905 "EHLO
	smtp2.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697Ab3D3AIW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 20:08:22 -0400
In-Reply-To: <517538D7.6050706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jack Lloyd <lloyd@randombit.net>

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_77274BC4-943E-4239-9AC4-F191206C4497_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-22, at 06.19 PDT(-0700), someone claiming to be L=
oic Dachary scribed:

> Hi Christopher,
>
> Jack Lloyd is the author of fecpp ( http://www.randombit.net/code/fecpp=
/ ) and he tells me someone sent him a new SIMD approach a few weeks ago.=
 I'm not sure what SIMD means yet, but I'll figure it out ;-). I tend to =
favor fecpp because it is more self contained and may be easier to embed =
than https://pypi.python.org/pypi/zfec

I'll defer, provided that we don't incur a performance penalty (which is =
one of the negatives in sharding).  As far as SIMD: Single Instruction Mu=
ltiple Data.  Basically, if you think of a tiled processor (like a GPU), =
then you set all the tiles to do the same instruction, and stream differe=
nt data to each tile.  As opposed to MIMD, where each tile runs a differe=
nt instruction on different data.   You don't need parallel processing CP=
Us to make use of SIMD, but you can get them going screamingly fast if yo=
u do=E2=80=A6

	Christopher

>
> Cheers
>
> -- =

> Lo=C3=AFc Dachary, Artisan Logiciel Libre


--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: http://www.asgaard.org/cdl/cdl.asc
Current vCard here: http://www.asgaard.org/cdl/cdl.vcf
--=_MailMate_77274BC4-943E-4239-9AC4-F191206C4497_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRfwtyAAoJEGmx2Mt/+Iw/eyIH/2u0v7dHtyoWjar07zA+zzmQ
xHiJIVI00j7zVuW+WFj0AOEDyeMCmu6IA/+JY5Ad8INwCAd+CSPazk8lEx66rCiX
hbWfX3+FjX95YpVWHf6u26euM8V8rHgkMx25hpMOGrwQM5LTYj3mmKvT9DUhS3LM
PS9lv7QhivBlQIdhCpJFmYJeaGfL1vUJTo7tab8p29cLNRXxgW0UILalTvvhjm9e
ZSQ9zfAguZmoqSJgJA8RJ49oaZc+0C+SzZD0V1gRvi0XWEOh/GlEv3yfyvfZ5Cex
R6pI/rqrvIK6TD6skqVu5e8lltko30nuMyLkGyPcaCL/CqYLLK4Ty2F4sZCNJu0=
=NrVt
-----END PGP SIGNATURE-----

--=_MailMate_77274BC4-943E-4239-9AC4-F191206C4497_=--
