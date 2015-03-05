From: Loic Dachary <loic@dachary.org>
Subject: git submodule deinit
Date: Thu, 05 Mar 2015 22:14:45 +0100
Message-ID: <54F8C745.7030508@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OTPKPJCE4fXDxc6FFaSoxtUmh31tcHjDU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53517 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753353AbbCEVOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 16:14:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OTPKPJCE4fXDxc6FFaSoxtUmh31tcHjDU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Danny,

Unfortunately it looks like submodule deinit requires a version of git th=
at's not in precise.

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-basic/=
log.cgi?log=3D9a0ac62a9cf27573d5345143a3bc6c6b737031db

 + git submodule deinit -f .

    error: pathspec 'deinit' did not match any file(s) known to git.

    error: pathspec '-f' did not match any file(s) known to git.

I'll revert that and go back to rm until we find a better way.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--OTPKPJCE4fXDxc6FFaSoxtUmh31tcHjDU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT4x0UACgkQ8dLMyEl6F2114QCfdmETrqpV8TluQyBuNtzQ+7ep
VEoAnj4da3T6HVejbYW2xC4ZR7AeIAEp
=vALB
-----END PGP SIGNATURE-----

--OTPKPJCE4fXDxc6FFaSoxtUmh31tcHjDU--
