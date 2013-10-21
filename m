From: Loic Dachary <loic@dachary.org>
Subject: Removing disks / OSDs
Date: Mon, 21 Oct 2013 18:15:05 +0200
Message-ID: <52655309.8070500@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="h0GLv15PTpFaVbjK7cwaClq9mA3QmHfdP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41779 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3JUQPX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Oct 2013 12:15:23 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id A228926396
	for <ceph-devel@vger.kernel.org>; Mon, 21 Oct 2013 18:15:21 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h0GLv15PTpFaVbjK7cwaClq9mA3QmHfdP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

In the context of the ceph puppet module ( https://wiki.openstack.org/wik=
i/Puppet-openstack/ceph-blueprint ) I tried to think about what should be=
 provided to deal with disks / OSDs when they are removed or moved around=
=2E

Here is a possible scenario:

* Machine A dies and contains OSD 42
* ceph osd rm 42 is done to get rid of the OSD
* ceph-prepare is called on a new disk and gets OSD id 42

ceph/src/mon/OSDMonitor.cc

    // allocate a new id
    for (i=3D0; i < osdmap.get_max_osd(); i++) {
      if (!osdmap.exists(i) &&
	  pending_inc.new_up_client.count(i) =3D=3D 0 &&
	  (pending_inc.new_state.count(i) =3D=3D 0 ||
	   (pending_inc.new_state[i] & CEPH_OSD_EXISTS) =3D=3D 0))
	goto done;
    }

* The disk of machine A is still good and is plugged into machine C
* the udev logic sees it has the ceph magic uuid and contains a well form=
ed osd file system and runs the osd daemon on it. The osd daemon fails an=
d dies because its key does not match. It will try again and fail in the =
same way when the machine reboots.

If the osd id was not reused, the disk would find its way back in the clu=
ster and be reused without manual intervention. Since ceph-disk uses the =
osd uuid to create the disk, it does not matter that it has been removed =
: https://github.com/ceph/ceph/blob/master/src/ceph-disk#L458 . I'm not s=
ure to understand how the key that was previously registered is re-import=
ed. If I understand correctly it is created with ceph-osd --mkkey https:/=
/github.com/ceph/ceph/blob/master/src/ceph-disk#L1301 and stored in the o=
sd tree at the location specified by --keyring https://github.com/ceph/ce=
ph/blob/master/src/ceph-disk#L1307 .=20

At this point my understanding is that (as long as OSD ids are not reused=
), removing a disk or moving it from machine to machine, even over a long=
 period of time does not require any action. The OSD id is an int which i=
s probably large enough for any kind of cluster in the near future. The O=
SD ids that are not used and not removed could be cleaned from time to ti=
me to garbage collect the space they use.

Please let me know if I've missed something :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--h0GLv15PTpFaVbjK7cwaClq9mA3QmHfdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJlUwkACgkQ8dLMyEl6F237PwCghKM5nX4hnQJO2Y3/E7jV8l1Q
AkMAnj8/h5KRgYhle7Mj7fyeTSOzgx9A
=9ygN
-----END PGP SIGNATURE-----

--h0GLv15PTpFaVbjK7cwaClq9mA3QmHfdP--
