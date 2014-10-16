From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph performance call:  buffer
Date: Thu, 16 Oct 2014 11:16:47 -0700
Message-ID: <54400B8F.8090204@dachary.org>
References: <1071486299.106.1413482432334.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="g83KrXXctudV3TuA6ScRO5Dr75Hl2nB8R"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46902 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751309AbaJPSQz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 14:16:55 -0400
In-Reply-To: <1071486299.106.1413482432334.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: Casey Bodley <casey@cohortfs.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g83KrXXctudV3TuA6ScRO5Dr75Hl2nB8R
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Matt,

You will probably be interested in


On 16/10/2014 11:00, Matt W. Benjamin wrote:
> Hi Folks,
>=20
> Per yesterday's Ceph performance call, we've pushed 2 wip branches for =
review and feedback to https://github.com/linuxbox2/linuxbox-ceph.git .
>=20
> 1. xio-v084-inline reorganizes ceph::buffer as a namespace, and (nearly=
) all of
> buffer::hash, buffer::ptr and buffer::list as inline
>=20
> 2. xio-v084-inline-flat restores some raw encapsulation lost in the pri=
or change,
> then refactors buffer::raw to remove virtual methods
>=20
> We've made some effort to measure the impact of the changes, but don't =
have
> reliable data yet.  (It's possible that our initial impression of impro=
vement from the inlining change was not accurate, but more likely we need=
 better workload tests.)
>=20
> In addition, we've been working on an experiment to refactor buffer::pt=
r and buffer::raw to use boost::intrusive::list, to unify the interfaces =
of the two types to permit interning buffer::raw directly on the containi=
ng list when there is no sharing, and a slab allocator for both types.  W=
e plan to push a wip branch with these changes to when they've stabilized=
 a bit more and/or we have real perf numbers.
>=20
> Thanks,
>=20
> Matt
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--g83KrXXctudV3TuA6ScRO5Dr75Hl2nB8R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRAC48ACgkQ8dLMyEl6F21RogCgqZXdHiok5+oKm7jtwhKqrWqP
AKIAni8xHWZ2NJXskVlgz2fCnnzcokBK
=0kCW
-----END PGP SIGNATURE-----

--g83KrXXctudV3TuA6ScRO5Dr75Hl2nB8R--
