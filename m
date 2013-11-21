From: Loic Dachary <loic@dachary.org>
Subject: Re: possible bug in init-ceph.in
Date: Thu, 21 Nov 2013 18:57:30 +0100
Message-ID: <528E498A.8020102@dachary.org>
References: <24E144B8C0207547AD09C467A8259F7559232FA2@lisa.maurer-it.com> <528E4071.3070603@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="J6RU0nBX9fluDNRQEDJfgliWjb7d1RHxc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:45313 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab3KUR5c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Nov 2013 12:57:32 -0500
In-Reply-To: <528E4071.3070603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J6RU0nBX9fluDNRQEDJfgliWjb7d1RHxc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

It turns out there was no pull request or bug report, sorry about that. H=
ere is the pull request with your patch included:

https://github.com/ceph/ceph/pull/861

Cheers

On 21/11/2013 18:18, Loic Dachary wrote:
> Hi,
>=20
> I believe there is either a pull request or a ticket with this fix. Def=
initely a typo ;-)
>=20
> Cheers
>=20
> On 21/11/2013 08:23, Dietmar Maurer wrote:
>> http://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/init-ceph.in;h=3D73=
99abb8f85855f2248c4afb22bf94f2e2f080a2;hb=3DHEAD
>>
>> line 320:
>>
>>       if [ "${update_crush:-1}" =3D "1" -o "{$update_crush:-1}" =3D "t=
rue" ]; then
>>
>> looks strange to me. Maybe that should be:
>>
>> -		if [ "${update_crush:-1}" =3D "1" -o "{$update_crush:-1}" =3D "true=
" ]; then
>> +		if [ "${update_crush:-1}" =3D "1" -o "${update_crush:-1}" =3D "true=
" ]; then
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--J6RU0nBX9fluDNRQEDJfgliWjb7d1RHxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKOSYoACgkQ8dLMyEl6F21GOQCdFSwlMfEMXuEyFByzsJXicGc4
e4wAnjAd5VEzG8Jwp+CSJUxHkgsu1+fn
=oX0v
-----END PGP SIGNATURE-----

--J6RU0nBX9fluDNRQEDJfgliWjb7d1RHxc--
