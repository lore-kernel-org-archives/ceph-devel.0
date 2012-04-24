From: =?ISO-8859-15?Q?Jo=E3o_Eduardo_Lu=EDs?= <jecluis@gmail.com>
Subject: Re: Strange write behavior on an osd
Date: Tue, 24 Apr 2012 16:23:03 +0100
Message-ID: <4F96C557.4090603@gmail.com>
References: <4F96B971.5050806@tuxadero.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A8FA911EC422FE0BD2525DD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35493 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab2DXPXI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Apr 2012 11:23:08 -0400
Received: by bkuw12 with SMTP id w12so565616bku.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Apr 2012 08:23:07 -0700 (PDT)
In-Reply-To: <4F96B971.5050806@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A8FA911EC422FE0BD2525DD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/24/2012 03:32 PM, Martin Mailand wrote:
> Hi,
> I have a strange behavior on the osd, the cluster is a two node system,=

> on one machine 50 qemu/rbd vm's are running (idling) the other machine
> is a osd with four osd processes and one mon processes.
>=20
> The osd disk are as follow
>=20
> sda is root
> sdb is journal four partitions
> sd{c,d,e,f) each three disk via a raid controler.
>=20
> /dev/sdc on /data/osd.0 type btrfs
> (rw,noatime,nodiratime,nodatacow,autodefrag)
> /dev/sdd on /data/osd.1 type btrfs
> (rw,noatime,nodiratime,nodatacow,autodefrag)
> /dev/sde on /data/osd.2 type btrfs
> (rw,noatime,nodiratime,nodatacow,autodefrag)
> /dev/sdf on /data/osd.3 type btrfs
> (rw,noatime,nodiratime,nodatacow,autodefrag)
>=20
>=20
> There is almost no network traffic, but the osd writes huge amount to
> the disk for around 90 sec and then its almost idle for 30 sec, the
> writes always goes to sde.
>=20
> Why is it so bursty?
>=20
> [snip]

Any chance you could run iotop during the busy periods and tell us which
processes are issuing the io?

--=20
Jo=E3o Eduardo Lu=EDs
gpg key: 477C26E5 from pool.keyserver.eu


--------------enig2A8FA911EC422FE0BD2525DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPlsVYAAoJEJ9vvxhHfCbl36cH+gIxxTnHCEkudKO3uGDEWbYB
rOYM2erzU8Q/8lK+ImZdZ+VXzJyswerCMNchrgbeJERnONqRJVQoZ95zoW8SL+u3
CTzoT+hiQmGFKaW4ylh3VYuA6dCWIr1Z8KzQCt8RAFFWG1PabzL2CpgwlusxX5Um
kYZiaH7LjSF/vjf+RVVNmWxTcrINzdMkZ/PK02O9xAcKqU5Vwhwv5GonPYlJLNPk
gNafvJJ8SonWZlilHu9NsxkzKNQN/eJYsaLjFVMVZvpKM1QDxYxfbpz+TZRy5Etj
RbqbAmVa9U3WZDwgzyDZURU/9JlYaSb8P0PjHT8Kn9N8FybJgq5JuK1lsoO56NU=
=RvzY
-----END PGP SIGNATURE-----

--------------enig2A8FA911EC422FE0BD2525DD--
