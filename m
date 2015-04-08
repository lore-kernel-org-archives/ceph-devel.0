From: Loic Dachary <loic@dachary.org>
Subject: Re: Call for jenkins slaves to improve multi operating system support
Date: Wed, 08 Apr 2015 19:31:04 +0200
Message-ID: <552565D8.1000006@dachary.org>
References: <55250954.1010305@dachary.org> <alpine.DEB.2.00.1504080957210.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sBmv0cvTjTT00gaLXvnj5QxA9F6VX7uHn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43553 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754089AbbDHRbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 13:31:07 -0400
In-Reply-To: <alpine.DEB.2.00.1504080957210.4469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sBmv0cvTjTT00gaLXvnj5QxA9F6VX7uHn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 08/04/2015 18:59, Sage Weil wrote:
> On Wed, 8 Apr 2015, Loic Dachary wrote:
>> Hi Ceph,
>>
>> When a contribution is proposed to Ceph [1], a bot compiles and run=20
>> tests with it to provide feedback to the developer [2]. When something=
=20
>> goes wrong the failure can be repeated on the developer machine [3] fo=
r=20
>> debug. This also helps the reviewer who knows the code compiles and do=
es=20
>> not break anything that would be detected by "make check".
>>
>> The bot runs on CentOS 7 and Ubuntu 14.04 only, and problems related t=
o=20
>> older operating systems (headers, compiler version, etc.) may be=20
>> detected later, when building packages [4] and after the pull request =

>> has been merged in master. This is rare but requires extra attention=20
>> from the reviewer and needs to be dealt with urgently when it happens.=

>=20
> Do additional slaves block the message from appearing on the pull=20
> request?  I.e., what happens if a slave is very slow (e.g., armv7) or=20
> broken (network issue)?

I will make it so a comment is posted as soon as the first slave succeeds=
 / fails (it currently waits for all to finish which is inconvenient). Th=
e first slave will always be a CentOS 7 running on a fast machine so that=
 the worst that can happen is that it's the only one to run. If slow slav=
es lag behind too much it would be nice to have a jenkins plugin that dis=
cards jobs randomly to prevent the queue from growing out of proportion o=
n that specific slave.

> What are the connectivity requirements? =20

Nothing more than the ability to git pull from a ceph repository.=20

> Can slaves exist on other=20
> (private) networks?

Yes. In that case a ssh -f -n -L tunnel to the jenkins master will be est=
ablished to allow it to probe the slave when necessary.

>=20
> Thanks!
> sage
>=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--sBmv0cvTjTT00gaLXvnj5QxA9F6VX7uHn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUlZdgACgkQ8dLMyEl6F231lgCcC4VKsDsEfjHZd9J9W6rCLzJL
UbcAn1uLuMBb1tIklpPIeaVfQZ0N3puH
=8Inz
-----END PGP SIGNATURE-----

--sBmv0cvTjTT00gaLXvnj5QxA9F6VX7uHn--
