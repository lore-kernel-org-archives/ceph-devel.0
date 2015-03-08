From: Loic Dachary <loic@dachary.org>
Subject: teuthology-lock and choosing a kernel
Date: Sun, 08 Mar 2015 13:50:37 +0100
Message-ID: <54FC459D.2090703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nxw5L9JlMahUlHE2mEVkNx8PWxlHTWfJo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54662 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752439AbbCHMul (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Mar 2015 08:50:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nxw5L9JlMahUlHE2mEVkNx8PWxlHTWfJo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After successfully locking a centos 6.5 VPS in the community lab with

teuthology-lock --lock-many 1 --owner loic@dachary.org --machine-type vps=
 --os-type centos --os-version 6.5

it turns out that it has a 2.6.32 kernel by default. A more recent kernel=
 is required to run the ceph-disk tests because it relies on /dev/loop ha=
ndling partition tables as a regular disk would. After installing a 3.10 =
kernel from http://elrepo.org/tiki/kernel-lt and rebooting, it was no lon=
ger possible to reach the machine.

The teuthology-suite command has a -k option which suggest there is a way=
 to specify the kernel when provisioning a machine. The command

=2E/virtualenv/bin/teuthology-suite --dry-run -k testing --priority 101 -=
-suite rgw --suite-branch firefly --machine-type plana,burnupi,mira --dis=
tro ubuntu --email loic@dachary.org --owner loic@dachary.org  --ceph fire=
fly-backports

shows lines like:

2015-03-08 13:43:26,432.432 INFO:teuthology.suite:dry-run: ./virtualenv/b=
in/teuthology-schedule --name loic-2015-03-08_13:43:06-rgw-firefly-backpo=
rts-testing-basic-multi --num 1 --worker multi --priority 101 --owner loi=
c@dachary.org --description 'rgw/multifs/{clusters/fixed-2.yaml fs/btrfs.=
yaml rgw_pool_type/erasure-coded.yaml tasks/rgw_multipart_upload.yaml}' -=
- /tmp/schedule_suite_AQ2b6w /home/loic/src/ceph-qa-suite_firefly/suites/=
rgw/multifs/clusters/fixed-2.yaml /home/loic/src/ceph-qa-suite_firefly/su=
ites/rgw/multifs/fs/btrfs.yaml /home/loic/src/ceph-qa-suite_firefly/suite=
s/rgw/multifs/rgw_pool_type/erasure-coded.yaml /home/loic/src/ceph-qa-sui=
te_firefly/suites/rgw/multifs/tasks/rgw_multipart_upload.yaml

which show the testing word as part of the job name. The https://github.c=
om/ceph/teuthology/ page shows some more information about kernel choices=
 but it's non trivial to figure out how to translate that into something =
that could be used in the context of teuthology-lock.

I'm not sure where to look and I would be grateful if you could give me a=
 pointer to go in the right direction.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nxw5L9JlMahUlHE2mEVkNx8PWxlHTWfJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT8RZ0ACgkQ8dLMyEl6F20rQgCaAxV23MKkjR+zmbxSQM1aoaNP
pJcAoKYufadL8dkbbSuuqNrAaeOoy+Hj
=F9co
-----END PGP SIGNATURE-----

--nxw5L9JlMahUlHE2mEVkNx8PWxlHTWfJo--
