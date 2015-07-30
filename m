From: Loic Dachary <loic@dachary.org>
Subject: Re: Breaks & Replaces in debian/control in backports
Date: Thu, 30 Jul 2015 21:47:13 +0200
Message-ID: <55BA7F41.8060801@dachary.org>
References: <55AB89C4.50503@dachary.org> <55B9D202.8050805@dachary.org> <alpine.DEB.2.00.1507300524200.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XLT3Vl8DDUsl33LKJkLu655sJfhBpesCk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59002 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbbG3TrU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 15:47:20 -0400
In-Reply-To: <alpine.DEB.2.00.1507300524200.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XLT3Vl8DDUsl33LKJkLu655sJfhBpesCk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage :-)

On 30/07/2015 14:25, Sage Weil wrote:
> On Thu, 30 Jul 2015, Loic Dachary wrote:
>> Hi,
>>
>> What I proposed does not actually work because the package versions ar=
e not ceph-0.94.2 but ceph-0.94.2-1trusty ( https://github.com/ceph/ceph-=
build/blob/master/gen_debian_version.sh and https://github.com/ceph/ceph-=
build/blob/master/build_debs.sh#L35) and will therefore match the constra=
int and upgrading from ceph-0.94.2-1trusty to ceph=3D0.94.2-197-g1e841b0-=
1trusty or ceph=3D0.94.3-1trusty will not do the right thing:
>>
>> 2015-07-29T22:06:05.579 INFO:teuthology.orchestra.run.ovh228114:Runnin=
g: u'sudo DEBIAN_FRONTEND=3Dnoninteractive apt-get -y --force-yes -o Dpkg=
::Options::=3D"--force-confdef" -o Dpkg::Options::=3D"--force-confold" in=
stall librbd1-dbg=3D0.94.2-197-g1e841b0-1trusty ceph=3D0.94.2-197-g1e841b=
0-1trusty ceph-test=3D0.94.2-197-g1e841b0-1trusty ceph-dbg=3D0.94.2-197-g=
1e841b0-1trusty rbd-fuse=3D0.94.2-197-g1e841b0-1trusty librados2-dbg=3D0.=
94.2-197-g1e841b0-1trusty ceph-fuse-dbg=3D0.94.2-197-g1e841b0-1trusty lib=
cephfs-jni=3D0.94.2-197-g1e841b0-1trusty libcephfs1-dbg=3D0.94.2-197-g1e8=
41b0-1trusty radosgw=3D0.94.2-197-g1e841b0-1trusty librados2=3D0.94.2-197=
-g1e841b0-1trusty libcephfs1=3D0.94.2-197-g1e841b0-1trusty ceph-mds=3D0.9=
4.2-197-g1e841b0-1trusty radosgw-dbg=3D0.94.2-197-g1e841b0-1trusty librbd=
1=3D0.94.2-197-g1e841b0-1trusty python-ceph=3D0.94.2-197-g1e841b0-1trusty=
 ceph-test-dbg=3D0.94.2-197-g1e841b0-1trusty ceph-fuse=3D0.94.2-197-g1e84=
1b0-1trusty ceph-common=3D0.94.2-197-g1e841b0-1trusty libcephfs-java=3D0.=
94.2-197-g1e84!
>  1b0-1trusty=20
>> ceph-common-dbg=3D0.94.2-197-g1e841b0-1trusty ceph-mds-dbg=3D0.94.2-19=
7-g1e841b0-1trusty'
>>
>> 2015-07-29T22:11:11.258 INFO:teuthology.orchestra.run.ovh228114.stderr=
:dpkg: error processing archive /var/cache/apt/archives/ceph-common_0.94.=
2-197-g1e841b0-1trusty_amd64.deb (--unpack):
>> 2015-07-29T22:11:11.259 INFO:teuthology.orchestra.run.ovh228114.stderr=
: trying to overwrite '/usr/lib/python2.7/dist-packages/ceph_argparse.py'=
, which is also in package ceph 0.94.2-1trusty
>>
>> The release files found in ceph.com have a fixed prefix ( -1trusty, -1=
jessie, etc. ) if the version in Breaks and Replaces is -2 it will always=
 be immediately greater. This is not what happens in Debian GNU/Linux or =
Ubuntu because the package is not part of the sources. When packaging for=
 ceph.com repositories we are creating packages that are native (in the s=
ense that modifying the package requires a new release of the sources bec=
ause the packaging is part of the sources) but contrary to what is usuall=
y done with native packages, we append a -XXXX debian version which is su=
pposed to be the version of the debian directory when it lives outside of=
 the sources.
>>
>> I filed http://tracker.ceph.com/issues/12529 as "Fix" : it's not a bug=
 but would definitely make things easier to understand.
>>
>> Please let me know if I got it right this time ;-)
>=20
> Should we just drop the suffix?  I tried to match up with the backport =

> suffixes (e.g., ~bpo70 for wheezy) so that when you did a dist-upgrade =
it=20
> would be able to pull in the next version.  It sounds like it's not=20
> worth it, though...

The suffix should indeed be dropped entirely: native packages do not have=
 a suffix (i.e. debian version) because the debian directory is in the so=
urce tree. Given the number of scripts that depend on this, I suppose dro=
pping the suffix would require a lot of testing to make sure it does not =
break something somewhere.

Cheers
>=20
> sage
>=20
>=20
>>
>> Cheers
>>
>> On 19/07/2015 13:28, Loic Dachary wrote:
>>> Hi Ken,
>>>
>>> In the context of https://github.com/ceph/ceph/pull/5206 we need to a=
dapt the version constraints for the Breaks / Replaces in debian/control.=
 What we currently do is something like x.y.z-vvv where we randomly pick =
vvv to be something we're sure won't be greater than the actual vvv from =
git-describe that will be associated to this specific commit (otherwise t=
he constraints won't be satisfied and the install will break).=20
>>>
>>> When backporting it translates into something like:
>>>
>>> Package: ceph
>>> Depends: ceph-common (>=3D 0.94.2-23)
>>>
>>> Package: ceph-common
>>> Replaces: ceph-client-tools,
>>> 	  ceph (<< 0.94.2-23),
>>> Breaks: ceph (<< 0.94.2-23),
>>>
>>> I propose instead we use the version of the previous stable release l=
ike so:
>>>
>>> Package: ceph
>>> Depends: ceph-common (>> 0.94.2)
>>>
>>> Package: ceph-common
>>> Replaces: ceph-client-tools,
>>> 	  ceph (<=3D 0.94.2),
>>> Breaks: ceph (<=3D 0.94.2),
>>>
>>> I think it achieves the same thing and is less error prone in the cas=
e of backports. The risk is that upgrading from v0.94.2-34 to the version=
 with this change will fail because the conditions are satisified (it thi=
nks all versions after v0.94.2 have the change). But the odds of having a=
 test machine with this specific version already installed are close to n=
on-existent. The odds of us picking the wrong number and ending up with s=
omething that's either too high or too small are higher.
>>>
>>> What do you think ?
>>>
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--XLT3Vl8DDUsl33LKJkLu655sJfhBpesCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW6f0EACgkQ8dLMyEl6F21pzQCgi4b4kpGooZAiePFqJGhJkjXW
FZUAoLG03Ydov+z9rmLD2KFQ8h7qBZpa
=y62A
-----END PGP SIGNATURE-----

--XLT3Vl8DDUsl33LKJkLu655sJfhBpesCk--
