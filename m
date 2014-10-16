From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph performance call:  buffer
Date: Thu, 16 Oct 2014 11:21:00 -0700
Message-ID: <54400C8C.8050006@dachary.org>
References: <1071486299.106.1413482432334.JavaMail.root@thunderbeast.private.linuxbox.com> <54400B8F.8090204@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M5k8ci64BwVnSxtj2PHnPiNo49sTnMgi3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46913 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751810AbaJPSVH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 14:21:07 -0400
In-Reply-To: <54400B8F.8090204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: Casey Bodley <casey@cohortfs.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M5k8ci64BwVnSxtj2PHnPiNo49sTnMgi3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Again,

On 16/10/2014 11:16, Loic Dachary wrote:
> Hi Matt,
>=20
> You will probably be interested in

(I have to find which sequence of keys send out the mail by accident... :=
-)

https://github.com/ceph/ceph/pull/2595

and

https://github.com/dachary/ceph/commit/734e555c640a3b5e9bbf0329bd524cffac=
a61c4f

in particular. It does not do anything performance wise but it's going to=
 be merged in the not-to-distant future.

Cheers

>=20
> On 16/10/2014 11:00, Matt W. Benjamin wrote:
>> Hi Folks,
>>
>> Per yesterday's Ceph performance call, we've pushed 2 wip branches for=
 review and feedback to https://github.com/linuxbox2/linuxbox-ceph.git .
>>
>> 1. xio-v084-inline reorganizes ceph::buffer as a namespace, and (nearl=
y) all of
>> buffer::hash, buffer::ptr and buffer::list as inline
>>
>> 2. xio-v084-inline-flat restores some raw encapsulation lost in the pr=
ior change,
>> then refactors buffer::raw to remove virtual methods
>>
>> We've made some effort to measure the impact of the changes, but don't=
 have
>> reliable data yet.  (It's possible that our initial impression of impr=
ovement from the inlining change was not accurate, but more likely we nee=
d better workload tests.)
>>
>> In addition, we've been working on an experiment to refactor buffer::p=
tr and buffer::raw to use boost::intrusive::list, to unify the interfaces=
 of the two types to permit interning buffer::raw directly on the contain=
ing list when there is no sharing, and a slab allocator for both types.  =
We plan to push a wip branch with these changes to when they've stabilize=
d a bit more and/or we have real perf numbers.
>>
>> Thanks,
>>
>> Matt
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--M5k8ci64BwVnSxtj2PHnPiNo49sTnMgi3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRADIwACgkQ8dLMyEl6F23/2QCgmWCtve7hYSY/FX8dwrmtcCYV
xUcAn36y2qw7+qDifrEdKRGkQBuD6x/V
=BEhA
-----END PGP SIGNATURE-----

--M5k8ci64BwVnSxtj2PHnPiNo49sTnMgi3--
