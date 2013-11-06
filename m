From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] Running on disks that lose their head
Date: Thu, 07 Nov 2013 00:41:52 +0800
Message-ID: <527A7150.70901@dachary.org>
References: <52798E1D.9090807@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pJM4xsobU8md2x31v3fG4rJkmgpGuXDJ2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:57404 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab3KFQl6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 11:41:58 -0500
In-Reply-To: <52798E1D.9090807@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pJM4xsobU8md2x31v3fG4rJkmgpGuXDJ2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

An anonymous kernel developer sends this link:

http://en.wikipedia.org/wiki/Error_recovery_control


On 06/11/2013 08:32, Loic Dachary wrote:
> Hi Ceph,
>=20
> People from Western Digital suggested ways to better take advantage of =
the disk error reporting. They gave two examples that struck my imaginati=
on. First there are errors that look like the disk is dying ( read / writ=
e failures ) but it's only a transient problem and the driver should be a=
ble to make the difference by properly interpreting the available informa=
tion. They said that the prolonged life you get if you don't decommission=
 a disk that only has a transient error is significant. The second exampl=
e is when one head out of ten fails : disks can keep working with the nin=
e remaining heads. Losing 1/10 of the disk is likely to result in a full =
re-install of the Ceph osd. But, again, the disk could keep going after t=
hat, with 9/10 of its original capacity. And Ceph is good at handling osd=
 failures.
>=20
> All this is news to me and sounds really cool. But I'm sure there are p=
eople who already know about it and I'm eager to hear their opinion :-)
>=20
> Cheers
>=20
>=20
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--pJM4xsobU8md2x31v3fG4rJkmgpGuXDJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ6cVAACgkQ8dLMyEl6F23LHQCeIFD9tT7T/3BLzhzM+0RhQInE
GREAn33UUKPv6hF6heaTs+FwjTNdL0Un
=iBEV
-----END PGP SIGNATURE-----

--pJM4xsobU8md2x31v3fG4rJkmgpGuXDJ2--
