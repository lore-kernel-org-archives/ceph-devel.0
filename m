From: Andre Noll <maan@systemlinux.org>
Subject: Re: Disk utilisation
Date: Tue, 22 Jun 2010 11:28:06 +0200
Message-ID: <20100622092806.GC16886@skl-net.de>
References: <7F0D01755BF855478E2847A50C09FA4DD1A0A94DF4@HERMES8.ds.leeds.ac.uk> <Pine.LNX.4.64.1006210852560.27038@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:55494 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab0FVJ20 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jun 2010 05:28:26 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006210852560.27038@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christopher McLean <C.J.McLean@leeds.ac.uk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 21, 09:02, Sage Weil wrote:
> I would probably allow for 10% utilization variance for a smallish cluste=
r=20
> and maybe another 10% for the rest to be safe.  Something along the lines=
=20
> of total_disk * .8 / replication_level?  You generally shouldn't fill any=
=20
> file system beyond 80% or 90% anyway and expect it to perform well.

Sure, but the thing is users couldn't care less about file system
usage. So at least in a scenario where users write temporary data
=66rom cluster jobs to a world-writable ceph fs, the fs _will_ fill up.

So "you should not fill it beyond 80% anyway" is like asking for
a pony: You won't get it. It is important that filling up the
fs completely does not cause any problems for independent read
operations. Otherwise the fs is next to useless, at least for this
/tmp-like scenario.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMIIImWto1QDEAkw8RArTrAKCk8jSzZrZuauQ1uaKrQGaetpDenACfWG1j
mZawlxG5WT/NUgYaRs3KHvw=
=/P+p
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
