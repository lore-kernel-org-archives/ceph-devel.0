From: Loic Dachary <loic@dachary.org>
Subject: Re: Merging hammer in master: conflict on gmock
Date: Tue, 10 Mar 2015 00:06:29 +0100
Message-ID: <54FE2775.8010608@dachary.org>
References: <54FDABC0.4080803@dachary.org> <54FDD8D8.6090709@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="L1sPcMtoBfIFGBxtqoWxvP1QL86e5BOAt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55434 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751596AbbCIXGf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 19:06:35 -0400
In-Reply-To: <54FDD8D8.6090709@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L1sPcMtoBfIFGBxtqoWxvP1QL86e5BOAt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/03/2015 18:31, Danny Al-Gaaf wrote:
> Hi Loic,
>=20
> this one is a tricky one. I didn't find a smooth/automatic solution yet=
=2E
>=20
> This seems to work:
>=20
> git checkout master
> git merge --no-ff origin/hammer
> git mergetool
>  -> for the conflict: select 'local' for src/gmock (this should keep
>     the changes im master and ignore changes from hammer)

Do you know what changes have been done in hammer in src/gmock ?

> git commit
>=20
> You may have to check if the result is what's intended.
>=20
> Danny
>=20
> Am 09.03.2015 um 15:18 schrieb Loic Dachary:
>> Hi Danny,
>>
>> As of now, git checkout master ; git merge origin/hammer gets a=20
>> conflict on gmock
>>
>> When we last discussed it you found that git merge -m 1 was a=20
>> solution. But I'm not sure I fully understand the consequences.
>>
>> Cheers
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--L1sPcMtoBfIFGBxtqoWxvP1QL86e5BOAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT+J3UACgkQ8dLMyEl6F22RlgCfTDottfG1qma+DFzQPE8CgkNO
t0sAoLuSNeSjZs86KVjmt85mm1+qkogw
=1prQ
-----END PGP SIGNATURE-----

--L1sPcMtoBfIFGBxtqoWxvP1QL86e5BOAt--
