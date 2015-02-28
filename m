From: Loic Dachary <loic@dachary.org>
Subject: Re: re-running teuthology jobs
Date: Sat, 28 Feb 2015 16:01:29 +0100
Message-ID: <54F1D849.4020803@dachary.org>
References: <54F1985A.1090907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sRUamw9Fs3hMugSWhJRogB8SCgcDT190M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50570 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751310AbbB1PBd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 10:01:33 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 3174E42B25
	for <ceph-devel@vger.kernel.org>; Sat, 28 Feb 2015 16:01:30 +0100 (CET)
In-Reply-To: <54F1985A.1090907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sRUamw9Fs3hMugSWhJRogB8SCgcDT190M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The simpler way is to use the --filter argument of teuthology-suite with =
the value of the description: field found in the config.yaml file. For in=
stance, running the rados failed jobs http://tracker.ceph.com/issues/1064=
1#rados failed jobs:

$ ./virtualenv/bin/teuthology-suite --priority 101 --suite rados --filter=
 'rados/multimon/{clusters/21.yaml msgr-failures/many.yaml tasks/mon_cloc=
k_with_skews.yaml},rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-f=
ailures/osd-delay.yaml thrashers/morepggrow.yaml workloads/small-objects.=
yaml},rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-d=
elay.yaml thrashers/pggrow.yaml workloads/ec-small-objects.yaml},rados/ve=
rify/{1thrash/none.yaml clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures=
/few.yaml tasks/mon_recovery.yaml validater/valgrind.yaml},rados/thrash/{=
clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrashers/=
default.yaml workloads/cache-agent-small.yaml}' --suite-branch firefly --=
machine-type plana,burnupi,mira --distro ubuntu --email loic@dachary.org =
--owner loic@dachary.org  --ceph firefly-backports
2015-02-28 15:58:08,474.474 INFO:teuthology.suite:ceph sha1: e54834bfac3c=
38562987730b317cb1944a96005b
2015-02-28 15:58:08,969.969 INFO:teuthology.suite:ceph version: 0.80.8-75=
-ge54834b-1precise
2015-02-28 15:58:09,606.606 INFO:teuthology.suite:teuthology branch: mast=
er
2015-02-28 15:58:10,407.407 INFO:teuthology.suite:ceph-qa-suite branch: f=
irefly
2015-02-28 15:58:10,409.409 INFO:teuthology.repo_utils:Fetching from upst=
ream into /home/loic/src/ceph-qa-suite_firefly
2015-02-28 15:58:11,522.522 INFO:teuthology.repo_utils:Resetting repo at =
/home/loic/src/ceph-qa-suite_firefly to branch firefly
2015-02-28 15:58:12,393.393 INFO:teuthology.suite:Suite rados in /home/lo=
ic/src/ceph-qa-suite_firefly/suites/rados generated 693 jobs (not yet fil=
tered)
2015-02-28 15:58:12,419.419 INFO:teuthology.suite:Scheduling rados/multim=
on/{clusters/21.yaml msgr-failures/many.yaml tasks/mon_clock_with_skews.y=
aml}
Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports-=
--basic-multi and ID 783145
2015-02-28 15:58:14,199.199 INFO:teuthology.suite:Scheduling rados/thrash=
/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrasher=
s/default.yaml workloads/cache-agent-small.yaml}
Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports-=
--basic-multi and ID 783146
2015-02-28 15:58:15,650.650 INFO:teuthology.suite:Scheduling rados/thrash=
/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrasher=
s/morepggrow.yaml workloads/small-objects.yaml}
Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports-=
--basic-multi and ID 783147
2015-02-28 15:58:16,837.837 INFO:teuthology.suite:Scheduling rados/thrash=
/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrasher=
s/pggrow.yaml workloads/ec-small-objects.yaml}
Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports-=
--basic-multi and ID 783148
2015-02-28 15:58:18,421.421 INFO:teuthology.suite:Scheduling rados/verify=
/{1thrash/none.yaml clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures/few=
=2Eyaml tasks/mon_recovery.yaml validater/valgrind.yaml}
Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports-=
--basic-multi and ID 783149
2015-02-28 15:58:19,729.729 INFO:teuthology.suite:Suite rados in /home/lo=
ic/src/ceph-qa-suite_firefly/suites/rados scheduled 5 jobs.
2015-02-28 15:58:19,729.729 INFO:teuthology.suite:Suite rados in /home/lo=
ic/src/ceph-qa-suite_firefly/suites/rados -- 688 jobs were filtered out.
Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backports-=
--basic-multi and ID 783150

Creates the http://pulpito.ceph.com/loic-2015-02-28_15:58:07-rados-firefl=
y-backports---basic-multi/ run with just 5 jobs.

On 28/02/2015 11:28, Loic Dachary wrote:
> Hi,
>=20
> A teuthology rados run ( https://github.com/ceph/ceph-qa-suite/tree/mas=
ter/suites/rados ) completed with five dead jobs out of 693. They failed =
because of DNS errors and I'd like to re-run them. Ideally I could do som=
ething like:
>=20
> teuthology-schedule --run loic-2015-02-27_20:22:09-rados-firefly-backpo=
rts---basic-multi --job-id 781444 --job-id  781457 ...
>=20
> and it would re-schedule a run of the designated jobs from the designat=
ed run. But I don't think such a command exist.=20
>=20
> I will therefore manually do what such a command would do, for each fai=
led job:
>=20
> * download http://qa-proxy.ceph.com/teuthology/loic-2015-02-27_20:22:09=
-rados-firefly-backports---basic-multi/781444/orig.config.yaml
> * git clone https://github.com/ceph/ceph-qa-suite /srv/ceph-qa-suite
> * cd /srv/ceph-qa-suite ; git checkout firefly (assuming that's the cep=
h-qa-suite branch I'm interested in)
> * remove the fields:
>    job_id: '781444'
>    last_in_suite: false
>    worker_log: /var/lib/teuthworker/archive/worker_logs/worker.multi.14=
588
> * replace the suite_path: field with suite_path: /srv/ceph-qa-suite
> * teuthology-lock --lock enough machines (i.e. one for each element in =
the roles: section of the orig.config.yaml)
> * turn the machine list into a consumable file for teuthology : teuthol=
ogy-lock --list-targets > targets.yaml=20
> * run teuthology orig.config.yaml targets.yaml
> * wait for the result
>=20
> Is there a better way to do that ?=20
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--sRUamw9Fs3hMugSWhJRogB8SCgcDT190M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTx2EkACgkQ8dLMyEl6F215XQCfSvcdNqw0U86kH0zpq44WEdpZ
SHwAn20m3LSzPpEJhI3FxQgKP/NJsJd/
=/W4p
-----END PGP SIGNATURE-----

--sRUamw9Fs3hMugSWhJRogB8SCgcDT190M--
