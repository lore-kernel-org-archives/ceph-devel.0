From: Loic Dachary <loic@dachary.org>
Subject: Re: osd pool erasure code stripe width
Date: Sat, 20 Jun 2015 08:27:23 +0200
Message-ID: <558507CB.4080303@dachary.org>
References: <BC97738F8E7C8742BABED7F06FB9DF91669A8E8B@SATLEXDAG01.amd.com> <55849BF7.5050603@dachary.org> <BC97738F8E7C8742BABED7F06FB9DF91669A8FEC@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vBvv1BMDoG8dbQ7fUk5iX9jTfkWTUsW24"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37301 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751122AbbFTG13 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Jun 2015 02:27:29 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669A8FEC@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vBvv1BMDoG8dbQ7fUk5iX9jTfkWTUsW24
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 20/06/2015 03:18, Deneau, Tom wrote:
> So if I am looking at the performance of a system with
> ceph_erasure_code_benchmark, does this mean I should concentrate
> on the performance with --size 4096 (or whatever stripe width my
> ec pools are going to use)?

Yes. But the erasure code plugin encoding speed is not the only factor. Y=
ou probably want to try a rados bench instead to get more realistic numbe=
rs.

Cheers

>=20
> -- Tom
>=20
>> -----Original Message-----
>> From: Loic Dachary [mailto:loic@dachary.org]
>> Sent: Friday, June 19, 2015 5:47 PM
>> To: Deneau, Tom; ceph-devel
>> Subject: Re: osd pool erasure code stripe width
>>
>> Hi Tom,
>>
>> A stripe width of 4KB (the default) means the object is encoded 4KB at=
 a
>> time. It does not show in the file written to disk.
>>
>> Cheers
>>
>> On 19/06/2015 22:11, Deneau, Tom wrote:
>>> I am trying to understand the use of "osd pool erasure code stripe wi=
dth"
>>> For example, I have a single-node system with a k=3D2,m=3D1 ec pool a=
nd I
>>> write a single 40M object to this pool using rados bench.
>>> But when I look on the disk, I still see only the 3 20M pieces for th=
is
>> object.
>>> Where does the striping get used?
>>>
>>> -- Tom Deneau, AMD
>>>
>>>
>>> Description:
>>> Sets the desired size, in bytes, of an object stripe on every erasure=
 coded
>> pools. Every object if size S will be stored as N stripes and each str=
ipe
>> will be encoded/decoded individually.
>>> Type:
>>> Unsigned 32-bit Integer
>>> Default:
>>> 4096
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=

>>> in
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--vBvv1BMDoG8dbQ7fUk5iX9jTfkWTUsW24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWFB8sACgkQ8dLMyEl6F23UBgCgnPMDGW3uXaA21MtpTYhtQ3UM
Ok4AniMBkkvxFY9sirNbGu09/5GaMwlJ
=TdK/
-----END PGP SIGNATURE-----

--vBvv1BMDoG8dbQ7fUk5iX9jTfkWTUsW24--
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
