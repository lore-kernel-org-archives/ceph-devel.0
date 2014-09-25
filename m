From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-maintainers] v0.67.11 dumpling released
Date: Thu, 25 Sep 2014 17:59:01 +0200
Message-ID: <54243BC5.9030803@dachary.org>
References: <alpine.DEB.2.00.1409250808190.15854@cobra.newdream.net>	<5424390D.6010203@cloudapt.com> <alpine.DEB.2.00.1409250852020.16795@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1kIticsf6k6Hht1xLJolop8KiFb7P7CUF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59936 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753094AbaIYP7I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 11:59:08 -0400
In-Reply-To: <alpine.DEB.2.00.1409250852020.16795@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Mike Dawson <mike.dawson@cloudapt.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1kIticsf6k6Hht1xLJolop8KiFb7P7CUF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 25/09/2014 17:53, Sage Weil wrote:
> On Thu, 25 Sep 2014, Mike Dawson wrote:
>> On 9/25/2014 11:09 AM, Sage Weil wrote:
>>> v0.67.11 "Dumpling"
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> This stable update for Dumpling fixes several important bugs that aff=
ect a
>>> small set of users.
>>>
>>> We recommend that all Dumpling users upgrade at their convenience.  I=
f
>>> none of these issues are affecting your deployment there is no urgenc=
y.
>>>
>>>
>>> Notable Changes
>>> ---------------
>>>
>>> * common: fix sending dup cluster log items (#9080 Sage Weil)
>>> * doc: several doc updates (Alfredo Deza)
>>> * libcephfs-java: fix build against older JNI headesr (Greg Farnum)
>>> * librados: fix crash in op timeout path (#9362 Matthias Kiefer, Sage=
 Weil)
>>> * librbd: fix crash using clone of flattened image (#8845 Josh Durgin=
)
>>> * librbd: fix error path cleanup when failing to open image (#8912 Jo=
sh
>>> Durgin)
>>> * mon: fix crash when adjusting pg_num before any OSDs are added (#90=
52
>>>    Sage Weil)
>>> * mon: reduce log noise from paxos (Aanchal Agrawal, Sage Weil)
>>> * osd: allow scrub and snap trim thread pool IO priority to be adjust=
ed
>>>    (Sage Weil)
>>
>> Sage,
>>
>> Thanks for the great work! Could you provide any links describing how =
to tune
>> the scrub and snap trim thread pool IO priority? I couldn't find these=

>> settings in the docs.
>=20
> It's=20
>=20
>  osd disk thread ioprio class =3D idle
>  osd disk thread ioprio priority =3D 0
>=20
> Note that this is a short-term solution; we eventaully want to send all=
 IO=20
> through the same queue so that we can prioritize things more carefully.=
 =20
> This setting will most likely go away in the future.
>=20

The documentation for these can be found at

http://ceph.com/docs/giant/rados/configuration/osd-config-ref/#operations=


Control-f ioprio

Cheers

>> IIUC, 0.67.11 does not include the proposed changes to address #9487 o=
r=20
>> #9503, right?
>=20
> Correct.  That will come later once it's gone through more testing.
>=20
> Thanks!
> sage
> _______________________________________________
> Ceph-maintainers mailing list
> Ceph-maintainers@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--1kIticsf6k6Hht1xLJolop8KiFb7P7CUF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQkO8UACgkQ8dLMyEl6F21sfACfQqGimpkL8rnByPLsMmwkgtwi
ICkAn006KJNzjGhSbts05dgNgEejhbYt
=H9Ls
-----END PGP SIGNATURE-----

--1kIticsf6k6Hht1xLJolop8KiFb7P7CUF--
