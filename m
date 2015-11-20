From: Loic Dachary <loic@dachary.org>
Subject: Re: ./run-make-check.sh
Date: Fri, 20 Nov 2015 09:15:43 +0100
Message-ID: <564ED6AF.2030106@dachary.org>
References: <1842494150.16154755.1447976394788.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ds3RuXtf9QvRGRd9ojKijFMtJOMLQ0teG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35905 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934361AbbKTIPq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 03:15:46 -0500
In-Reply-To: <1842494150.16154755.1447976394788.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ds3RuXtf9QvRGRd9ojKijFMtJOMLQ0teG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It is uncommon to run this script as root, there is no need to.

On 20/11/2015 00:39, Shinobu Kinjo wrote:
> Hello,
>=20
> I saw this message during executing run-make-check.sh on fc23:
>=20
> 2015-11-20 01:05:37.529021 7f8742e3d7c0 -1  ** ERROR: error creating em=
pty object store in testdir/osd-reactivate/0: (13) Permission denied

Could you publish somewhere (paste2.org for instance) the full output of =
run-make-check.sh ? It is possible to get EPERM for reasons other than th=
e underlying file system permission.

Cheers

>=20
> Can we ignore at the moment?
>=20
> If I've missed anything, let me know.
>=20
> Thanks!!
> Shinobu
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ds3RuXtf9QvRGRd9ojKijFMtJOMLQ0teG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZO1q8ACgkQ8dLMyEl6F23ODwCdH/PdEbo98RozFukWl4DFn8oS
O4UAn2TZYYfgIoywXsD0Rsx9Y4Bpg0s1
=OAlO
-----END PGP SIGNATURE-----

--ds3RuXtf9QvRGRd9ojKijFMtJOMLQ0teG--
