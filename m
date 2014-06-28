From: Loic Dachary <loic@dachary.org>
Subject: swift test error interpretation
Date: Sat, 28 Jun 2014 12:43:41 +0200
Message-ID: <53AE9C5D.5080801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fhI5LCG5a0NOa5C1XRGsQu8iSoMw0xMms"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59367 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752460AbaF1Knu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jun 2014 06:43:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fhI5LCG5a0NOa5C1XRGsQu8iSoMw0xMms
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The following error was found when running a firefly cluster mixed with a=
n erasure coded related change ( https://github.com/ceph/ceph/pull/1890 )=
=2E The matching teuthology task http://qa-proxy.ceph.com/teuthology/loic=
-2014-06-27_18:45:37-upgrade:firefly-x:stress-split-wip-8475-testing-basi=
c-plana/329523/ is part of an upgrade suite http://pulpito.ceph.com/loic-=
2014-06-27_18:45:37-upgrade:firefly-x:stress-split-wip-8475-testing-basic=
-plana/ that has been generated from a new https://github.com/ceph/ceph-q=
a-suite/tree/master/suites/upgrade suite : https://github.com/ceph/ceph-q=
a-suite/tree/master/suites/upgrade/firefly-x . It was created by copying =
https://github.com/ceph/ceph-qa-suite/tree/master/suites/upgrade/dumpling=
-x , mostly.

Do you have an advice on how to interpret this output ?

Feel free to redirect me to whatever URL if this is something explained e=
lsewhere. Any pointer would be greatly appreciated :-)

Cheers

http://qa-proxy.ceph.com/teuthology/loic-2014-06-27_18:45:37-upgrade:fire=
fly-x:stress-split-wip-8475-testing-basic-plana/329523/

2014-06-27T19:37:39.441 INFO:teuthology.orchestra.run.plana64.stderr:test=
ZeroByteFile (test.functional.tests.TestFileUTF8) ... ok
2014-06-27T19:37:39.441 INFO:teuthology.orchestra.run.plana64.stderr:
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:ERRO=
R: testAccountHead (test.functional.tests.TestAccount)
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:----=
------------------------------------------------------------------
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:Trac=
eback (most recent call last):
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 104, in s=
etUp
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:    =
cls.env.setUp()
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:  Fi=
le "/home/ubuntu/cephtest/swift/test/functional/tests.py", line 140, in s=
etUp
2014-06-27T19:37:39.442 INFO:teuthology.orchestra.run.plana64.stderr:    =
raise ResponseError(cls.conn.response)
2014-06-27T19:37:39.443 INFO:teuthology.orchestra.run.plana64.stderr:Resp=
onseError: 500: Internal Server Error
2014-06-27T19:37:39.443 INFO:teuthology.orchestra.run.plana64.stderr:
2014-06-27T19:37:39.443 INFO:teuthology.orchestra.run.plana64.stderr:----=
------------------------------------------------------------------
2014-06-27T19:37:39.443 INFO:teuthology.orchestra.run.plana64.stderr:Ran =
137 tests in 452.719s
2014-06-27T19:37:39.443 INFO:teuthology.orchestra.run.plana64.stderr:
2014-06-27T19:37:39.443 INFO:teuthology.orchestra.run.plana64.stderr:FAIL=
ED (errors=3D1)
2014-06-27T19:37:39.460 ERROR:teuthology.contextutil:Saw exception from n=
ested tasks
Traceback (most recent call last):
  File "/home/teuthworker/teuthology-master/teuthology/contextutil.py", l=
ine 27, in nested
    vars.append(enter())
  File "/usr/lib/python2.7/contextlib.py", line 17, in __enter__
    return self.gen.next()
  File "/home/teuthworker/teuthology-master/teuthology/task/swift.py", li=
ne 175, in run_tests
    args=3Dargs,
  File "/home/teuthworker/teuthology-master/teuthology/orchestra/cluster.=
py", line 64, in run
    return [remote.run(**kwargs) for remote in remotes]
  File "/home/teuthworker/teuthology-master/teuthology/orchestra/remote.p=
y", line 114, in run
    r =3D self._runner(client=3Dself.ssh, name=3Dself.shortname, **kwargs=
)
  File "/home/teuthworker/teuthology-master/teuthology/orchestra/run.py",=
 line 401, in run
    r.wait()
  File "/home/teuthworker/teuthology-master/teuthology/orchestra/run.py",=
 line 102, in wait
    exitstatus=3Dstatus, node=3Dself.hostname)
CommandFailedError: Command failed on plana64 with status 1: "SWIFT_TEST_=
CONFIG_FILE=3D/home/ubuntu/cephtest/archive/testswift.client.0.conf /home=
/ubuntu/cephtest/swift/virtualen
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--fhI5LCG5a0NOa5C1XRGsQu8iSoMw0xMms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOunF0ACgkQ8dLMyEl6F23zCACgtZHLn+kmMQxLTp8Vk1pzWO+Y
dbgAn2NW7SMNv14ZoOHG8M7e17k8rFpF
=Yix7
-----END PGP SIGNATURE-----

--fhI5LCG5a0NOa5C1XRGsQu8iSoMw0xMms--
