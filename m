From: Loic Dachary <loic@dachary.org>
Subject: Re: v0.75 contributors credits ( experimental)
Date: Wed, 15 Jan 2014 23:53:23 +0100
Message-ID: <52D71163.6010904@dachary.org>
References: <52D6450E.1090605@dachary.org> <robbat2-20140115T201426-879804072Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="u44njIoC7etShx7auQc7tpU4L3sS8iL4a"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:44708 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbaAOWx2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 17:53:28 -0500
In-Reply-To: <robbat2-20140115T201426-879804072Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u44njIoC7etShx7auQc7tpU4L3sS8iL4a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for pointing this problem : using --after --before makes things co=
mplicated and wrong. I'll send a version two momentarily.

On 15/01/2014 21:19, Robin H. Johnson wrote:
> On Wed, Jan 15, 2014 at 09:21:34AM +0100,  Loic Dachary wrote:
>> Hi Ceph,
>>
>> Here is a sorted list of authors and organizations who contributed to
>> v0.75, by number of commits or reviews back to v0.74. The affiliation
>> of authors to organizations can be updated by submitting a patch to
>> https://github.com/ceph/ceph/blob/master/.organizationmap
> I think the script should use tags as the marker points, rather than
> release dates.
>=20
> # git log tags/v0.74 |fgrep -c robbat2
> 0
> # git log tags/v0.75 |fgrep -c robbat2
> 6
>=20
> Your script output however says I didn't have any changes in v0.75.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--u44njIoC7etShx7auQc7tpU4L3sS8iL4a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLXEWMACgkQ8dLMyEl6F21GKQCfSQaTTLpMNUqDTW1ytigGPbV9
BN8An342kjl1JDAyDBDPvuWndfcBQOX9
=FqJB
-----END PGP SIGNATURE-----

--u44njIoC7etShx7auQc7tpU4L3sS8iL4a--
