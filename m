From: Loic Dachary <loic@dachary.org>
Subject: Erasure encoding as a storage backend
Date: Sat, 04 May 2013 19:16:59 +0200
Message-ID: <5185428B.6070109@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5809B65F78620C2F4E017881"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42796 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761726Ab3EDRRE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 May 2013 13:17:04 -0400
Received: from [10.8.0.50] (unknown [10.8.0.50])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 5BD5426394
	for <ceph-devel@vger.kernel.org>; Sat,  4 May 2013 19:17:00 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5809B65F78620C2F4E017881
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Here is an updated description of the "Erasure encoding as a storage back=
end" proposed implementation that will be discussed during the ceph summi=
t ( http://wiki.ceph.com/01Planning/Developer_Summit#Schedule ). The "str=
ip" and "stripe" terms are illustrated at http://wiki.ceph.com/01Planning=
/02Blueprints/Dumpling/Erasure_encoding_as_a_storage_backend#Proposed_mod=
el .=20

I am well aware of the shortcomings of this proposal and it would be grea=
t to get feedback before the ceph summit to address the most prominent is=
sues.

Cheers

http://pad.ceph.com/p/Erasure_encoding_as_a_storage_backend

	* PG and ReplicatedPG are reworked so that PG can be used as a base clas=
s for ErasureEncodedPG
		* Tests are written for ReplicatedPG to cover 100% of the LOC and most =
of the expected functionalities.
		* Code is reworked in PG and ReplicatedPG, moving from ReplicatedPG to =
PG code that is not unique to replication and from PG to ReplicatedPG cod=
e that is not generic enough to be useful for the ErasureEncodedPG base c=
lass.
	* To isolates ceph from the actual library being used ( zfec, fecpp, ...=
 ), a wrapper around the erasure encoding library is implemented. Each bl=
ock is encoded into k data blocks and m parity blocks
		* encode(void* data, k, m) =3D> void* data[k], void* parity[m]
		* decode(void* data[k], void* parity[m]) =3D> void* data
		* repair(void* data[k], void* parity[m], indices_of_damaged_blocks[]) =3D=
> void* data
	* The ErasureEncodePG configuration is set to encode each object into k =
data objects and m parity objects.=20
		* It use the parity ('INDEP') crush mode so that placement is intellige=
nt. The indep  placement avoids moving around a shard between ranks, beca=
use a mapping  of [0,1,2,3,4] will change to [0,6,2,3,4] (or something) i=
f osd.1 fails  and the shards on 2,3,4 won't need to be copied around.
		* The ErasureEncodedPG uses k + m OSDs, numbered Do .. Dk-1 and C0 ... =
Cm-1
		* Each object is a strip
		* Each stripe has a fixed size of B bytes
	* ErasureEncodedPG implementation
		* Write offset, length
			* read the stripes containing offset, length
			* for each stripe, decode(void* data[k], void* parity[m]) =3D> void* d=
ata and append to a bufferlist
			* modify the bufferlist with the write request
			* encode(void* data, k, m) =3D> void* data[k], void* parity[m]
			* write data[0] to Do, data[1] to D1 ... data[k-1] to Dk-1 and parity[=
0] to C0 ... parity[m-1] to Cm-1
		* Read offset, length
			* read the stripes containing offset
			* for each strip, decode(void* data[k], void* parity[m]) =3D> void* da=
ta and append to a bufferlist
		* Object attributes
			* duplicate the object attributes on each OSD
		* Scrubbing
			* for each object, read each stripe and write back if a repair was nec=
essary
		* Repair
			* when an OSD is decomissioned, when another OSD replaces it, for each=
 object contained in a ErasureEncodedPG using this OSD, read the object, =
repair each strips and write back the strip that resides on the new OSD


--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig5809B65F78620C2F4E017881
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGFQosACgkQ8dLMyEl6F21ASgCgvHeyd7QmNkD+05xiEiZRGiSQ
eOkAn0F8gRmyh05JkurQZ9siYwYE+gWa
=iw7r
-----END PGP SIGNATURE-----

--------------enig5809B65F78620C2F4E017881--
