From: =?UTF-8?B?SmVucyBSZWhww7ZobGVy?= <jens.rehpoehler@filoo.de>
Subject: Re: ceph -w output
Date: Wed, 04 Jan 2012 12:51:08 +0100
Message-ID: <4F043D2C.9090306@filoo.de>
References: <4EE654A3.1040309@filoo.de> <CACLRD_3n6rCJNFVgmWesDjP3P7DY0bfZr_XGTtx9MC=r29uYRg@mail.gmail.com> <4EE8601F.90206@filoo.de> <CAORUGqB4ebxyumBdAjA=HcPyPhznfaFX43seoiNQVi32Rs8onw@mail.gmail.com> <4EE9C1AB.2010403@filoo.de> <CACLRD_3v3t-6nrkEGjiKgpcy-ou_4FpSiRTYA_-tJiguV=dvEw@mail.gmail.com> <4EEB2813.6060109@filoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAA9CD0C79BB1E9D8BDAE94BC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-6.de-punkt.de ([93.190.64.36]:49734 "EHLO
	mail-6.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab2ADLvR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2012 06:51:17 -0500
In-Reply-To: <4EEB2813.6060109@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA9CD0C79BB1E9D8BDAE94BC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

just to inform you: after upgrade to the lastest master (ceph version
0.39-210-gdf84594 (commit:df84594f205bb37d3b062b5b3b9cfd224e6c57d2)

the pgs in "creating" state disappeared. The bugfix seems to work.

Thx again

Jens

Am 16.12.2011 12:14, schrieb Jens Rehp=C3=B6hler:
> Hi Sam,
>
> thanks for the answers.
>
> We began with osd3 und osd4 for internal reasons. osd1 to 3 will be
> addes in near future.
>
> I will wait until the patch is in the stables branch.
>
> Thanks again
>
> Jens
>
>
> Am 15.12.2011 18:35, schrieb Samuel Just:
>> Sorry for the delay.  It looks like you hit a corner case in our crush=

>> implementation.  The short version is that this bug got fixed last
>> week in commit 14f8f00e579083db542568a60cd23d50055c92a3.
>>
>> The long version is that you have osd.3 and osd.4, but not osd.0,
>> osd.1, or osd.2.  The pgs stuck in creating are the ones mapped
>> specifically to osds 0, 1, and 2.  A pg ending in p# (like pg1.0p0) is=

>> supposed to map to osd.0 if possible.  With the above patch, those pgs=

>> should remap to available osds.
>>
>> -Sam
>>
>> On Thu, Dec 15, 2011 at 1:45 AM, Jens Rehp=C3=B6hler
>> <jens.rehpoehler@filoo.de> wrote:
>>> Am 14.12.2011 17:43, schrieb Tommi Virtanen:
>>>> On Wed, Dec 14, 2011 at 00:36, Jens Rehp=C3=B6hler <jens.rehpoehler@=
filoo.de> wrote:
>>>>> Attached you will find the output you asked for. Is there any limit=
ation
>>>>> on the amount of pools ? We create
>>>>> pools for every customer and store their VM images in that pools. S=
o we
>>>>> will create a lot of pools over time.
>>>> Each pool gets its own set of PGs (Placement Groups). An OSD that
>>>> manages too many PGs will use a lot of RAM. What is "too many" is
>>>> debatable, and really up to benchmarks, but considering we recommend=

>>>> about 100 PGs/OSD as a starting point, you probably don't want to go=

>>>> two orders of magnitude above that.
>>> Ok .... that will serve our needs. Remains only the "creating" questi=
on.
>>>
>>> Any answers to that ?
>>>
>>> Thanks a lot !
>>>
>>> Jens
>>>


--=20
mit freundlichen Gr=C3=BCssen

Jens Rehp=C3=B6hler

----------------------------------------------------------------------
Filoo GmbH
Moltkestr. 25a
33330 G=C3=BCtersloh
HRB4355 AG G=C3=BCtersloh

Gesch=C3=A4ftsf=C3=BChrer: S.Grewing | J.Rehp=C3=B6hler | C.Kunz
Telefon: +49 5241 8673012 | Mobil: +49 151 54645798
Hotline: 07000-3378658 (14 Ct/min) Fax: +49 5241 8673020



--------------enigAA9CD0C79BB1E9D8BDAE94BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8EPTIACgkQrXbD/qaJ+dPS1wCfXS0ALL7Try4nZkbFP2kdheva
IoMAni7PB9WL00J+ejwpm3I1PBYxxJH+
=ZNDF
-----END PGP SIGNATURE-----

--------------enigAA9CD0C79BB1E9D8BDAE94BC--
