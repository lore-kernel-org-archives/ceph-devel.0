From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw backports to giant update
Date: Sat, 31 Jan 2015 00:10:54 +0100
Message-ID: <54CC0F7E.3060007@dachary.org>
References: <54C98379.7030100@dachary.org> <CABBk=J837H7WnZYBAa=SP0_CcDrRcVzY3_2dB-S_zMk6OHB7XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qEwnkNqmRr99v3dEDQt5EAEwi9BnRhPBN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50059 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752697AbbA3XK4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 18:10:56 -0500
In-Reply-To: <CABBk=J837H7WnZYBAa=SP0_CcDrRcVzY3_2dB-S_zMk6OHB7XQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qEwnkNqmRr99v3dEDQt5EAEwi9BnRhPBN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

Thanks a lot for this inventory. I updated the tickets to make sure all o=
f them have the "giant" string in the backport field. I'll try backportin=
g myself which will help when it's trivial. If I hit a conflict I'll get =
back to you :-)

Greetings from Brussels !

On 30/01/2015 20:05, Yehuda Sadeh wrote:
> Hi,
>=20
> these are the actual issues that I backported:
>=20
>  - 9878  rhel7 s3-tests fail due to missing reason
>  - 9918  RGW-Swift: SubUser access permissions, does not seems to workm=
inor
>  - 10103 swift tests failing
>  - 10354 Failed s3 tests in
> upgrade:dumpling-firefly-x:parallel-next-distro-basic-multi run
>  - 10471 rgw: metadata sync doesn't create subusers correctly
>  - 9254  rgw: civetweb requires explicit \r\n for http headers
>  - 9478  Incorrect content type in response header
>  - 9479  ETag is not included in the XML response to put object copy
> operationminor
>  - 9877  In some cases it's possible for rgw to segfault on http COPY
>  - 10329 rgw: s3 need to return SignatureDoesNotMatch instead of
> AccessDenied- minor
>  - 5595  object has a Content-Type, but its content_type property is
> not shown in Swift object enumeration
>  - 9907  Normal    radosgw-admin: can't disable max_size quota
>  - 9973  Validation of Swift DLO manifest object ETag doesn't match
> OpenStack Swift behavior
>  - 10307 rgw: setting bucket attributes (swift POST on bucket)
> sometimes failminor
>  - 10334 rgw: s3 need to return InvalidAccessKeyId instead of AccessDen=
ied
>  - 9587  ceph-radosgw sysvinit script on EL6 cannot set ulimit
>=20
>=20
> On Wed, Jan 28, 2015 at 4:48 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Yehuda,
>>
>> Unless I'm mistaken there currently are no rgw issues scheduled to be =
backported to giant (i.e. with the giant word in the backport field of th=
e issue)[1] that have already been backported to firefly, as part of the =
v0.80.8[2] release or after[3]. You mentionned that about 18 patches back=
ported to firefly should also be backported to giant and I was hoping to =
find which one exactly thanks to the backport field.
>>
>> I'll go thru the rgw backports found in v0.80.8 to figure out which on=
e should be in giant. I don't need anything righ now, this is just an upd=
ate to let you know things are making progress.
>>
>> Cheers
>>
>> [1] inventory of the pending giant v0.87.1 release http://tracker.ceph=
=2Ecom/issues/10501
>> [2] inventory of the firefly v0.80.8 commits http://tracker.ceph.com/i=
ssues/10639
>> [3] inventory of the pending firefly v0.80.9 release http://tracker.ce=
ph.com/issues/10641
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--qEwnkNqmRr99v3dEDQt5EAEwi9BnRhPBN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTMD34ACgkQ8dLMyEl6F22beQCgpJVzyPVkOOyU7R0KSpOAiIm1
jjMAnAkSVo7uxSFWPR3dbwMVe8+h5g27
=jHer
-----END PGP SIGNATURE-----

--qEwnkNqmRr99v3dEDQt5EAEwi9BnRhPBN--
