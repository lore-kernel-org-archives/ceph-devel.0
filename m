From: Karol Mroz <kmroz@suse.com>
Subject: Re: Infernalis RGW failure investigation
Date: Mon, 8 Feb 2016 13:02:18 -0800
Message-ID: <20160208210218.GC14128@oak.lan>
References: <56B8110D.8040401@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:36033 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbcBHVC1 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 8 Feb 2016 16:02:27 -0500
Content-Disposition: inline
In-Reply-To: <56B8110D.8040401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2016 at 10:52:45AM +0700, Loic Dachary wrote:
> Dear RGW developers,
>=20
> We ran into http://tracker.ceph.com/issues/14665 on the infernalis branch=
=2E It would be great if someone could shed some light on why it happens.
>=20

Hi Loic,

If this has already been discussed elsewhere, or I'm simply stating the obv=
ious,
my apologies in advance. However, it looks like the rgw socket file _may_ b=
e created
with some odd permissions/ownership, relative to the user under which the t=
est is being
run.

With a recent ceph/master build on my end (I don't have immediate access to=
 an infernalis
system), the rgw admin socket is created as ceph:ceph. Running `radosgw-adm=
in` as root
then binds fine.


I've added http://tracker.ceph.com/issues/14665#note-3

--=20
Regards,
Karol

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuQJVAAoJECp28bThgzatc2oIAJMTlvWdGXzcHEBzSHR3Vox/
eJcq8pTjwGavZey1RmW+YM7LY7F0AfxDQ28an//Vny36Ynffr91S0h2kfLBD6H73
Tz1oRor1aQsA+eylsUwLw/3NeH1YBOvXQKoYBh7ruTIAnaS8a7ti6dBBrxG7+Q72
zMpTl2yDVfylC7s4e/HovyOTmhli1XY9rJNCzPM++aQO3KdXwfOw6OJoHqEXE8bf
e3Duije6GbNra28V4nu6LEgl7t5Qw4C6EXAvK1vGmlnSigDqpT/ZuDiOSjCLSW1+
y7lf4EYzvXjnloF+J2bzM1u9lZgKkJtEji/sWwzVjmO2mGnzHuIDk4DxF25C3Uc=
=ECU+
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
