From: Andre Noll <maan@systemlinux.org>
Subject: Re: Correct proceedure for removing ceph nodes
Date: Mon, 7 Jun 2010 10:10:48 +0200
Message-ID: <20100607081048.GW1211@skl-net.de>
References: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com> <Pine.LNX.4.64.1006021122300.1269@cobra.newdream.net> <20100604130359.GT1211@skl-net.de> <Pine.LNX.4.64.1006040951210.2384@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D2rVImvqWGvKULsk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:58100 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755444Ab0FGILC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jun 2010 04:11:02 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006040951210.2384@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Paul <paul_chiang@tcloudcomputing.com>, ceph-devel@vger.kernel.org


--D2rVImvqWGvKULsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 09:52, Sage Weil Wrote
> > IOW, something like the "clone failing disk" feature of some hardware
> > raids or LVM's pvmove. The idea is to first mirror all data on two
> > disks/PVs/OSDs and to kick out one only after mirroring is complete.
>=20
> You basically get this by marking the osd 'out' but not 'down', e.g.,
>=20
>  $ ceph osd out 23   # mark out osd23
>=20
> The data on osd23 isn't removed until the pg is fully replicated/migrated=
=20
> to it's new location.

Wow, that's awesome!

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--D2rVImvqWGvKULsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMDKmIWto1QDEAkw8RAvOMAJkB9vR93j5kS9VQzDN9IOArod/sOACfW3Oe
sjvJ3bOKZqzCkyAzYPpQWO4=
=j1Vc
-----END PGP SIGNATURE-----

--D2rVImvqWGvKULsk--
