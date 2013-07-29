From: Loic Dachary <loic@dachary.org>
Subject: krbd & live resize
Date: Mon, 29 Jul 2013 23:50:01 +0200
Message-ID: <51F6E389.1040607@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEE8CB3E18B49610E44344BD6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42726 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab3G2VuE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 17:50:04 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 036F226396
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 23:50:01 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE8CB3E18B49610E44344BD6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

This works:

lvcreate --name tmp --size 10G all
  Logical volume "tmp" created
mkfs.ext4 /dev/all/tmp
mount /dev/all/tmp /mnt
blockdev --getsize64 /dev/all/tmp
10737418240
lvextend -L+1G /dev/all/tmp
  Extending logical volume tmp to 11,00 GiB
  Logical volume tmp successfully resized
blockdev --getsize64 /dev/all/tmp
11811160064
resize2fs /dev/all/tmp=20
resize2fs 1.41.12 (17-May-2010)
Filesystem at /dev/all/tmp is mounted on /mnt; on-line resizing required
old desc_blocks =3D 1, new_desc_blocks =3D 1
Performing an on-line resize of /dev/all/tmp to 2883584 (4k) blocks.
The filesystem on /dev/all/tmp is now 2883584 blocks long.

This does not work:

rbd create --size 10240 tmp
rbd info tmp
rbd image 'tmp':
	size 10240 MB in 2560 objects
	order 22 (4096 KB objects)
	block_name_prefix: rb.0.12dd.238e1f29
	format: 1
rbd map tmp
mkfs.ext4 /dev/rbd1
mount /dev/rbd1 /mnt
blockdev --getsize64 /dev/rbd1
10737418240
rbd resize --size 20000 tmp
blockdev --getsize64 /dev/rbd1
10737418240
resize2fs /dev/rbd1=20
resize2fs 1.42 (29-Nov-2011)
The filesystem is already 2621440 blocks long.  Nothing to do!

It does work after umounting:

umount /mnt
blockdev --getsize64 /dev/rbd1
fsck -f /dev/rbd1
resize2fs /dev/rbd1=20
resize2fs 1.42 (29-Nov-2011)
Resizing the filesystem on /dev/rbd1 to 5120000 (4k) blocks.
The filesystem on /dev/rbd1 is now 5120000 blocks long.

I assume there should be "something" in KRBD to allow for the same behavi=
or as with LVM but I don't know enough about the kernel to be more specif=
ic. Maybe something similar to ioctl BLKRRPART ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigEE8CB3E18B49610E44344BD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH244kACgkQ8dLMyEl6F22SMQCbBbBMc8zFV8+sJ9JZ+E4awZOO
eIIAnA9JztjOE3oj1xZgwTFtFxLvhsJL
=N7oW
-----END PGP SIGNATURE-----

--------------enigEE8CB3E18B49610E44344BD6--
