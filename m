From: Loic Dachary <loic@dachary.org>
Subject: crc32 for erasure code
Date: Mon, 23 Sep 2013 10:34:35 +0200
Message-ID: <523FFD1B.4030801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0D6E65A0E32A6A10A0BB809C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42433 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab3IWIor (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 04:44:47 -0400
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 741D426395
	for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 10:44:44 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D6E65A0E32A6A10A0BB809C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Unless I'm mistaken, ceph_crc32() is currently used in master via the crc=
32c() method of bufferlist to:

* encode_with_checksum/decode_with_checksum a PGLog entry
* Message::decode_message/Message::encode_message a message via calc_*_cr=
c=20
* FileJournal::do_read_entry/FileJournal::prepare_single_write a journal =
entry
* for information in the report monitory command ( Monitor.cc )

Erasure coded chunks ( i.e. files ) will need checksums. Should this be i=
mplemented as an optional feature in ceph/src/os/FileStore.{h,cc} ? If th=
e underlying filesystem does not provide this feature, FileStore would ca=
ll ceph_crc32 each time the object is modified. A verification method wou=
ld be exposed and used when scrubbing erasure coded pools.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig0D6E65A0E32A6A10A0BB809C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI//RsACgkQ8dLMyEl6F23aCACgti0q5nyD5XZu6DUjknEq63QT
sRcAn1ixLMq/Fk+ox8W1lu4e7gleOHdr
=IJz0
-----END PGP SIGNATURE-----

--------------enig0D6E65A0E32A6A10A0BB809C--
