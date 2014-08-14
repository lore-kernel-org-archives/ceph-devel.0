From: Loic Dachary <loic@dachary.org>
Subject: Using erasure code plugins outside of an OSD
Date: Thu, 14 Aug 2014 19:23:26 +0200
Message-ID: <53ECF08E.3070507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8PPhRw31pJepRC6icM27ogQtVPW01fSRs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59547 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932172AbaHNRXd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 13:23:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8PPhRw31pJepRC6icM27ogQtVPW01fSRs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi David,

You presumably want to load a plugin, similar to what

    https://github.com/ceph/ceph/blob/firefly/src/mon/OSDMonitor.cc#L3040=


does. To use it the high level is to be found in

    https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L361

which relies on a thin layer of utilities

    https://github.com/ceph/ceph/blob/master/src/osd/ECUtil.cc

That creates convenience functions that you may or may not need. All plug=
ins implement the API:

    https://github.com/ceph/ceph/blob/master/src/erasure-code/ErasureCode=
Interface.h

and you may not need more than that.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--8PPhRw31pJepRC6icM27ogQtVPW01fSRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPs8I8ACgkQ8dLMyEl6F22meACbBbB0PJxBgfi26Utr9pAwQOef
QjgAniRPAvJW3UZ7wrlMD+EluV0B2o5V
=2X3Z
-----END PGP SIGNATURE-----

--8PPhRw31pJepRC6icM27ogQtVPW01fSRs--
