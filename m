From: Loic Dachary <loic@dachary.org>
Subject: Re: vstart runner for cephfs tests
Date: Thu, 23 Jul 2015 14:37:44 +0200
Message-ID: <55B0E018.9040204@dachary.org>
References: <55B0BB59.7010806@redhat.com> <55B0CEA0.80008@dachary.org> <55B0DF47.3040704@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dPRsA0lCR8Qm1VcwVMajEINppb0CgCSQo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54890 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752204AbbGWMhv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jul 2015 08:37:51 -0400
In-Reply-To: <55B0DF47.3040704@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dPRsA0lCR8Qm1VcwVMajEINppb0CgCSQo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/07/2015 14:34, John Spray wrote:>=20
>=20
> On 23/07/15 12:23, Loic Dachary wrote:
>> You may be interested by
>>
>> https://github.com/ceph/ceph/blob/master/src/test/ceph-disk-root.sh
>>
>> which is conditionally included
>>
>> https://github.com/ceph/ceph/blob/master/src/test/Makefile.am#L86
>>
>> by --enable-root-make-check
>>
>> https://github.com/ceph/ceph/blob/master/configure.ac#L414
>>
>> If you're reckless and trust the tests not to break (a crazy propositi=
on by definition IMHO ;-), you can
>>
>> make TESTS=3Dtest/ceph-disk-root.sh check
>>
>> If you want protection, you do the same in a docker container with
>>
>> test/docker-test.sh --os-type centos --os-version 7 --dev make TESTS=3D=
test/ceph-disk-root.sh check
>>
>> I tried various strategies to make tests requiring root access more ac=
cessible and less scary and that's the best compromise I found. test/dock=
er-test.sh is what the make check bot uses.
>=20
> Interesting, I didn't realise we already had root-ish tests in there.
>=20
> At some stage the need for root may go away in ceph-fuse, as in princip=
le fuse mount/unmounts shouldn't require root.  If not then putting an ou=
ter docker wrapper around this could make sense, if we publish the built =
binaries into the docker container via a volume or somesuch.  I am behind=
 on familiarizing myself with the dockerised tests.

The docker container runs from sources, not from packages.=20

>=20
>> When a test can be used both from sources and from teuthology, I found=
 it more convenient to have it in the qa/workunits directory which is ava=
ilable in both environments. Who knows, maybe you will want a vstart base=
d cephfs test to run as part of make check, in the same way
>>
>> https://github.com/ceph/ceph/blob/master/src/test/cephtool-test-mds.sh=

>>
>> does.
>=20
> Yes, this crossed my mind.  At the moment, even many of the "quick" tes=
ts/cephfs tests take tens of seconds, so they are probably a bit too big =
to go in a default make check, but for some of the really simple things t=
hat are currently done in cephtool/test.sh, I would be temped to move the=
m into the python world to make them a bit less fiddly.
>=20
> The test location is a bit challenging, because we essentially have two=
 not-completely-stable interfaces here, vstart and teuthology. Because te=
uthology is the more complicated, for the moment it makes sense for the t=
ests to live in that git repo.  Long term it would be nice if fine-graine=
d functional tests lived in the same git repo as the code they're testing=
, but I don't really have a plan for that right now outside of the probab=
ly-too-radical step of merging ceph-qa-suite into the ceph repo.
>=20
> John

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--dPRsA0lCR8Qm1VcwVMajEINppb0CgCSQo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWw4BkACgkQ8dLMyEl6F21LSACgkmZr3B18+2eFN5xadM/v4SM+
ts4An2qRqavoqUF2yxpESkQZZ778hF0d
=wD7j
-----END PGP SIGNATURE-----

--dPRsA0lCR8Qm1VcwVMajEINppb0CgCSQo--
