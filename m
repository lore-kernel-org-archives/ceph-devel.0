From: Loic Dachary <loic@dachary.org>
Subject: Re: make check, src/test/ceph-disk.sh fails on Mint
Date: Sun, 17 May 2015 14:03:38 +0200
Message-ID: <5558839A.7050404@dachary.org>
References: <CAEFDAA6rAJeS80+Qrg=orzug++YWmGee31KYu1=pLy2s3HDYiQ@mail.gmail.com>	<5557B713.70905@redhat.com>	<CAEFDAA57-DJXu6Co5yLb=rienFbc6wm9HmachwGu5wpO=eo70A@mail.gmail.com>	<55585164.20500@dachary.org> <CAEFDAA7KvNs-kvh950WFu4V6=_EVy81WZLD5PLCqz5Hi+ur1DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KNq4uchS2OoC8k7JlEOqQK3Di8qNQVpEm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36603 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752722AbbEQMDl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 May 2015 08:03:41 -0400
In-Reply-To: <CAEFDAA7KvNs-kvh950WFu4V6=_EVy81WZLD5PLCqz5Hi+ur1DA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Jarzabek <stiopa@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KNq4uchS2OoC8k7JlEOqQK3Di8qNQVpEm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

https://github.com/ceph/ceph/pull/4706 looks good to me :-)

On 17/05/2015 11:51, Michal Jarzabek wrote:
> Thanks Loic, I'll try to add it to ceph_detect_init.
>=20
> Thanks,
> Michal
>=20
> On Sun, May 17, 2015 at 9:29 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi,
>>
>> On 17/05/2015 00:07, Michal Jarzabek wrote:
>>> Well, I do run it on Linux Mint, but rest of the tests passes without=

>>> any problems. So I was wondering if there was any simple way to fix
>>> this one as well.
>>
>> Yes, there is :-) A few weeks ago ceph-disk would blindly assume sysvi=
nit when a platform is unknown. Now you can add Linux Mint at https://git=
hub.com/ceph/ceph/tree/master/src/ceph-detect-init/ceph_detect_init so th=
at the proper init system is detected.
>>
>> If you want Linux Mint to be treated the same as another distribution =
you can do that at:
>>
>> https://github.com/ceph/ceph/blob/master/src/ceph-detect-init/ceph_det=
ect_init/__init__.py#L69
>>
>> which is probably the simplest.
>>
>> Cheers
>>
>>>
>>> On Sat, May 16, 2015 at 10:30 PM, David Zafman <dzafman@redhat.com> w=
rote:
>>>>
>>>> Is something really broken?  Or are you just on an unsupported platf=
orm?
>>>>
>>>> David
>>>>
>>>>
>>>> On 5/16/15 8:49 AM, Michal Jarzabek wrote:
>>>>>
>>>>> ceph_detect_init.exc.UnsupportedPlatform: Platform is not supported=
=2E:
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--KNq4uchS2OoC8k7JlEOqQK3Di8qNQVpEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVYg5oACgkQ8dLMyEl6F22c3gCgsm9VZQXpNcjO9OXWnUBfG5/1
ShIAnjqtFEpmZA1wINj28lLEND8SkYUc
=HNKi
-----END PGP SIGNATURE-----

--KNq4uchS2OoC8k7JlEOqQK3Di8qNQVpEm--
