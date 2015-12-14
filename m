From: Loic Dachary <loic@dachary.org>
Subject: Re: misc: ignore some unusable block devices
Date: Mon, 14 Dec 2015 19:40:57 +0100
Message-ID: <566F0D39.1010909@dachary.org>
References: <566EDC50.3010901@dachary.org>
 <robbat2-20151214T181759-408594839Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IFd9psA47lud5JJPr4TdaEel58CML9CFS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50041 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753539AbbLNSk7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 13:40:59 -0500
In-Reply-To: <robbat2-20151214T181759-408594839Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IFd9psA47lud5JJPr4TdaEel58CML9CFS
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 14/12/2015 19:18, Robin H. Johnson wrote:
> On Mon, Dec 14, 2015 at 04:12:16PM +0100, Loic Dachary wrote:
>> Hi Robin,
>>
>> I removed misc: ignore some unusable block devices
>> 9c5eaeccb807d103884f46d174798dd982092696 from the openstack branch
>> because it fails on CentOS 7 with
>> the following. Could you please make a new pull request with it so we
>> can keep testing it there ?
> Will do, but I wonder how you managed to get a return code of 2 from it=
;
> as that should be device-does-not-exist.

IIRC that happens when blkid fails to retrieve information. I found blkid=
 to be generally faster and less reliable than sgdisk -i 1 /dev/sdd for t=
he purpose of getting partition information. For ceph-disk we chose relia=
bility over speed. That being said I've not investigated the real reason =
why blkid returns -2.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--IFd9psA47lud5JJPr4TdaEel58CML9CFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZvDTkACgkQ8dLMyEl6F20txgCgoLnaRlx1YAWxCsGPbhl2mNsS
TEAAn3bMJ0j4GADIIwkdGxF6dO1tyjrc
=PHVI
-----END PGP SIGNATURE-----

--IFd9psA47lud5JJPr4TdaEel58CML9CFS--
