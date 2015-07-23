From: Loic Dachary <loic@dachary.org>
Subject: Re: vstart runner for cephfs tests
Date: Thu, 23 Jul 2015 13:23:12 +0200
Message-ID: <55B0CEA0.80008@dachary.org>
References: <55B0BB59.7010806@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NBo3xahCn6PvSWFegW1xVsIFgq5vPOBAd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54825 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750740AbbGWLXZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jul 2015 07:23:25 -0400
In-Reply-To: <55B0BB59.7010806@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NBo3xahCn6PvSWFegW1xVsIFgq5vPOBAd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi John,

You may be interested by=20

https://github.com/ceph/ceph/blob/master/src/test/ceph-disk-root.sh

which is conditionally included=20

https://github.com/ceph/ceph/blob/master/src/test/Makefile.am#L86

by --enable-root-make-check

https://github.com/ceph/ceph/blob/master/configure.ac#L414

If you're reckless and trust the tests not to break (a crazy proposition =
by definition IMHO ;-), you can

make TESTS=3Dtest/ceph-disk-root.sh check

If you want protection, you do the same in a docker container with

test/docker-test.sh --os-type centos --os-version 7 --dev make TESTS=3Dte=
st/ceph-disk-root.sh check

I tried various strategies to make tests requiring root access more acces=
sible and less scary and that's the best compromise I found. test/docker-=
test.sh is what the make check bot uses.

When a test can be used both from sources and from teuthology, I found it=
 more convenient to have it in the qa/workunits directory which is availa=
ble in both environments. Who knows, maybe you will want a vstart based c=
ephfs test to run as part of make check, in the same way=20

https://github.com/ceph/ceph/blob/master/src/test/cephtool-test-mds.sh

does.

Cheers

On 23/07/2015 12:00, John Spray wrote:
>=20
> Audience: anyone working on cephfs, general testing interest.
>=20
> The tests in ceph-qa-suite/tasks/cephfs are growing in number, but kind=
 of inconvenient to run because they require teuthology (and therefore re=
quire built packages, locked nodes, etc).  Most of them don't actually re=
quire anything beyond what you already have in a vstart cluster, so I've =
adapted them to optionally run that way.
>=20
> The idea is that we can iterate a lot faster when writing new tests (on=
e less excuse not to write them) and get better use out of the tests when=
 debugging things and testing fixes.  teuthology is fine for mass-running=
 the nightlies etc, but it's overkill for testing individual bits of MDS/=
client functionality.
>=20
> The code is currently on the wip-vstart-runner ceph-qa-suite branch, an=
d the two magic commands are:
>=20
> 1. Start a vstart cluster with a couple of MDSs, as your normal user:
> $ make -j4 rados ceph-fuse ceph-mds ceph-mon ceph-osd cephfs-data-scan =
cephfs-journal-tool cephfs-table-tool && ./stop.sh ; rm -rf out dev ; MDS=
=3D2 OSD=3D3 MON=3D1 ./vstart.sh -d -n
>=20
> 2. Invoke the test runner, as root (replace paths, test name as appropr=
iate.  Leave of test name to run everything):
> # PYTHONPATH=3D/home/jspray/git/teuthology/:/home/jspray/git/ceph-qa-su=
ite/ python /home/jspray/git/ceph-qa-suite/tasks/cephfs/vstart_runner.py =
tasks.cephfs.test_strays.TestStrays.test_migration_on_shutdown
>=20
> test_migration_on_shutdown (tasks.cephfs.test_strays.TestStrays) ... ok=

>=20
> ----------------------------------------------------------------------
> Ran 1 test in 121.982s
>=20
> OK
>=20
>=20
> ^^^ see!  two minutes, and no waiting for gitbuilders!
>=20
> The main caveat here is that it needs to run as root in order to mount/=
unmount things, which is a little scary.  My plan is to split it out into=
 a little root service for doing mount operations, and then let the main =
test part run as a normal user and call out to the mounter service when n=
eeded.
>=20
> Cheers,
> John
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--NBo3xahCn6PvSWFegW1xVsIFgq5vPOBAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWwzqAACgkQ8dLMyEl6F22q9ACfZMVfDBo1F0vnc8f4Phv7UBXY
NfMAnicS5nJPpBcE+ORJr0zwtMkxKCSk
=IdqU
-----END PGP SIGNATURE-----

--NBo3xahCn6PvSWFegW1xVsIFgq5vPOBAd--
