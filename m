From: Loic Dachary <loic@dachary.org>
Subject: Firefly upgrade tests
Date: Fri, 04 Jul 2014 00:39:46 +0200
Message-ID: <53B5DBB2.90503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8Jio6qD9730QNP3IiklrS8VGSg5fr4JKJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37342 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753035AbaGCWjx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 18:39:53 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 3CF0C420A9
	for <ceph-devel@vger.kernel.org>; Fri,  4 Jul 2014 00:39:46 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Jio6qD9730QNP3IiklrS8VGSg5fr4JKJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The firefly-x test upgrade suite is designed to check that upgrading from=
 Firefly to a newer version (master or a branch) works as expected. It wa=
s created it by copying dumpling-x and can be browsed at https://github.c=
om/ceph/ceph-qa-suite/tree/master/suites/upgrade/firefly-x

To establish a baseline, a run was scheduled to upgrade from firefly to f=
irefly (i.e. no upgrade really ;-) and it should therefore show that when=
 nothing happens all is well. It however fails in various ways as can be =
seen here.

=2E/virtualenv/bin/teuthology-suite --suite upgrade/firefly-x/stress-spli=
t  --suite-dir ~/software/ceph/ceph-qa-suite  --ceph firefly --machine-ty=
pe vps --email loic@dachary.org http://pulpito.ceph.com/loic-2014-07-02_2=
3:05:05-upgrade:firefly-x:stress-split-firefly-testing-basic-vps/

* Command failed on vpm105 with status 1: 'sudo yum install -y http://git=
builder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/sha1/810=
2ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'=20
  Does that mean kernels are not ready yet for this distribution and the =
tests should be skipped ?=20
* Command failed on vpm058 with status 1: "SWIFT_TEST_CONFIG_FILE=3D/home=
/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/cephtest/sw=
ift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test/function=
al -v -a '!fails_on_rgw'"
  http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:stre=
ss-split-firefly-testing-basic-vps/338941

  Although it looks like http://tracker.ceph.com/issues/7808 which is a d=
uplicate of http://tracker.ceph.com/issues/7799 it is slightly different =
and http://tracker.ceph.com/issues/8735 was created to keep track of it.

* Command failed on vpm070 with status 1: 'sudo adjust-ulimits ceph-cover=
age /home/ubuntu/cephtest/archive/coverage daemon-helper kill ceph-osd -f=
 -i 1'    http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefl=
y-x:stress-split-firefly-testing-basic-vps/338904/

   Although the root of the error seems to be that osd 1 cannot be killed=
 by the thrasher, I don't see meaningfull error messages. http://tracker.=
ceph.com/issues/8736 was filed to keep track of this condition.

* timed out waiting for admin_socket to appear after osd.1 restart    htt=
p://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:stress-sp=
lit-firefly-testing-basic-vps/338908/

   It looks like a race : the osd is killed at the same time it is restar=
ted by the thrasher and http://tracker.ceph.com/issues/8737 was opened fo=
r this

* hang on "INFO:teuthology.task.rados:joining rados"
  http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:stre=
ss-split-firefly-testing-basic-vps/338915/

  It looks like a bug and http://tracker.ceph.com/issues/8740 was filed

When the same suite is run to upgrade from firefly to master it gives htt=
p://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x:stress-sp=
lit-master-testing-basic-vps/ which shows the following errors:

* Command failed on vpm105 with status 1: 'sudo yum install -y http://git=
builder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/sha1/810=
2ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'   (same as above=
)

* Could not reconnect to ubuntu@vpm042.front.sepia.ceph.com  : it looks l=
ike a transient timeout problem that can be ignored
  http://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x:stre=
ss-split-master-testing-basic-vps/338891/
  2014-07-02T18:52:24.546 INFO:teuthology.orchestra.connection:{'username=
': u'ubuntu', 'hostname': u'vpm042.front.sepia.ceph.com', 'timeout': 60}

* Command failed on vpm017 with status 1: "SWIFT_TEST_CONFIG_FILE=3D/home=
/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/cephtest/sw=
ift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test/function=
al -v -a '!fails_on_rgw'"=20
  One of which looks exactly as http://tracker.ceph.com/issues/7799 which=
 was re-opened

* hang on "INFO:teuthology.task.rados:joining rados" (same as above)
=20
Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--8Jio6qD9730QNP3IiklrS8VGSg5fr4JKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO127IACgkQ8dLMyEl6F21faQCgjCd4JI/77hyR9KfpqN16xhfW
53QAnj/ZF3GLiRetEgGv442XbfPrS9ZB
=DdxV
-----END PGP SIGNATURE-----

--8Jio6qD9730QNP3IiklrS8VGSg5fr4JKJ--
