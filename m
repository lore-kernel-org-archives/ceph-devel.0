From: Matthew Richardson <m.richardson@ed.ac.uk>
Subject: Re: Ceph write performance
Date: Fri, 20 Jul 2012 16:53:04 +0100
Message-ID: <50097EE0.4030603@ed.ac.uk>
References: <500931CF.9040407@selectel.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig67CAD26588A38EFD8B99A051"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from treacle.ucs.ed.ac.uk ([129.215.16.102]:61090 "EHLO
	treacle.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab2GTPxW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 11:53:22 -0400
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by treacle.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q6KFr83f026403
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 16:53:14 +0100 (BST)
Received: from [129.215.183.3] (pcw3047.see.ed.ac.uk [129.215.183.3])
	(authenticated user=mrichar1 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q6KFr4pn011281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 16:53:08 +0100 (BST)
In-Reply-To: <500931CF.9040407@selectel.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67CAD26588A38EFD8B99A051
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/07/12 11:24, George Shuklin wrote:
> Good day.
>=20
> I've start to play with Ceph... And I found some kinda strange
> performance issues. I'm not sure if this is due ceph limitation or my
> bad setup.

I'm seeing a similar problem which looks like a potential bug, which
someone else seems to have already reported

(http://www.spinics.net/lists/ceph-devel/msg07335.html and
http://www.spinics.net/lists/ceph-devel/msg07691.html)

The problem only seems to hit for me when I do random writes - can you
try fio with sequential writes (rw=3Dwrite) and see if your problem also
disappears?  It might help confirm this as an issue.

Thanks,

Matthew



--=20
The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.


--------------enig67CAD26588A38EFD8B99A051
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAJfuAACgkQRWpi1WYCQdJYyQCeP4ru7VUY5vUmgtNMLvckQ5ef
AnkAn3R6oqbE58M2Ew4HqzX2krV3M+53
=vu2+
-----END PGP SIGNATURE-----

--------------enig67CAD26588A38EFD8B99A051--
