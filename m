From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Grid data placement
Date: Tue, 15 Jan 2013 11:38:57 -0600
Message-ID: <50F59431.3000401@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig91FEE9FEABD3F25A90219824"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:45147 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab3AORpM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 12:45:12 -0500
Received: from stingray.bmrb.wisc.edu (stingray.bmrb.wisc.edu [144.92.167.179])
	by mail.bmrb.wisc.edu (Postfix) with ESMTP id 2DE292C00EF
	for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 11:39:07 -0600 (CST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91FEE9FEABD3F25A90219824
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everyone,

quick question: can I get ceph to replicate a bunch of files to every
host in compute cluster and then have those hosts read those files from
local disk?

TFM looks like a custom crush map should get the files to [osd on] every
host, but I'm not clear on the read step: do I need an mds on every host
and mount the fs off localhost's mds?

(We've $APP running on the cluster, normally one instance/cpu core, that
mmap's (read only) ~30GB of binary files. I/O over NFS kills the cluster
even with a few hosts. Currently the files are rsync'ed to every host at
the start of the batch; that'll only scale to a few dozen hosts at best.)=


TIA,
--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu




--------------enig91FEE9FEABD3F25A90219824
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFQ9ZQ7xzG8ttqkbbgRAsiJAJ9prPu5wnGwuh6iIOgIBahDXBWdlACfQIzT
RNDv4EnaZA0Xqb33BgRWyf4=
=emjZ
-----END PGP SIGNATURE-----

--------------enig91FEE9FEABD3F25A90219824--
