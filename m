From: Loic Dachary <loic@dachary.org>
Subject: Re: Some gitbuilders not working
Date: Fri, 09 Jan 2015 14:34:19 +0100
Message-ID: <54AFD8DB.9050303@dachary.org>
References: <54AF7B4C.6010305@inktank.com> <54AFAE7D.5070402@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="a9QRVuPns1DBFWkEIhVkuNTUwTvlG55gH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35971 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757455AbbAINeV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 08:34:21 -0500
In-Reply-To: <54AFAE7D.5070402@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a9QRVuPns1DBFWkEIhVkuNTUwTvlG55gH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I manually installed xmlstarlet on gitbuilder-ceph-rpm-rhel7-amd64-basic.=
 That's hopefully going to help until it's properly installed.

On 09/01/2015 11:33, Loic Dachary wrote:
>=20
> Hi David,
>=20
> On 09/01/2015 07:55, David Zafman wrote:
>>
>> We are seeing gitbuilder failures.  This is what I saw on one.
>>
>> error: Failed build dependencies:
>> xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64
>=20
> This is because https://github.com/ceph/ceph/pull/3036 was recently mer=
ged. However, https://github.com/ceph/autobuild-ceph/pull/19 added xmlsta=
rlet about a month ago. Maybe some gitbuilder machines were not updated a=
ccordingly. If I'm not mistaken this is a manual process but I'm not sure=
 exactly how to do it myself.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--a9QRVuPns1DBFWkEIhVkuNTUwTvlG55gH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSv2NsACgkQ8dLMyEl6F23xVwCcDX63PTbNQSJRz3OsxAM/uYAO
pDoAnRlX3Mf2sxIX8i40E/YKbLmbLbs2
=aaAl
-----END PGP SIGNATURE-----

--a9QRVuPns1DBFWkEIhVkuNTUwTvlG55gH--
