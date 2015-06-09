From: Loic Dachary <loic@dachary.org>
Subject: Re: provisioning teuthology targets with OpenStack
Date: Tue, 09 Jun 2015 20:58:00 +0200
Message-ID: <55773738.1090701@dachary.org>
References: <557479B4.9060207@dachary.org> <837976248.11945956.1433867145523.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fNd6KOOvPEmQp3duUlxctbeT4MbqhL1nL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59216 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754050AbbFIS6D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 14:58:03 -0400
In-Reply-To: <837976248.11945956.1433867145523.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fNd6KOOvPEmQp3duUlxctbeT4MbqhL1nL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/06/2015 18:25, Zack Cerza wrote:
> Hi Loic!
>=20
> I'm really happy to hear you have the time and motivation to work on th=
is! It's something I've wanted to get to for a while, but other things ke=
ep getting in the way.
>=20
> I'd suggest looking at teuthology.provision.Downburst to investigate ma=
ybe pulling some of its functionality into a base class that a potential =
OpenStack subclass could also benefit from. I'd love to see us using a co=
mmon interface for all of our provisioning. If that seems like a lot of w=
ork, I'd be willing to be the one to create the base class and work with =
you to make sure its API was useful for OpenStack as well.
>=20

Thanks for the pointers. I'll write something that works and get back to =
you to make it acceptable :-)

> Thanks,
> Zack
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Zack Cerza" <zcerza@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Sunday, June 7, 2015 11:04:52 AM
>> Subject: provisioning teuthology targets with OpenStack
>>
>> Hi Zack,
>>
>> I'm motivated by my recent experience with hacking teuthology and cont=
ainers
>> :-) I'd like to give
>>
>> http://tracker.ceph.com/issues/6502 "provision targets using a cloud A=
PI"
>>
>> a shot with OpenStack in mind (because I know nothing of EC2 really). =
The
>> idea is to make it relatively easy for someone with access to an OpenS=
tack
>> tenant to using instead of downburst. Not only would that simplify the=

>> development process for people without access to the lab, it would als=
o
>> allow the addition of more horsepower to the lab. What do you think ?
>>
>> Cheers
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--fNd6KOOvPEmQp3duUlxctbeT4MbqhL1nL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlV3NzgACgkQ8dLMyEl6F20yiwCeLIKfv7FKL1pxr/1umjYR4tCo
4s0An05JrMrMYOVdTEEJd3U2Vo/bTCRr
=9nQ1
-----END PGP SIGNATURE-----

--fNd6KOOvPEmQp3duUlxctbeT4MbqhL1nL--
