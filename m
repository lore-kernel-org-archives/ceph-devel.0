From: Andre Noll <maan@systemlinux.org>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Wed, 25 May 2011 13:01:18 +0200
Message-ID: <20110525110118.GA6872@systemlinux.org>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:58199 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab1EYLHJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 07:07:09 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 22:06, Sage Weil wrote:

> It turns out Henry's problem was actually cause by a bad fix on my part,=
=20
> d91f2438 in ceph-client.git.  (Unfortunately that made it into 2.6.36!) =
=20
> Reverting that commit fixed things for him.

FWIW, I've been seeing this with all versions I tried lately,
including 0.28. Maybe the bug has been reintroduced or we have a
similar bug elsewhere.

It's trivial to reproduce: Executing "ls -l" on one client while
another client is writing causes the ls command to hang indefinitely.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3c4X4ACgkQWto1QDEAkw8tWgCeKSKJmZEx4OZamY6g9WCtpjjM
lWsAnR8TvEoRO9b/Spfd5mA9FaD9y2bL
=MVTa
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
