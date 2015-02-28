From: Loic Dachary <loic@dachary.org>
Subject: re-running teuthology jobs
Date: Sat, 28 Feb 2015 11:28:42 +0100
Message-ID: <54F1985A.1090907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GHKFtJGwsEA7N2KmlTCPU9Xgkv0mxjm0K"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50471 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbbB1K2q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 05:28:46 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 3C9F542137
	for <ceph-devel@vger.kernel.org>; Sat, 28 Feb 2015 11:28:43 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GHKFtJGwsEA7N2KmlTCPU9Xgkv0mxjm0K
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

A teuthology rados run ( https://github.com/ceph/ceph-qa-suite/tree/maste=
r/suites/rados ) completed with five dead jobs out of 693. They failed be=
cause of DNS errors and I'd like to re-run them. Ideally I could do somet=
hing like:

teuthology-schedule --run loic-2015-02-27_20:22:09-rados-firefly-backport=
s---basic-multi --job-id 781444 --job-id  781457 ...

and it would re-schedule a run of the designated jobs from the designated=
 run. But I don't think such a command exist.=20

I will therefore manually do what such a command would do, for each faile=
d job:

* download http://qa-proxy.ceph.com/teuthology/loic-2015-02-27_20:22:09-r=
ados-firefly-backports---basic-multi/781444/orig.config.yaml
* git clone https://github.com/ceph/ceph-qa-suite /srv/ceph-qa-suite
* cd /srv/ceph-qa-suite ; git checkout firefly (assuming that's the ceph-=
qa-suite branch I'm interested in)
* remove the fields:
   job_id: '781444'
   last_in_suite: false
   worker_log: /var/lib/teuthworker/archive/worker_logs/worker.multi.1458=
8
* replace the suite_path: field with suite_path: /srv/ceph-qa-suite
* teuthology-lock --lock enough machines (i.e. one for each element in th=
e roles: section of the orig.config.yaml)
* turn the machine list into a consumable file for teuthology : teutholog=
y-lock --list-targets > targets.yaml=20
* run teuthology orig.config.yaml targets.yaml
* wait for the result

Is there a better way to do that ?=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--GHKFtJGwsEA7N2KmlTCPU9Xgkv0mxjm0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTxmFsACgkQ8dLMyEl6F22BWQCaAolTDpftHD/V1hmt91tEK1NG
j2sAn13Yn4INv8DKrAV18jv3KqA/SiOP
=CgdY
-----END PGP SIGNATURE-----

--GHKFtJGwsEA7N2KmlTCPU9Xgkv0mxjm0K--
