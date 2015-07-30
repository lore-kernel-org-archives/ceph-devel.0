From: Loic Dachary <loic@dachary.org>
Subject: Re: Breaks & Replaces in debian/control in backports
Date: Thu, 30 Jul 2015 09:28:02 +0200
Message-ID: <55B9D202.8050805@dachary.org>
References: <55AB89C4.50503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="h9DT5VGaSDbKu9NVxOAgxT5t4XevHO8F0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58643 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754595AbbG3H2F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 03:28:05 -0400
In-Reply-To: <55AB89C4.50503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h9DT5VGaSDbKu9NVxOAgxT5t4XevHO8F0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

What I proposed does not actually work because the package versions are n=
ot ceph-0.94.2 but ceph-0.94.2-1trusty ( https://github.com/ceph/ceph-bui=
ld/blob/master/gen_debian_version.sh and https://github.com/ceph/ceph-bui=
ld/blob/master/build_debs.sh#L35) and will therefore match the constraint=
 and upgrading from ceph-0.94.2-1trusty to ceph=3D0.94.2-197-g1e841b0-1tr=
usty or ceph=3D0.94.3-1trusty will not do the right thing:

2015-07-29T22:06:05.579 INFO:teuthology.orchestra.run.ovh228114:Running: =
u'sudo DEBIAN_FRONTEND=3Dnoninteractive apt-get -y --force-yes -o Dpkg::O=
ptions::=3D"--force-confdef" -o Dpkg::Options::=3D"--force-confold" insta=
ll librbd1-dbg=3D0.94.2-197-g1e841b0-1trusty ceph=3D0.94.2-197-g1e841b0-1=
trusty ceph-test=3D0.94.2-197-g1e841b0-1trusty ceph-dbg=3D0.94.2-197-g1e8=
41b0-1trusty rbd-fuse=3D0.94.2-197-g1e841b0-1trusty librados2-dbg=3D0.94.=
2-197-g1e841b0-1trusty ceph-fuse-dbg=3D0.94.2-197-g1e841b0-1trusty libcep=
hfs-jni=3D0.94.2-197-g1e841b0-1trusty libcephfs1-dbg=3D0.94.2-197-g1e841b=
0-1trusty radosgw=3D0.94.2-197-g1e841b0-1trusty librados2=3D0.94.2-197-g1=
e841b0-1trusty libcephfs1=3D0.94.2-197-g1e841b0-1trusty ceph-mds=3D0.94.2=
-197-g1e841b0-1trusty radosgw-dbg=3D0.94.2-197-g1e841b0-1trusty librbd1=3D=
0.94.2-197-g1e841b0-1trusty python-ceph=3D0.94.2-197-g1e841b0-1trusty cep=
h-test-dbg=3D0.94.2-197-g1e841b0-1trusty ceph-fuse=3D0.94.2-197-g1e841b0-=
1trusty ceph-common=3D0.94.2-197-g1e841b0-1trusty libcephfs-java=3D0.94.2=
-197-g1e841b0-1trusty=20
ceph-common-dbg=3D0.94.2-197-g1e841b0-1trusty ceph-mds-dbg=3D0.94.2-197-g=
1e841b0-1trusty'

2015-07-29T22:11:11.258 INFO:teuthology.orchestra.run.ovh228114.stderr:dp=
kg: error processing archive /var/cache/apt/archives/ceph-common_0.94.2-1=
97-g1e841b0-1trusty_amd64.deb (--unpack):
2015-07-29T22:11:11.259 INFO:teuthology.orchestra.run.ovh228114.stderr: t=
rying to overwrite '/usr/lib/python2.7/dist-packages/ceph_argparse.py', w=
hich is also in package ceph 0.94.2-1trusty

The release files found in ceph.com have a fixed prefix ( -1trusty, -1jes=
sie, etc. ) if the version in Breaks and Replaces is -2 it will always be=
 immediately greater. This is not what happens in Debian GNU/Linux or Ubu=
ntu because the package is not part of the sources. When packaging for ce=
ph.com repositories we are creating packages that are native (in the sens=
e that modifying the package requires a new release of the sources becaus=
e the packaging is part of the sources) but contrary to what is usually d=
one with native packages, we append a -XXXX debian version which is suppo=
sed to be the version of the debian directory when it lives outside of th=
e sources.

I filed http://tracker.ceph.com/issues/12529 as "Fix" : it's not a bug bu=
t would definitely make things easier to understand.

Please let me know if I got it right this time ;-)

Cheers

On 19/07/2015 13:28, Loic Dachary wrote:
> Hi Ken,
>=20
> In the context of https://github.com/ceph/ceph/pull/5206 we need to ada=
pt the version constraints for the Breaks / Replaces in debian/control. W=
hat we currently do is something like x.y.z-vvv where we randomly pick vv=
v to be something we're sure won't be greater than the actual vvv from gi=
t-describe that will be associated to this specific commit (otherwise the=
 constraints won't be satisfied and the install will break).=20
>=20
> When backporting it translates into something like:
>=20
> Package: ceph
> Depends: ceph-common (>=3D 0.94.2-23)
>=20
> Package: ceph-common
> Replaces: ceph-client-tools,
> 	  ceph (<< 0.94.2-23),
> Breaks: ceph (<< 0.94.2-23),
>=20
> I propose instead we use the version of the previous stable release lik=
e so:
>=20
> Package: ceph
> Depends: ceph-common (>> 0.94.2)
>=20
> Package: ceph-common
> Replaces: ceph-client-tools,
> 	  ceph (<=3D 0.94.2),
> Breaks: ceph (<=3D 0.94.2),
>=20
> I think it achieves the same thing and is less error prone in the case =
of backports. The risk is that upgrading from v0.94.2-34 to the version w=
ith this change will fail because the conditions are satisified (it think=
s all versions after v0.94.2 have the change). But the odds of having a t=
est machine with this specific version already installed are close to non=
-existent. The odds of us picking the wrong number and ending up with som=
ething that's either too high or too small are higher.
>=20
> What do you think ?
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--h9DT5VGaSDbKu9NVxOAgxT5t4XevHO8F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW50gIACgkQ8dLMyEl6F23M1wCcCgcQXgDY8l795kxTnngsctsd
wYAAoJ4zajZi5w/hE1C+FF3+JyE4Eqg4
=mdP8
-----END PGP SIGNATURE-----

--h9DT5VGaSDbKu9NVxOAgxT5t4XevHO8F0--
