From: Loic Dachary <loic@dachary.org>
Subject: Re: RHEL 6.5 shared library upgrade safety
Date: Mon, 18 Aug 2014 17:25:50 +0200
Message-ID: <53F21AFE.6090900@dachary.org>
References: <53F1EA1C.1020108@dachary.org> <alpine.DEB.2.00.1408180816390.28244@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5F8jPNLajHgxWD2ftM6uNkT5JgRWi7TXW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33315 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750789AbaHRPZ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 11:25:57 -0400
In-Reply-To: <alpine.DEB.2.00.1408180816390.28244@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5F8jPNLajHgxWD2ftM6uNkT5JgRWi7TXW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 18/08/2014 17:17, Sage Weil wrote:
> On Mon, 18 Aug 2014, Loic Dachary wrote:
>> Hi Ceph,
>>
>> In RHEL 6.5, is the following scenario possible :=20
>>
>> a) an OSD dlopen a shared library for erasure-code,=20
>> b) the shared library file is replaced while the OSD is running,=20
>> c) the OSD starts using the new file instead of the old one.=20
>>
>> It seems unlikely but it would explain a weird stack trace at=20
>> http://tracker.ceph.com/issues/9153#note-5 so I'm double checking ;-)
>=20
> I think this is possible and likely.  We had similar problems with the =

> rados classes and eventually just made them load all available plugins =
on=20
> startup (and also on demand in case one is installed later).
>=20
> The simplest thing is probably to do that here as well...

This will not solve the upgrade problem for Firefly daemons which are are=
 already running, unfortunately. Stopping the daemons while the package i=
s being upgraded seems safer and more generic (see the other thread). Or =
are there issues with this approach ?

Cheers

>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--5F8jPNLajHgxWD2ftM6uNkT5JgRWi7TXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPyGv4ACgkQ8dLMyEl6F21pWACfTKfzhh1Lg12YfLs5eXO7h/+D
81sAn3UV40pJi+h8/c2a8jDnV3lZ0IvQ
=jVF4
-----END PGP SIGNATURE-----

--5F8jPNLajHgxWD2ftM6uNkT5JgRWi7TXW--
