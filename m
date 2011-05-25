From: Andre Noll <maan@systemlinux.org>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Wed, 25 May 2011 20:45:40 +0200
Message-ID: <20110525184540.GK20417@systemlinux.org>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
 <20110525110118.GA6872@systemlinux.org>
 <Pine.LNX.4.64.1105250913340.29945@cobra.newdream.net>
 <20110525173338.GI20417@systemlinux.org>
 <Pine.LNX.4.64.1105251050030.29945@cobra.newdream.net>
 <20110525182538.GJ20417@systemlinux.org>
 <Pine.LNX.4.64.1105251128530.29945@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tBhgiDt8dP1efIIJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:56700 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab1EYSpG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 14:45:06 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1105251128530.29945@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 11:29, Sage Weil wrote:
> Activated.  Not sure why it doesn't seem to work on its own.

Thanks. The account works now and I've attached the log file. It gets
interesting at line ~18450.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--tBhgiDt8dP1efIIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3dTlQACgkQWto1QDEAkw/ANwCePGQ/SuCXYInOhxjPBYS5XSPL
ZFQAnjIJ1mEUhP6AzS+q42EbBAx1muXl
=qtem
-----END PGP SIGNATURE-----

--tBhgiDt8dP1efIIJ--
