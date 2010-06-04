From: Andre Noll <maan@systemlinux.org>
Subject: Re: Correct proceedure for removing ceph nodes
Date: Fri, 4 Jun 2010 15:03:59 +0200
Message-ID: <20100604130359.GT1211@skl-net.de>
References: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com> <Pine.LNX.4.64.1006021122300.1269@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:43614 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915Ab0FDNEU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jun 2010 09:04:20 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006021122300.1269@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Paul <paul_chiang@tcloudcomputing.com>, ceph-devel@vger.kernel.org


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 11:30, Sage Weil Wrote
> > 3. OSD:
> >    Again, I suppose we could just kill the daemon, but that'd leave
> > holes in the data placement which doesn't seem to be very elegant.
> > Setting the device weight to 0 in the crushmap works, but trying to
> > remove a device entriely produces strange results. Could you shed some
> > light on this?
>=20
> There are a few ways to go about it.  Simply marking the osd 'out' ('ceph=
=20
> osd out #') will work, but may not be optimal depending on how the crush=
=20
> map is set up.  The default crush maps use the 'straw' bucket type=20
> everywhere, which deals with addition/removal optimally, so taking the=20
> additional step of removing the item from the crush map will keep things=
=20
> tidy and erase all trace of the osd.

BTW: It would be nice to be able to _replace_ an OSD without having
a time window during which there is less redundancy.

IOW, something like the "clone failing disk" feature of some hardware
raids or LVM's pvmove. The idea is to first mirror all data on two
disks/PVs/OSDs and to kick out one only after mirroring is complete.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMCPm/Wto1QDEAkw8RAi4dAJ9HT6/hNbJCjzd5rYVJS7S8rh02iwCfZhko
8vjP4Caq5+l/upp2JU7ahwY=
=8xWt
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
