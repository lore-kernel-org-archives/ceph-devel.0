From: Loic Dachary <loic@dachary.org>
Subject: Re: BlaumRoth with w=7 : what are the consequences ?
Date: Thu, 25 Sep 2014 01:06:08 +0200
Message-ID: <54234E60.9070108@dachary.org>
References: <5422F67B.3000302@dachary.org> <CA+AFVBjuLm2DeexTMO0xNB7CekGkPbVyzGVso2BqtdE4VFHw=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tepm9nAV6hmmD3j6fpwE0Lku7jjXwGHXK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59356 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914AbaIXXGL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Sep 2014 19:06:11 -0400
In-Reply-To: <CA+AFVBjuLm2DeexTMO0xNB7CekGkPbVyzGVso2BqtdE4VFHw=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tepm9nAV6hmmD3j6fpwE0Lku7jjXwGHXK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On 24/09/2014 20:40, Kevin Greenan wrote:> The constraint guarantees the =
MDS property.  I believe there are conditions where w+1 is composite and =
you still have an MDS code, but there are restrictions on 'n' (codeword l=
ength).  So, you may have chosen the right parameters.  Did you verify al=
l possible combinations of erasures is tolerated?

I tried all combinations that are likely to have been used and they all w=
ork out. Here is the script I used:

for w in 7 11 13 17 19 ; do for k in $(seq 2 $w) ; do for m in $(seq 1 $k=
) ; do for erasures in $(seq 1 $m) ; do ./ceph_erasure_code_benchmark --p=
lugin jerasure --workload decoded --iterations 1 --size 4096 --erasures $=
erasures --parameter w=3D$w --parameter k=3D$k --parameter m=3D2 --parame=
ter technique=3Dblaum_roth ; done ; done ; done ; done

does that mean we're safe despite the fact that w+1 is not prime in all s=
ettings ?=20

> For sake of safety, you probably do not want to get experimental with '=
production' code.  IMHO, you should put the check in, especially if 'n' i=
s tunable.

n is tunable and the check is now enforced. I'm worried about the content=
 that was previously encoded with codeword length that do not match prime=
(codeword + 1)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tepm9nAV6hmmD3j6fpwE0Lku7jjXwGHXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQjTmAACgkQ8dLMyEl6F21vcgCgwv5zAEF/HLa5kAfF01yi2rxI
aP8AoMHhjO9Erz1kyDWG8B4Yitw2D5WI
=tJks
-----END PGP SIGNATURE-----

--tepm9nAV6hmmD3j6fpwE0Lku7jjXwGHXK--
