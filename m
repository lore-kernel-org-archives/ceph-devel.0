From: Loic Dachary <loic@dachary.org>
Subject: Re: local teuthology testing
Date: Tue, 21 Jul 2015 17:47:54 +0200
Message-ID: <55AE69AA.7010601@dachary.org>
References: <06681238D8946F44A60AA400760A1CBF0201AC21@SHSMSX104.ccr.corp.intel.com>	<06681238D8946F44A60AA400760A1CBF0201B37F@SHSMSX104.ccr.corp.intel.com> <CAFdRU71=-huVv_x75NcSGdLjL_2k2uZ905Yjd+z-ean5Bk3Rog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SwC29sHO6pe5U8DQsTCOsHhQJIwfsKwOV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53753 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933193AbbGUPr5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 11:47:57 -0400
In-Reply-To: <CAFdRU71=-huVv_x75NcSGdLjL_2k2uZ905Yjd+z-ean5Bk3Rog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shinobu@linux.com, "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: David Casier AEVOO <david.casier@aevoo.fr>, Ceph Devel <ceph-devel@vger.kernel.org>, "sepia@lists.ceph.com" <sepia@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SwC29sHO6pe5U8DQsTCOsHhQJIwfsKwOV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Since July 18th teuthology no longer uses chef, this issue has been resol=
ved ! Using ansible requires configuration ( http://dachary.org/?p=3D3752=
 explains it shortly, maybe there is something in the documentation but I=
 did not pay enough attention to be sure ). At the end of http://dachary.=
org/?p=3D3752 you will see a list of configurable values and I suspect An=
drew & Zack would be more than happy to explain how any hardcoded leftove=
r can be stripped :-)

Cheers

On 21/07/2015 14:58, Shinobu Kinjo wrote:
> Hi,
>=20
> I think that you have to show us such a URLs for anyone who would have =
same biggest issue.
>=20
> Sincerely,
> Kinjo
>=20
> On Tue, Jul 21, 2015 at 9:52 PM, Zhou, Yuan <yuan.zhou@intel.com <mailt=
o:yuan.zhou@intel.com>> wrote:
>=20
>     Hi David/Loic,
>=20
>     I was also trying to make some local Teuthology clusters here. The =
biggest issue I met is in the ceph-qa-chef - there're lots of hardcoded U=
RL related with the sepia lab. I have to trace the code and change them l=
ine by line.
>=20
>     Can you please kindly share me how did you get this work? Is there =
an easy way to fix this?
>=20
>     Thanks, -yuan
>=20
>=20
>=20
>=20
> --=20
> Life w/ Linux <http://i-shinobu.hatenablog.com/>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SwC29sHO6pe5U8DQsTCOsHhQJIwfsKwOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWuaaoACgkQ8dLMyEl6F20oDACgxgOOJPdPgCxdKvTQluW60PO9
p4oAoK1ksvGzKTCu77JXjf4Ae3EDP4bT
=pqzD
-----END PGP SIGNATURE-----

--SwC29sHO6pe5U8DQsTCOsHhQJIwfsKwOV--
