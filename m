From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: ceph-fuse mount options
Date: Sat, 8 Sep 2012 09:05:28 +0100
Message-ID: <20120908080528.GA7184@tchpc.tcd.ie>
References: <C601985E-3865-4582-99DA-BC0168893968@tchpc.tcd.ie> <sfid-H20120907-172240-+039.55-1@marduk.tchpc.tcd.ie> <CAPYLRzgc_-9nTE+-Y6rm9aiBBVeEMZTfBs-ycRw3cFV8tL2AHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:40017 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab2IHIFa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Sep 2012 04:05:30 -0400
Content-Disposition: inline
In-Reply-To: <CAPYLRzgc_-9nTE+-Y6rm9aiBBVeEMZTfBs-ycRw3cFV8tL2AHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2012 at 09:22:34AM -0700, Gregory Farnum wrote:
> On Fri, Sep 7, 2012 at 9:03 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> > Hi All,
> >
> > I know that cephfs has the option picking which pools to use, will ceph=
-fuse be gaining this feature at any point in the future? Or is this featur=
e available but isn't documented?
>=20
> It's not available ?=A0making it work would require implementing FUSE's
> ioctl system, which we will probably do at some point, but is yet to
> be prioritized or placed anywhere.
>=20
> However, ceph-fuse does of course respect settings put in place by the
> kernel client, so if you just want to do a one-time configuration then
> you can do it via the kernel on one machine and use ceph-fuse
> elsewhere...


Ok thanks, thats good to know that it's probably on the roadmap. I
don't forsee us using the fuse module much, it's really only for
testing on RHEL6 based systems as the kernel hasn't quite caught up.

Jimmy

--=20
Jimmy Tang
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAlBK/EQACgkQmRvHlXBDSyk5ZACgmJHZElV8XY70DuRmN+ANXGqa
+1AAnjjRTrNe0wqXHIbIm7CTy+cUWNq5
=NQqw
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
