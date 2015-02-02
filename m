From: Loic Dachary <loic@dachary.org>
Subject: Re: gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP - failure
Date: Mon, 02 Feb 2015 22:47:35 +0100
Message-ID: <54CFF077.9020208@dachary.org>
References: <54B16763.7070602@dachary.org> <20150202211457.GK2734@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vQfU9l83j0vCJN5RbnsP8tKh2puTDf1so"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51507 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753697AbbBBVri (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 16:47:38 -0500
In-Reply-To: <20150202211457.GK2734@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vQfU9l83j0vCJN5RbnsP8tKh2puTDf1so
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/02/2015 22:14, Janne Grunau wrote:
> On 2015-01-10 18:54:43 +0100, Loic Dachary wrote:
>> Hi Kevin & Janne,
>>
>> The test gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP - fails on the curren=
t gf-complete master. The first commit where it fails is
>>
>> commit 474010a91d35fef5ca7dea77205b6a5c7e68c3e9
>> Author: Janne Grunau <j@jannau.net>
>> Date:   Wed Sep 17 16:10:25 2014 +0200
>>
>>     arm: NEON optimisations for gf_w16
>>
>>     Optimisations for the 4,16 split table region multiplications.
>>
>>     Selected time_tool.sh 16 -A -B results for a 1.7 GHz cortex-a9:
>>     Region Best (MB/s):   532.14   W-Method: 16 -m SPLIT 16 4 -r SIMD =
-
>>     Region Best (MB/s):   212.34   W-Method: 16 -m SPLIT 16 4 -r NOSIM=
D -
>>     Region Best (MB/s):   801.36   W-Method: 16 -m SPLIT 16 4 -r SIMD =
-r ALTMAP -
>>     Region Best (MB/s):    93.20   W-Method: 16 -m SPLIT 16 4 -r NOSIM=
D -r ALTMAP -
>>     Region Best (MB/s):   273.99   W-Method: 16 -m SPLIT 16 8 -
>>     Region Best (MB/s):   270.81   W-Method: 16 -m SPLIT 8 8 -
>>     Region Best (MB/s):    70.42   W-Method: 16 -m COMPOSITE 2 - -
>>     Region Best (MB/s):   393.54   W-Method: 16 -m COMPOSITE 2 - -r AL=
TMAP -
>>
>> but the test did exit(0) on error instead of exit(1) and we failed to =
notice.
>>
>> gf_unit 16 A -1 -m SPLIT 16 4 -r ALTMAP -
>> Args: 16 A -1 -m SPLIT 16 4 -r ALTMAP - / size (bytes): 524428
>> Problem with region multiply (all values in hex):
>>    Target address base: 0x8fd08e.  Word 0x1 of 0x1fee.  Xor: 0
>>    Value: 2
>>    Original source word: d00a
>>    Product word: a000
>>    It should be: b01f
>>
>> Do you have an idea why this happens ? For the record here is the bise=
ct command I used:
>=20
> yes, it happens because the arm code is incomplete and bogus. I did the=
=20
> arm64 code first and then ported it to arm. This function uses arm64=20
> specific instructions and thus needed a port to arm. The arm version=20
> misses several computation steps. I guess I trusted the results of the
> unit tests and didn't looked at gf_unit output on arm.
>=20
> I'll send a fix tomorrow.

That's a relief :-)

Thanks !

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


--vQfU9l83j0vCJN5RbnsP8tKh2puTDf1so
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTP8HcACgkQ8dLMyEl6F20amACgwM3tSjBjiTxxgBxlO1uBjPa9
gK8AmgNcGem4HhmU0HbMJrfSIR6vfEl2
=bfM6
-----END PGP SIGNATURE-----

--vQfU9l83j0vCJN5RbnsP8tKh2puTDf1so--
