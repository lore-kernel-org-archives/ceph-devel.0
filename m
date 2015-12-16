From: Loic Dachary <loic@dachary.org>
Subject: Re: cmake
Date: Wed, 16 Dec 2015 18:53:18 +0100
Message-ID: <5671A50E.4060302@dachary.org>
References: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3C0PJopjJQGgGIEGIqBen76Jjrlvvt87k"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51458 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932205AbbLPRx1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 12:53:27 -0500
In-Reply-To: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3C0PJopjJQGgGIEGIqBen76Jjrlvvt87k
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/12/2015 18:33, Sage Weil wrote:
> The work to transition to cmake has stalled somewhat.  I've tried to us=
e=20
> it a few times but keep running into issues that make it unusable for m=
e. =20
> Not having make check is a big one, but I think the hackery required to=
=20
> get that going points to the underlying problem(s).
>=20
> I seems like the main problem is that automake puts all build targets i=
n=20
> src/ and cmake spreads them all over build/*.  This makes that you can'=
t=20
> just add ./ to anything that would normally be in your path (or,=20
> PATH=3D.:$PATH, and then run, say, ../qa/workunits/cephtool/test.sh).  =

> There's a bunch of kludges in vstart.sh to make it work that I think=20
> mostly point to this issue (and the .libs things).  Is there simply an =

> option we can give cmake to make it put built binaries directly in buil=
d/?
>=20
> Stepping back a bit, it seems like the goals should be
>=20
> 1. Be able to completely replace autotools.  I don't fancy maintaining =

> both in parallel.
>=20
> 2. Be able to run vstart etc from the build dir.
>=20
> 3. Be able to run ./ceph[-anything] from the build dir, or put the buil=
d=20
> dir in the path.  (I suppose we could rely in a make install step, but =

> that seems like more hassle... hopefully it's not neceesary?)
>=20
> 4. make check has to work
>=20
> 5. Use make-dist.sh to generate a release tarball (not make dist)
>=20
> 6. gitbuilders use make-dist.sh and cmake to build packages
>=20
> 7. release process uses make-dist.sh and cmake to build a relelase
>=20
> I'm probably missing something?
>=20
> Should we set a target of doing the 10.0.2 or .3 with cmake?

An intermediate step could be to switch from using make check to using ma=
ke distcheck. Once this works, all issues related to out-of-tree build an=
d make check will be resolved. And deprecating autotools in favor of cmak=
e will be just about that.

My 2cts

>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--3C0PJopjJQGgGIEGIqBen76Jjrlvvt87k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZxpQ4ACgkQ8dLMyEl6F21RIQCgw7jlmG7N7w5ccGKNRmrpkCcc
vTsAoMSm1Hx5XAQHfoOHx/JQuCorPZnT
=fArT
-----END PGP SIGNATURE-----

--3C0PJopjJQGgGIEGIqBen76Jjrlvvt87k--
