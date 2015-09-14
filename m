From: Loic Dachary <loic@dachary.org>
Subject: Re: reducing package size / compression time
Date: Mon, 14 Sep 2015 08:24:52 +0200
Message-ID: <55F66834.3030909@dachary.org>
References: <55F5FAD2.10802@dachary.org> <alpine.DEB.2.00.1509131839480.23022@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NRDQGntemi5dwEEoobocjBaS0tm69F228"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54881 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751444AbbINGYy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 02:24:54 -0400
In-Reply-To: <alpine.DEB.2.00.1509131839480.23022@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NRDQGntemi5dwEEoobocjBaS0tm69F228
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Thanks for the link. Was that effective ?

On 14/09/2015 03:40, Sage Weil wrote:
> On Mon, 14 Sep 2015, Loic Dachary wrote:
>> Hi Sage,
>>
>> You did something to reduce the size (hence the compression time) of t=
he=20
>> debug packages using=20
>> https://fedoraproject.org/wiki/Features/DwarfCompressor. Would you be =
so=20
>> kind as to remind me which commit does that ?
>=20
> https://github.com/ceph/autobuild-ceph/commit/193864ec69edb4dbb0112bb3e=
a54e6d2f20b30dd
>=20
> The suggestion came from Boris.
>=20
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NRDQGntemi5dwEEoobocjBaS0tm69F228
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX2aDQACgkQ8dLMyEl6F23IBACgwcu099yVbey4Ny05eQ1jeF9d
boYAoKGfuXzzKAwpaN+A5zvgS0SbwSpH
=XlGb
-----END PGP SIGNATURE-----

--NRDQGntemi5dwEEoobocjBaS0tm69F228--
