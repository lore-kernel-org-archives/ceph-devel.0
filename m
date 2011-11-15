From: Andre Noll <maan@systemlinux.org>
Subject: Re: v0.38 released
Date: Tue, 15 Nov 2011 17:42:54 +0100
Message-ID: <20111115164254.GJ13394@systemlinux.org>
References: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZY5CS28jBCfb727c"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([79.140.41.46]:46023 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab1KOQvG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 11:51:06 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--ZY5CS28jBCfb727c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 21:14, Sage Weil wrote:
>  * osd: some peering refactoring
>  * osd: 'replay' period is per-pool (now only affects fs data pool)
>  * osd: clean up old osdmaps
>  * osd: allow admin to revert lost objects to prior versions (or delete)
>  * mkcephfs: generate reasonable crush map based on 'host' and 'rack'=20
>    fields in [osd.NN] sections of ceph.conf
>  * radosgw: bucket index improvements
>  * radosgw: improved swift support
>  * rbd: misc command line tool fixes
>  * debian: misc packaging fixes (including dependency breakage on upgrade=
s)
>  * ceph: query daemon perfcounters via command line tool
>=20
> The big upcoming items for v0.39 are RBD layering (image cloning), furthe=
r=20
> improvements to radosgw's Swift support, and some monitor failure recover=
y=20
> and bootstrapping improvements.  We're also continuing work on the=20
> automation bits that the Chef cookbooks and Juju charms will use, and a=
=20
> Crowbar barclamp was also just posted on github.  Several patches are=20
> still working their way into libvirt and qemu to improve support for RBD=
=20
> authentication.

Any plans to address the ENOSPC issue? I gave v0.38 a try and the
file system behaves like the older (<=3D 0.36) versions I've tried
before when it fills up: The ceph mounts hang on all clients.

But there is progress: Sync is now interuptable (it used to block
in D state so that it could not be killed even with SIGKILL), and
umount works even if the file system is full. However, subsequent
mount attempts then fail with "mount error 5 =3D Input/output error".

Our test setup consists of one mds, one monitor and 8 osds. mds and
monitor are on the same node, and this node is not not an osd. All
nodes are running Linux-3.0.9 ATM, but I would be willing to upgrade
to 3.1.1 if this is expected to make a difference.

Here's some output of "ceph -w". Funny enough it reports 770G of free
disk space space although the writing process terminated with ENOSPC.

2011-11-15 12:12:45.388535    pg v38805: 65940 pgs: 1956 creating, 63984 ac=
tive+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avail
2011-11-15 12:12:45.589228   mds e4: 1/1/1 up {0=3D0=3Dup:active}
2011-11-15 12:12:45.589326   osd e11: 8 osds: 8 up, 8 in full
2011-11-15 12:12:45.589908   log 2011-11-15 12:12:19.599894 osd.326 192.168=
=2E3.26:6800/1673 168 : [INF] 0.593 scrub ok
2011-11-15 12:12:45.590000   mon e1: 1 mons at {0=3D192.168.3.34:6789/0}
2011-11-15 12:12:49.554163    pg v38806: 65940 pgs: 1956 creating, 63984 ac=
tive+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avail
2011-11-15 12:12:54.526661    pg v38807: 65940 pgs: 1956 creating, 63984 ac=
tive+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avail
2011-11-15 12:12:56.309292    pg v38808: 65940 pgs: 1956 creating, 63984 ac=
tive+clean; 1856 GB data, 3730 GB used, 770 GB / 4600 GB avail

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--ZY5CS28jBCfb727c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7Clo4ACgkQWto1QDEAkw+3JQCcCjscFf4sd2u2KDI8q2JJMl20
MQgAni/PhxefTHBiM6bnGYVkVMZgjEf/
=csMu
-----END PGP SIGNATURE-----

--ZY5CS28jBCfb727c--
