From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology gevent version
Date: Mon, 17 Nov 2014 18:33:46 +0100
Message-ID: <546A317A.7010806@dachary.org>
References: <546892C4.1080205@dachary.org> <CAMfdg1OXa4RrmMmY8KJZRyxwuhNrRoLwq+LVZaCDZ3gOajWWMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6pb7dFqBCS0l1nV1Osf5TJS1aJFfh5FaR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38363 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751146AbaKQRds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 12:33:48 -0500
In-Reply-To: <CAMfdg1OXa4RrmMmY8KJZRyxwuhNrRoLwq+LVZaCDZ3gOajWWMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6pb7dFqBCS0l1nV1Osf5TJS1aJFfh5FaR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

It turns out that using a gevent threadpool was not a good idea therefore=
 I won't pursue this lead. But I keep the answer in mind, just in case :-=
)

Thanks !

On 17/11/2014 18:21, Zack Cerza wrote:
> Hey Loic,
>=20
> I actually don't know if it would cause problems or not. It would be
> useful to do some testing with the new version: maybe create a branch
> with a patch to requirements.txt to bump the version, run the unit
> tests and then some jobs to see if things break?
>=20
> Thanks,
> Zack
>=20
> On Sun, Nov 16, 2014 at 5:04 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Zack,
>>
>> At the moment teuthology requires gevent =3D=3D 0.13.6 ( https://githu=
b.com/ceph/teuthology/blob/master/requirements.txt#L2 ). Would it be a pr=
oblem to upgrade to a more recent version ? I'd like to use https://githu=
b.com/gevent/gevent/blob/master/gevent/threadpool.py which was introduced=
 in 1.0b1 http://gevent.org/changelog.html#release-1-0b1-jan-10-2012
>>
>> Cheers
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--6pb7dFqBCS0l1nV1Osf5TJS1aJFfh5FaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRqMXoACgkQ8dLMyEl6F23wXgCfd5NKZCWv8PBSFaSWIsCANuY6
1woAoIrKAhQB/KfUxAkDDGgPrhgDehNu
=k/OA
-----END PGP SIGNATURE-----

--6pb7dFqBCS0l1nV1Osf5TJS1aJFfh5FaR--
