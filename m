From: Jonathan Dieter <jdieter@lesbg.com>
Subject: Re: ceph 0.44+ and leveldb
Date: Fri, 06 Apr 2012 22:53:15 +0300
Message-ID: <1333741995.2114.15.camel@jdlaptop.lesbg.loc>
References: <1333689498.19737.11.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1204060943510.3020@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-SLsCTz1oI0ndxv8KXrFi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:45503 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757882Ab2DFTxU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 15:53:20 -0400
Received: by wgbds11 with SMTP id ds11so788532wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 06 Apr 2012 12:53:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204060943510.3020@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Laszlo Boszormenyi <gcs@debian.hu>, ceph-devel@vger.kernel.org


--=-SLsCTz1oI0ndxv8KXrFi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-04-06 at 09:49 -0700, Sage Weil wrote:
> The problem here is that libleveldb-dev is only packaged for wheezy and=
=20
> precise, and we'd like to build packages for squeeze and oneiric, and=20
> make the build experience easy for non-debian/ubuntu users.  (I didn't=
=20
> check whether it was in rpm-based distros.)

It's not in Fedora (and probably not in RHEL/CentOS/ScientificLinux,
etc).  However, Fedora's policy is that bundled libraries aren't
allowed, so we (as in Fedora) really should be packaging leveldb
separately ourselves.

> I think the ideal situation would be for the debs to build against the=
=20
> debian package, and allow others an easy way to get the correct source=
=20
> (by bundling it in the ceph source tarball, or via a simple build script=
=20
> that does the equivalent of git submodule update --init).
>=20
> Do you have a clear picture of how that would work?

One common way would be to have a flag for ./configure, something like
--use-system-leveldb, that would disable building the bundled leveldb.

I'm afraid I know next to nothing about autotools, so I'm not sure how
exactly it's done, but I don't think it's particularly complex for
someone who does know how to use autotools.

Jonathan

--=-SLsCTz1oI0ndxv8KXrFi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAk9/SawACgkQH3CnpFdSY1ykAgCfTGaam+LfLfEVYtntj39W1Qk3
PtkAn2FUr0NtrlYGgBKC08I249chuKCS
=9CIz
-----END PGP SIGNATURE-----

--=-SLsCTz1oI0ndxv8KXrFi--

