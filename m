From: Loic Dachary <loic@dachary.org>
Subject: Re: testing the /dev/cciss/c0d0 device names
Date: Mon, 7 Dec 2015 10:29:39 +0100
Message-ID: <56655183.7000007@dachary.org>
References: <56632EAC.3040105@dachary.org>
 <CAOi1vP-jdgunEx4zt27ETZHbNGTzFxGp-rEbWJViD5OWLpS69A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hUVECCVExpR1kCPlhopfvtwJnPr84uD57"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45443 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754935AbbLGJ3m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 04:29:42 -0500
In-Reply-To: <CAOi1vP-jdgunEx4zt27ETZHbNGTzFxGp-rEbWJViD5OWLpS69A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Stolte, Felix" <f.stolte@fz-juelich.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hUVECCVExpR1kCPlhopfvtwJnPr84uD57
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

On 06/12/2015 20:15, Ilya Dryomov wrote:
> On Sat, Dec 5, 2015 at 7:36 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Ilya,
>>
>> ceph-disk has special handling for device names like /dev/cciss/c0d1 [=
1] and it was partially broken when support for device mapper was introdu=
ced. Ideally there would be a way to test that support when running the c=
eph-disk suite [2]. Do you know of a way to do that without having the ha=
rdware for which this driver is designed ?
>>
>> Maybe this convention (/dev/cciss/c0d0 being mapped to /sys/block/ccis=
s!c0d0 is not unique to this driver and I could use another to validate t=
he name conversion from X/Y to X!Y and vice versa is handled as it should=
 ?
>=20
> No, it's not unique.  driver core does strreplace(s, '/', '!') at
> register time to work around such block devices.  The list includes
> DAC960, aoeblk, cciss, cpqarray, sx8 and probably more, but I don't
> think anything widespread uses this naming scheme.  IIRC dm actually
> won't let you name a device with anything that contains a slash.
>=20
> If you really wanted you could set up aoeblk I guess, but a simple unit=

> test should be be more than enough ;)

Thanks for the information. I'll refrain from attempting integration test=
s and try to make it solid with unit tests :-)

Cheers

>=20
> Thanks,
>=20
>                 Ilya
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--hUVECCVExpR1kCPlhopfvtwJnPr84uD57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZlUYMACgkQ8dLMyEl6F22NcgCgjuIF0M7GgOvwv7QBeAZw0FS5
QSQAn3WdEhbOkFdBIfQx2UNQezke/Haj
=MXyq
-----END PGP SIGNATURE-----

--hUVECCVExpR1kCPlhopfvtwJnPr84uD57--
