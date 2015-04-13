From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph code tests / teuthology
Date: Mon, 13 Apr 2015 11:18:55 +0200
Message-ID: <552B89FF.70809@dachary.org>
References: <06681238D8946F44A60AA400760A1CBF01F237CC@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="99SvBpj5pIXHFn5sBXvj6RldhgUJCgvKR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45691 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932114AbbDMJS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2015 05:18:58 -0400
In-Reply-To: <06681238D8946F44A60AA400760A1CBF01F237CC@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Zack Cerza <zack@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--99SvBpj5pIXHFn5sBXvj6RldhgUJCgvKR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/04/2015 04:39, Zhou, Yuan wrote:> Hi Loic,
>=20
> =20
>=20
> I=92m trying to setup an internal Teuthology cluster here. I was able t=
o setup a 3 node cluster now. however there=92s not much docs and I=92m c=
onfused about some questions here:
>=20
> =20
>=20
> 1)      how does Ceph upstream do tests? Currently I see there=92s a) J=
ekins(make check on each PR)=20

Yes.

> b) Teuthology Integration tests(on important PR only).
>

The teuthology tests are run either by cron jobs or by people. http://pul=
pito.ceph.com/. They are not run on pull request.

> 2)      Teuthology automatically fetch the binary files from gitbuilder=
=2Eceph.com currently. However the binary will not be built for each pull=
 request?=20

Right. Teuthology can be pointed to an alternate repository but there is =
a catch: it needs to have the same naming conventions as gitbuilder.ceph.=
com. These naming convention are not documented (as far as I know) and yo=
u would need to read the code to figure them out. When I tried to customi=
ze the repository, I replaced the code locating the repository with somet=
hing that was configurable instead (reading the yaml file). But I did it =
in a hackish way and did not take the time to figure out how to contribut=
e that back properly.

> 3)      Can Teuthology working on VMs? I got some info from your blog, =
looks like you=92re running Teuthology on a Openstack/Docker.

The easiest way is to prepare three VMs and make sure you can ssh to them=
 without password. You then create a targets.yaml file with these three m=
achines. And you can run a single job that will use them. It will save yo=
u the trouble of setting up a full teuthology cluster (I think http://dac=
hary.org/?p=3D2204 is still mostly valid). The downside is that it only a=
llows you to run a single job at a time and will not allow you to run teu=
thology-suite to schedule a number of jobs and have them wait in the queu=
e.

I'm not actually using the docker backend I hacked together, therefore I =
don't recommend you try this route, unless you have a week or two to devo=
te to it. =20

> 4)      If I have a working Teuthology cluster now, how do I start a fu=
ll run? or only the workunits/* is good enough?

For instance:

=2E/virtualenv/bin/teuthology-suite --filter-out btrfs,ext4 --priority 10=
00 --suite rados --suite-branch giant --machine-type plana,burnupi,mira -=
-distro ubuntu --email abhishek.lekshmanan@gmail.com --owner abhishek.lek=
shmanan@gmail.com --ceph giant-backports

http://tracker.ceph.com/issues/11153 contains many examples of how teutho=
logy is run to test stable releases.

The easiest way to create a single job probably is to run ./virtualenv/bi=
n/teuthology-suite : it will output calls to teuthology that you can prob=
alby copy / paste to run a single job. I've not tried that and went a mor=
e difficult route instead (manually assembling yaml files to create a job=
).=20

Zack will probably have more hints and advices on how to run your own teu=
thology suite.

Cheers

> =20
>=20
> Thanks for any hints!
>=20
> -yuan
>=20
> =20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--99SvBpj5pIXHFn5sBXvj6RldhgUJCgvKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUrif8ACgkQ8dLMyEl6F21zigCcD8XBtPbPLhG68kL9RHdji1ek
0G8AniHBNxdhy+Xf+YSnecAwxpNWyW0z
=4ZvK
-----END PGP SIGNATURE-----

--99SvBpj5pIXHFn5sBXvj6RldhgUJCgvKR--
