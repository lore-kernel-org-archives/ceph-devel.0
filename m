From: Andre Noll <maan@systemlinux.org>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Wed, 25 May 2011 19:33:38 +0200
Message-ID: <20110525173338.GI20417@systemlinux.org>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
 <20110525110118.GA6872@systemlinux.org>
 <Pine.LNX.4.64.1105250913340.29945@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:44626 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab1EYRdE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 13:33:04 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1105250913340.29945@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 09:16, Sage Weil wrote:
> > It's trivial to reproduce: Executing "ls -l" on one client while
> > another client is writing causes the ls command to hang indefinitely.
>=20
> This was recently fixed in the master branch, commit
> ee7fa813ef29890557f0b03bd3950d422484215d.  It hasn't made it into any =20
> releases yet.  I'll cherry-pick it into stable for 0.28.2.
>=20
> Please let me know if you continue to see this problem with that fix in=
=20
> place.

Nope. I'm now running the ceph master branch (fe955881) on all nodes
but the problem remains. Even after stopping the writer, the "ls -l"
hangs. Linux kernel version is plain 2.6.38.7 everywhere and the ceph
setup is fairly simple: 6 cosds, one cmon and one cmds.

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3dPXIACgkQWto1QDEAkw8VWQCbBDk2KOBbRWuoiAUUBpbPS6UG
7ccAnj4BklsxwlUSfgtmSyYNmnaPjm7z
=xdwg
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--
