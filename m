From: Loic Dachary <loic@dachary.org>
Subject: Re: Intel ISA-L EC plugin
Date: Fri, 04 Jul 2014 00:01:26 +0200
Message-ID: <53B5D2B6.2010406@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4AE748075@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rvf8IgcBqsBwRBXirISjURkcE9G2xaOqX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37308 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753035AbaGCWBd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 18:01:33 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE748075@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvf8IgcBqsBwRBXirISjURkcE9G2xaOqX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 03/07/2014 23:24, Andreas Joachim Peters wrote:> Hi Loic,=20
>=20
> I have chosen after benchmarking to use the LRU cache for the decoding =
matrix. I can cache easily all decoding matrices (worst case scenario) fo=
r configurations up to (10,4) without trashing it. I will restrict the (k=
,m) in case of the vandermonde matrix to the ones which are invertible, f=
or cauchy they are all invertible anyway.
>=20
> I will rebase to your branch wip-7238-lrc then!

Hi Andreas,

=46rom what I read in https://bitbucket.org/jimplank/jerasure/src/21de983=
83350e7c46e5ee329de2a93c696dee67a/src/jerasure.c?at=3Dmaster#cl-167 it lo=
oks like it could benefit from a LRU cache also. Are you going to use htt=
ps://github.com/ceph/ceph/blob/master/src/include/lru.h for this ?

Cheers
>=20
> Cheers Andreas.
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 02 July 2014 20:33
> To: Andreas Joachim Peters; ceph-devel@vger.kernel.org
> Subject: Re: FW: Intel ISA-L EC plugin
>=20
> Hi Andreas,
>=20
> On 02/07/2014 19:54, Andreas Joachim Peters wrote:> Hi Sage & Loic et a=
l ...
>> getting some support from Paul Luse I have finished the refactoring of=
 the EC ISA-L plug-in.
>>
>>
>> The essential ISA-L v 2.10 sources are now part of the source tree and=
 it builds a single shared library which is portable on platforms with va=
rying CPU extensions (SSE2, AVX, AVX2). I tested on various Intel & AMD p=
rocessor types.
>>
>> The build of the plug-in is coupled to the presence of 'yasm' similiar=
 to the crc32c extension in common/ ... (I couldn't build ISA-L on ARM).
>>
>> It supports two encoding matrices Vandermonde & Cauchy. The techniques=
 are called similar to the one used by Loic in Jerasure "reed_sol_van" & =
"cauchy". "cauchy" is the default.
>>
>> Greg Tucker from Intel pointed me to the proper ( and faster ) way of =
decoding if parity chunks are missing.
>=20
> Great !
>=20
>> ??? How do we proceed? I currently rebase against firefly and use its =
API definition or should this be for a later release with Loic's refactor=
ed interface? Shall I make a pull request or shall I hand it over to Loic=
 and he takes care to do the integration including QA etc ...?
>=20
> It would be great if you could rebase against https://github.com/dachar=
y/ceph/tree/wip-7238-lrc. It contains the base class that will help us sh=
are code common to plugins. I hope it will be merged in the next few days=
=2E During the last CDS the remapping of the data chunks has been agreed =
on and the only reason why it is not yet merged is that integration tests=
 must first show it does not break anything and is fully backward compati=
ble.
>=20
> Cheers
>=20
>> ??? I have still an open question on the library optimization for deco=
ding(=3Drepair). If you call decoding for a certain set one needs to do a=
 matrix inversion coupled to the given set. If the payload is like 1M the=
 computation of the decoding matrix does not
>>  play a role. If the payload is 4k it plays a role. Can I assume that =
the plugin will be called concurrently for the same object with the same =
set of chunks or would the plugin be called interleaved for many objects =
with changing chunk configurations? Is the
>>  EC object called single-threaded or by a thread pool? Will backfilll =
use 4k IOs or larger?
>>
>> I would either commit the simple cache mechanism caching the last comp=
uted erasure configuration & corresponding matrix or put an LRU cache for=
 the last computed matrices. I prototyped both, but would stick to the si=
mplest required.
>>
>> Cheers Andreas.
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--rvf8IgcBqsBwRBXirISjURkcE9G2xaOqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO10rYACgkQ8dLMyEl6F21w0ACguCuvK0jm1jSJDZ3VY3VvStVP
534AoKcJ9wApkB/BqfgVfpoW39Ma4fQe
=q15T
-----END PGP SIGNATURE-----

--rvf8IgcBqsBwRBXirISjURkcE9G2xaOqX--
