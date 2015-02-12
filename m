From: Loic Dachary <loic@dachary.org>
Subject: Re: SHEC updates to the erasure code non regression corpus
Date: Thu, 12 Feb 2015 10:21:42 +0100
Message-ID: <54DC70A6.5040108@dachary.org>
References: <54DB4AEC.6000507@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA6C7F5@g01jpexmbyt24> <54DC6ED7.8020900@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FDFKOdveAhe647O9RaAI3EU8DJ9KoRacS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43035 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753387AbbBLJVp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 04:21:45 -0500
In-Reply-To: <54DC6ED7.8020900@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FDFKOdveAhe647O9RaAI3EU8DJ9KoRacS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Please ignore this mail, I confused the two threads and you already answe=
red with https://github.com/ceph/ceph/pull/3716. Great :-)

On 12/02/2015 10:13, Loic Dachary wrote:
> Hi,
>=20
> It turned out to be a problem with tests and uninitialized memory which=
 I was able to fix with
>=20
> https://github.com/ceph/ceph/commit/1a9d717d1661e1e9c9eda3749b7d9c8882a=
995d2
>=20
> What surprises me is that we did not catch that before. If I remember c=
orrectly we ran valgrind and it was clean. Would you have time to review =
the tests once more to see if you can maybe catch another minor problem ?=

>=20
> Cheers
>=20
> On 12/02/2015 09:43, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>>> I would be grateful if you could verify that it works as intended.
>>
>> We have tried create and check actions once for each. It seems it work=
s well.
>> Is that enough for your job?
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.k=
ernel.org] On Behalf Of Loic Dachary
>> Sent: Wednesday, February 11, 2015 9:28 PM
>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>> Cc: Ceph Development
>> Subject: SHEC updates to the erasure code non regression corpus
>>
>> Hi,
>>
>> I've updated the erasure code corpus that verifies the encoding of era=
sure coded chunks do not change over time with a version that includes th=
e SHEC erasure code plugin.
>>
>> https://github.com/ceph/ceph-erasure-code-corpus/commit/498b0102955b74=
7813182734e13e75195f2a02a9
>>
>> From now on it will run each time someone does "make check", but only =
if the sources are after
>>
>> $ git rev-parse v0.92-988-g7df0556
>> 7df0556210be3afdc02e2ca41b3a3b60569b753a
>>
>> I would be grateful if you could verify that it works as intended. The=
 process for updating the corpus has been documented at https://github.co=
m/ceph/ceph-erasure-code-corpus#ceph-erasure-code-corpus : it was difficu=
lt to guess how it works ;-)
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--FDFKOdveAhe647O9RaAI3EU8DJ9KoRacS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTccKYACgkQ8dLMyEl6F20uIQCeMQLJ1rlvHB/mdw9rj0MAwp+R
tWMAoJ7fFae8jLdHnsPFd1RSgfxKqpFD
=8caP
-----END PGP SIGNATURE-----

--FDFKOdveAhe647O9RaAI3EU8DJ9KoRacS--
