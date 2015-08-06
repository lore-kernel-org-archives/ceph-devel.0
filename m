From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure Code Plugins : PLUGINS_V3 feature
Date: Thu, 06 Aug 2015 15:57:58 +0200
Message-ID: <55C367E6.8040902@dachary.org>
References: <55B899FB.4080007@dachary.org> <55C1C789.3050401@dachary.org> <alpine.DEB.2.00.1508051136360.22099@cobra.newdream.net> <870DE8DBB716524BAE51B2D499EC81E40AB68E6A@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2xlxwE3TiIhwFm0u8L6Fm39PCCQ30WSxU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34384 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751780AbbHFN6E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 09:58:04 -0400
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AB68E6A@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2xlxwE3TiIhwFm0u8L6Fm39PCCQ30WSxU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takeshi,

https://github.com/ceph/ceph/pull/5493 is ready for your review. The matc=
hing integration tests can be found at https://github.com/ceph/ceph-qa-su=
ite/pull/523

Cheers

On 06/08/2015 02:28, Miyamae, Takeshi wrote:
> Dear Sage,
>=20
>> note that what this really means is that the on-disk encoding needs to=
 remain fixed.
>=20
> Thank you for letting us know the important notice.
> We have no plan to change shec's format at this moment, but we will rem=
ember the
> comment for any future events.
>=20
> Best Regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]=20
> Sent: Thursday, August 6, 2015 3:45 AM
> To: Loic Dachary; Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Samuel Just; Ceph Development
> Subject: Re: Erasure Code Plugins : PLUGINS_V3 feature
>=20
> On Wed, 5 Aug 2015, Loic Dachary wrote:
>> Hi Sam,
>>
>> How does this proposal sound ? It would be great if that was done=20
>> before the feature freeze.
>=20
> I think it's a good time.
>=20
> Takeshi, note that what this really means is that the on-disk encoding =
needs to remain fixed.  If we decide to change it down the line, we'll ha=
ve to make a 'shec2' or similar so that the old format is still decodable=
 (or ensure that existing data can still be read in some other way).
>=20
> Sound good?
>=20
> sage
>=20
>=20
>>
>> Cheers
>>
>> On 29/07/2015 11:16, Loic Dachary wrote:
>>> Hi Sam,
>>>
>>> The SHEC plugin[0] has been running in the rados runs[1] in the past =
few months. It also has a matching corpus verification which runs on ever=
y make check[2] as well as its optimized variants. I believe the flag "ex=
perimental" can now be removed.=20
>>>
>>> In order to do so, we need to use a PLUGINS_V3 feature, in the same w=
ay we did back in Giant when the ISA and LRC plugins were introduced[3]. =
This won't be necessary in the future, when there is a generic plugin mec=
hanism, but right now that's what we need. It would be a commit very simi=
lar to the one implementing PLUGINS_V2[4].
>>>
>>> Is this agreeable to you ? Or would you rather see another way to res=
olve this ?
>>>
>>> Cheers
>>>
>>> [0] https://github.com/ceph/ceph/tree/master/src/erasure-code/shec
>>> [1]=20
>>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados/thras
>>> h-erasure-code-shec [2]=20
>>> https://github.com/ceph/ceph-erasure-code-corpus/blob/master/v0.92-9
>>> 88/non-regression.sh#L52 [3] http://tracker.ceph.com/issues/9343
>>> [4]=20
>>> https://github.com/ceph/ceph/commit/9687150ceac9cc7e506bc227f430d420
>>> 7a6d7489
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2xlxwE3TiIhwFm0u8L6Fm39PCCQ30WSxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXDZ+cACgkQ8dLMyEl6F23gOgCgj9F6aZnwacvOwZPek/jI3sRR
iEoAoLTL8G9mxOm9VNk5xXGxrQxxqFdy
=Dzvw
-----END PGP SIGNATURE-----

--2xlxwE3TiIhwFm0u8L6Fm39PCCQ30WSxU--
