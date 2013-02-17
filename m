From: Loic Dachary <loic@dachary.org>
Subject: Re: experimental dmcrypt support
Date: Sun, 17 Feb 2013 15:01:54 +0100
Message-ID: <5120E2D2.10102@dachary.org>
References: <alpine.DEB.2.00.1302141748510.11259@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB09205E5AF51D3B1B5B2D4FC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:40764 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318Ab3BQOB6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Feb 2013 09:01:58 -0500
In-Reply-To: <alpine.DEB.2.00.1302141748510.11259@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB09205E5AF51D3B1B5B2D4FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Are you aware of the current efforts to support volume encryption in Open=
Stack ?

http://lists.openstack.org/pipermail/openstack-dev/2013-February/005317.h=
tml
https://blueprints.launchpad.net/nova/+spec/encrypt-cinder-volumes

My 2cts ;-)

On 02/15/2013 02:57 AM, Sage Weil wrote:
> Alexandre and I have been working on adding basic dm-crypt support to=20
> ceph-disk-prepare/activate.  At this point it is working reasonably wel=
l,=20
> but before we move forward I thought I'd see if anyone has=20
> feedback/comments on the implementation.
>=20
> The initial goals are very simple: transparently dm-crypt the volumes f=
or=20
> the osd data and journal befor we use them, and store the keys somewher=
e=20
> on the local host (currently /etc/ceph/dmcrypt-keys).  Eventually we'll=
=20
> want to something more sophisticated there--there is a whole industry t=
o=20
> supprot key management and compliance for this sort of thing--but slott=
ing=20
> that in later should be pretty simple.
>=20
> For now, the basic process looks like this:
>=20
>  ceph-disk-prepare --dmcrypt DATADISK [JOURNALDISK]
>=20
> When --dmcrypt is passed, we generate a unique UUID for the data and=20
> journal both (the data one matches the OSD uuid), and label the=20
> GPT partitions.  We also set the type to special "dmcrypted osd" and=20
> "dmcrypted journal" types.  The dm-crypt mapped devices appear in=20
> /dev/mapper/$UUID, so the journal symlink inside the data dir of the=20
> data volume points there.  Keys are stored in=20
> /etc/ceph/dmcrypt-keys/$UUID.
>=20
> Normally, to activate an OSD, a udev rule triggres on teh osd partition=
=20
> type and runs ceph-disk-active.  In this case, it's slightly more=20
> complicated.  A udev rule triggers on the encrypted journal partition t=
ype=20
> and starts dm-crypt (using the key in /etc/ceph/...).  For the encrypte=
d=20
> osd partition, we first start dm-crypt, then run ceph-disk-activate on =
the=20
> resulting /dev/mapper/$UUID volume.
>=20
> That's basically it.  Leveraging udev makes this pretty simple, and sho=
uld=20
> be portable to any distro (vs, say, using upstart events to do the same=
=20
> steps).
>=20
> Later, we may want to add some super-simple key management so that the =

> keys are stored on the monitor instead of in a local directory, but for=
=20
> some users at least this is sufficient (where the concern is really abo=
ut=20
> disposal of disks).
>=20
> See wip-dmcrypt in ceph.git to take a look.
>=20
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigB09205E5AF51D3B1B5B2D4FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEg4tIACgkQ8dLMyEl6F20zXACeMnLcN8Z1oG1ZUF9+hxvPHkyi
xEYAnRy4iIbfuShz9HEaI9EXZHUUY8nm
=LQAH
-----END PGP SIGNATURE-----

--------------enigB09205E5AF51D3B1B5B2D4FC--
