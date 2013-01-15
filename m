From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Grid data placement
Date: Tue, 15 Jan 2013 13:48:58 -0600
Message-ID: <50F5B2AA.6090706@bmrb.wisc.edu>
References: <50F59431.3000401@bmrb.wisc.edu> <CAPYLRzhZdP6ehio9MgOZ7VnPSnMa05NUPmaRG3D_+tmWhe+oYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig128EA372A944CE3D90E09A82"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:45558 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab3AOTs7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 14:48:59 -0500
In-Reply-To: <CAPYLRzhZdP6ehio9MgOZ7VnPSnMa05NUPmaRG3D_+tmWhe+oYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig128EA372A944CE3D90E09A82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/15/2013 12:16 PM, Gregory Farnum wrote:

> There's a "read from replicas" operation flag that allows reading data
> off the local node, although I don't think there's a way to turn it on
> in the standard filesystem clients right now. It wouldn't be hard for
> somebody to add. I'm not sure you actually need it though

PS. it might be a useful switch to add anyway -- from the "better to
have it and never use it" POV.

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig128EA372A944CE3D90E09A82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFQ9bKqxzG8ttqkbbgRAuoJAJ9VEqxCGdmRlxVxqjcNKXZpOXnZaACgt73D
oKBF0HPsnG4Py8RlAEmqfWg=
=/nTh
-----END PGP SIGNATURE-----

--------------enig128EA372A944CE3D90E09A82--
