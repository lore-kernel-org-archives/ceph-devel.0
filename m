From: Loic Dachary <loic@dachary.org>
Subject: Re: Firefly upgrade tests
Date: Sat, 05 Jul 2014 15:46:03 +0200
Message-ID: <53B8019B.3090909@dachary.org>
References: <53B5DBB2.90503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bC02p3iGJVADDi5ddErWTJ1FebTCGSBdJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38536 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751777AbaGENqK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jul 2014 09:46:10 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id C03D242B23
	for <ceph-devel@vger.kernel.org>; Sat,  5 Jul 2014 15:46:03 +0200 (CEST)
In-Reply-To: <53B5DBB2.90503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bC02p3iGJVADDi5ddErWTJ1FebTCGSBdJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi,

It looks like there is a shortage of VPS for some reason:

http://pulpito.ceph.com/loic-2014-07-03_11:24:33-upgrade:firefly-x:stress=
-split-wip-8475-testing-basic-vps/

has a number of tests scheduled since ~48h and not making progress.

Cheers

On 04/07/2014 00:39, Loic Dachary wrote:
> Hi Ceph,
>=20
> The firefly-x test upgrade suite is designed to check that upgrading fr=
om Firefly to a newer version (master or a branch) works as expected. It =
was created it by copying dumpling-x and can be browsed at https://github=
=2Ecom/ceph/ceph-qa-suite/tree/master/suites/upgrade/firefly-x
>=20
> To establish a baseline, a run was scheduled to upgrade from firefly to=
 firefly (i.e. no upgrade really ;-) and it should therefore show that wh=
en nothing happens all is well. It however fails in various ways as can b=
e seen here.
>=20
> ./virtualenv/bin/teuthology-suite --suite upgrade/firefly-x/stress-spli=
t  --suite-dir ~/software/ceph/ceph-qa-suite  --ceph firefly --machine-ty=
pe vps --email loic@dachary.org http://pulpito.ceph.com/loic-2014-07-02_2=
3:05:05-upgrade:firefly-x:stress-split-firefly-testing-basic-vps/
>=20
> * Command failed on vpm105 with status 1: 'sudo yum install -y http://g=
itbuilder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/sha1/8=
102ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'=20
>   Does that mean kernels are not ready yet for this distribution and th=
e tests should be skipped ?=20
> * Command failed on vpm058 with status 1: "SWIFT_TEST_CONFIG_FILE=3D/ho=
me/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/cephtest/=
swift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test/functi=
onal -v -a '!fails_on_rgw'"
>   http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:st=
ress-split-firefly-testing-basic-vps/338941
>=20
>   Although it looks like http://tracker.ceph.com/issues/7808 which is a=
 duplicate of http://tracker.ceph.com/issues/7799 it is slightly differen=
t and http://tracker.ceph.com/issues/8735 was created to keep track of it=
=2E
>=20
> * Command failed on vpm070 with status 1: 'sudo adjust-ulimits ceph-cov=
erage /home/ubuntu/cephtest/archive/coverage daemon-helper kill ceph-osd =
-f -i 1'    http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:fire=
fly-x:stress-split-firefly-testing-basic-vps/338904/
>=20
>    Although the root of the error seems to be that osd 1 cannot be kill=
ed by the thrasher, I don't see meaningfull error messages. http://tracke=
r.ceph.com/issues/8736 was filed to keep track of this condition.
>=20
> * timed out waiting for admin_socket to appear after osd.1 restart    h=
ttp://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:stress-=
split-firefly-testing-basic-vps/338908/
>=20
>    It looks like a race : the osd is killed at the same time it is rest=
arted by the thrasher and http://tracker.ceph.com/issues/8737 was opened =
for this
>=20
> * hang on "INFO:teuthology.task.rados:joining rados"
>   http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:st=
ress-split-firefly-testing-basic-vps/338915/
>=20
>   It looks like a bug and http://tracker.ceph.com/issues/8740 was filed=

>=20
> When the same suite is run to upgrade from firefly to master it gives h=
ttp://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x:stress-=
split-master-testing-basic-vps/ which shows the following errors:
>=20
> * Command failed on vpm105 with status 1: 'sudo yum install -y http://g=
itbuilder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/sha1/8=
102ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'   (same as abo=
ve)
>=20
> * Could not reconnect to ubuntu@vpm042.front.sepia.ceph.com  : it looks=
 like a transient timeout problem that can be ignored
>   http://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x:st=
ress-split-master-testing-basic-vps/338891/
>   2014-07-02T18:52:24.546 INFO:teuthology.orchestra.connection:{'userna=
me': u'ubuntu', 'hostname': u'vpm042.front.sepia.ceph.com', 'timeout': 60=
}
>=20
> * Command failed on vpm017 with status 1: "SWIFT_TEST_CONFIG_FILE=3D/ho=
me/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/cephtest/=
swift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test/functi=
onal -v -a '!fails_on_rgw'"=20
>   One of which looks exactly as http://tracker.ceph.com/issues/7799 whi=
ch was re-opened
>=20
> * hang on "INFO:teuthology.task.rados:joining rados" (same as above)
> =20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bC02p3iGJVADDi5ddErWTJ1FebTCGSBdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO4AZsACgkQ8dLMyEl6F21tNQCfe4jN8K4gYQ0kPnO+lClUVhMR
fgEAoKC0p1HxNQMAR0S9Zp17rwGpfy6a
=S8Dk
-----END PGP SIGNATURE-----

--bC02p3iGJVADDi5ddErWTJ1FebTCGSBdJ--
