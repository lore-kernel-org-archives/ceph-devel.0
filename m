From: Loic Dachary <loic@dachary.org>
Subject: Re: OSD abstract class
Date: Thu, 25 Apr 2013 20:28:38 +0200
Message-ID: <517975D6.1020904@dachary.org>
References: <5178E6AE.6060609@dachary.org> <CAPYLRzirdWRaAEDP7UrrgV-AGcj3KoEoHOtC+A7DFYJD7BQbCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7DB16C19586A5A8B8CFCE53F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:41145 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759305Ab3DYS2l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 14:28:41 -0400
In-Reply-To: <CAPYLRzirdWRaAEDP7UrrgV-AGcj3KoEoHOtC+A7DFYJD7BQbCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7DB16C19586A5A8B8CFCE53F
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/25/2013 06:45 PM, Gregory Farnum wrote:
> On Thu, Apr 25, 2013 at 1:17 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi,
>>
>> In the context of the implementation of
>>
>> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding=
_as_a_storage_backend
>>
>> I'm preparing tests to assert that the modifications that will be made=
 to the existing PG and ReplicatedPG will not introduce regressions. Unle=
ss I'm mistaken, there are no unit tests or functional tests for PG or Re=
plicatedPG at the moment. I thought that it might be useful to add an abs=
tract OSD class from which OSD is derived, to allow a test to derive from=
 it to implement synthetic behavior.
>>
>>
>> I gave it a try and it passes make check successfully. It is a little =
hairy because I commented out the code instead of removing it to help wit=
h rebasing.
>>
>> https://github.com/dachary/ceph/commit/a9eb690a3537c3f844b47e76cde048b=
084e314eb
>>
>> I'll now try to use it to implement some tests for ReplicatedPG.
>>
>> I would very much appreciate if someone has an advice on the best way =
to proceed. Even if it's to say : "you're crazy, don't go there ! you're =
wasting your time, there is a much simpler way !" ;-)
>=20
> What's your plot here? The OSD is fairly large to be doing unit tests
> on (although it's not insensible) =97 but if we want to form a new PG i=
t
> might be best to start out by making abstract PG implementations.
>=20

My reasoning was that to for a new PG it was enough to rely on

https://github.com/ceph/ceph/blob/master/src/osd/PG.h

and create a new ErasureEncodingPG.{cc,h} after=20

https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc

Since ReplicatedPG is the only class derived from PG, I assumed there wil=
l be a need to move code from ReplicatedPG to PG and vice versa to make s=
ure PG can actually be the base class of two different implementations. A=
re you suggesting that PG should be abstracted ? Is there a reason why it=
 would not be a good base class for a new ErasureEncodedPG ?=20

> That'll be a bit easier since I believe I they only access the
> OSDService now, and not the OSD proper.

Indeed :-) It will be a lot easier to write an OSDService abstract class =
to be derived for test purposes. It is much more complicated to do the sa=
me with OSD. And probably not necessary since PG's only access OSD thru O=
SDService.=20

Thanks a thousand time for the tip :-)

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig7DB16C19586A5A8B8CFCE53F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF5ddcACgkQ8dLMyEl6F23oMACggXELDHHjI4Y8gScNRKyApN7k
+RIAn1RA1WLznt8hfXfxH/JNMDu1xdc9
=xGqQ
-----END PGP SIGNATURE-----

--------------enig7DB16C19586A5A8B8CFCE53F--
