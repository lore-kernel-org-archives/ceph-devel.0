From: Andre Noll <maan@systemlinux.org>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Wed, 25 May 2011 20:25:38 +0200
Message-ID: <20110525182538.GJ20417@systemlinux.org>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
 <20110525110118.GA6872@systemlinux.org>
 <Pine.LNX.4.64.1105250913340.29945@cobra.newdream.net>
 <20110525173338.GI20417@systemlinux.org>
 <Pine.LNX.4.64.1105251050030.29945@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enLffk0M6cffIOOh"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:33408 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab1EYSZD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 14:25:03 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1105251050030.29945@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--enLffk0M6cffIOOh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 10:52, Sage Weil wrote:
> > Nope. I'm now running the ceph master branch (fe955881) on all nodes
> > but the problem remains. Even after stopping the writer, the "ls -l"
> > hangs. Linux kernel version is plain 2.6.38.7 everywhere and the ceph
> > setup is fairly simple: 6 cosds, one cmon and one cmds.
>=20
> I created a new bug (http://tracker.newdream.net/issues/1110) for this.=
=20

Thanks.

> Can you generate an mds log for this

done.

> and attach it to the bug?

I've created an account (maan) for me but I can't login. The login
attempt fails with "invalid user or password". I've clicked on "lost
password" to make the tracker send the password back to me. This
worked and I was able to change the password but I still can't log in.

Anyway, I've put the log file on my server:

	http://systemlinux.org/~maan/mds.0.log.gz

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--enLffk0M6cffIOOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3dSaIACgkQWto1QDEAkw+k5gCeKW0iL5F37cyctbt9ekBcKfC3
QdAAoIkk/Opxi1VzTno856Oq01OhAAh3
=GHAq
-----END PGP SIGNATURE-----

--enLffk0M6cffIOOh--
