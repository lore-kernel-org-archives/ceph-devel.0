From: Loic Dachary <loic@dachary.org>
Subject: Re: pre-Infernalis ceph-disk bug
Date: Wed, 14 Oct 2015 00:31:34 +0200
Message-ID: <561D8646.9050404@dachary.org>
References: <CAKRUTFCOucYJL-fqNoSA69V6ACjNNEr4hTskmcv=H1v+XSsoFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pFkn64D4PfREhXrTL5b2LH9V31Pi3a7xn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42508 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751866AbbJMWbg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 18:31:36 -0400
In-Reply-To: <CAKRUTFCOucYJL-fqNoSA69V6ACjNNEr4hTskmcv=H1v+XSsoFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeremy Hanmer <jeremy.hanmer@dreamhost.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pFkn64D4PfREhXrTL5b2LH9V31Pi3a7xn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/10/2015 00:02, Jeremy Hanmer wrote:
> I think I've found a bug in ceph-disk when running on Ubuntu 14.04
> (and I believe 12.04 as well, but haven't confirmed) and using
> --dmcrypt.
>=20
> The problem is that when update_partition() is called, partprobe is
> used to re-read the partition table (as opposed to partx on all other
> distros) and it appears that it isn't smart/thorough enough to update
> all of the device's metadata. Specifically, ID_PART_ENTRY_TYPE isn't
> updated:
>=20
> root@ceph-osd03:~# udevadm info --query=3Denv --name=3D/dev/vdd1 | grep=

> ID_PART_ENTRY_TYPE
> ID_PART_ENTRY_TYPE=3D89c57f98-2fe5-4dc0-89c1-5ec00ceff2be
>=20
> running `partx -u` rather than `partprobe` does the appropriate thing:
>=20
> root@ceph-osd03:~# partx -u /dev/vdd1
> root@ceph-osd03:~# udevadm info --query=3Denv --name=3D/dev/vdd1 | grep=

> ID_PART_ENTRY_TYPE
> ID_PART_ENTRY_TYPE=3D4fbd7e29-9d25-41b8-afd0-5ec00ceff05d
>=20
>=20
> I have an experimental patch here that Works For Me, but Sage wanted
> me to ping the list for input:
>=20
> https://github.com/fzylogic/ceph/commit/8c83f75392d68fbec7def8aa61f20b2=
c9c237571
>=20
>=20
> I also want to test the new Infernalis code for this same bug (after a
> cursory check, I strongly suspect it's there as well), but it'll take
> a little bit to get another test cluster up to confirm.

There has been many changes in infernalis, most of them to make it more r=
obust. It would be great if you could try to reproduce the problem you ha=
d with infernalis.=20

Your patch looks good and you could also remove https://github.com/fzylog=
ic/ceph/blob/8c83f75392d68fbec7def8aa61f20b2c9c237571/src/ceph-disk#L1505=
 which will happen immediately after the function returns.=20

An alternate fix would be to udevadm settle before https://github.com/fzy=
logic/ceph/blob/8c83f75392d68fbec7def8aa61f20b2c9c237571/src/ceph-disk#L9=
85 and after it to avoid races. I think the reason why partprobe does not=
 appear to work is because it triggers udev events that race with udev ev=
ents triggered by sgdisk while creating the partition.

Cheers

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--pFkn64D4PfREhXrTL5b2LH9V31Pi3a7xn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYdhkYACgkQ8dLMyEl6F20p6wCgngRA6ozcHWkhJJ93NzR8Etto
sBoAoKcfuY/Dy3G6OFvHYavxD8XrAqek
=q2QI
-----END PGP SIGNATURE-----

--pFkn64D4PfREhXrTL5b2LH9V31Pi3a7xn--
