From: Loic Dachary <loic@dachary.org>
Subject: Re: Initializing paddles
Date: Sat, 25 Oct 2014 16:28:56 -0700
Message-ID: <544C3238.7080305@dachary.org>
References: <544B36D3.8050103@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1fD6nRDObRSIG1kDX8c2nvAwwVSpIcfmG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53201 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751034AbaJYX27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Oct 2014 19:28:59 -0400
In-Reply-To: <544B36D3.8050103@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1fD6nRDObRSIG1kDX8c2nvAwwVSpIcfmG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 24/10/2014 22:36, Loic Dachary wrote:
> Hi Zack,
>=20
> Now that I have a paddles server running, I'd like to populate it with =
two virtual machines I have running. Is there a script to do this or shou=
ld I just type  SQL statements to do that semi-intuitively ?=20
>=20
> $ curl 'http://localhost:8080/nodes/?machine_type=3Dvps&count=3D2'
> []

I tried something like

for id in 1 2 3 ; do sqlite3 dev.db "insert into nodes (id,name,machine_t=
ype,is_container,is_vm,locked,up,locked_by) values ($id, 'container00$id'=
, 'plana', 1, 0, 0, 1, 'scheduled');" ; done

and it works so far (i.e. I'm making progress although I'm not to the poi=
nt where a machine gets a job yet ;-)

Cheers

>=20
> Cheers=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--1fD6nRDObRSIG1kDX8c2nvAwwVSpIcfmG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRMMjgACgkQ8dLMyEl6F20WogCgowIY9AqYgCqYhVVcuM0ngH92
EIEAn3ak8g6vVd0lnuNasUwCyieQF1K7
=GBsN
-----END PGP SIGNATURE-----

--1fD6nRDObRSIG1kDX8c2nvAwwVSpIcfmG--
