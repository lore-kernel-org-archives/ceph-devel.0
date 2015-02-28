From: Loic Dachary <loic@dachary.org>
Subject: Re: re-running teuthology jobs
Date: Sat, 28 Feb 2015 17:17:31 +0100
Message-ID: <54F1EA1B.5030207@dachary.org>
References: <54F1985A.1090907@dachary.org> <54F1D849.4020803@dachary.org> <1556427609.29934314.1425138429026.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3H5EUSGI8QGAj5gcaIbfDfO8TrlHHHH02"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50606 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752126AbbB1QRd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 11:17:33 -0500
In-Reply-To: <1556427609.29934314.1425138429026.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3H5EUSGI8QGAj5gcaIbfDfO8TrlHHHH02
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28/02/2015 16:47, Yuri Weinstein wrote:
> Loic
>=20
> In case you want to add some comments - http://tracker.ceph.com/issues/=
10945

Done thanks !

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, February 28, 2015 7:01:29 AM
> Subject: Re: re-running teuthology jobs
>=20
> The simpler way is to use the --filter argument of teuthology-suite wit=
h the value of the description: field found in the config.yaml file. For =
instance, running the rados failed jobs http://tracker.ceph.com/issues/10=
641#rados failed jobs:
>=20
> $ ./virtualenv/bin/teuthology-suite --priority 101 --suite rados --filt=
er 'rados/multimon/{clusters/21.yaml msgr-failures/many.yaml tasks/mon_cl=
ock_with_skews.yaml},rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr=
-failures/osd-delay.yaml thrashers/morepggrow.yaml workloads/small-object=
s.yaml},rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd=
-delay.yaml thrashers/pggrow.yaml workloads/ec-small-objects.yaml},rados/=
verify/{1thrash/none.yaml clusters/fixed-2.yaml fs/btrfs.yaml msgr-failur=
es/few.yaml tasks/mon_recovery.yaml validater/valgrind.yaml},rados/thrash=
/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrasher=
s/default.yaml workloads/cache-agent-small.yaml}' --suite-branch firefly =
--machine-type plana,burnupi,mira --distro ubuntu --email loic@dachary.or=
g --owner loic@dachary.org  --ceph firefly-backports
> 2015-02-28 15:58:08,474.474 INFO:teuthology.suite:ceph sha1: e54834bfac=
3c38562987730b317cb1944a96005b
> 2015-02-28 15:58:08,969.969 INFO:teuthology.suite:ceph version: 0.80.8-=
75-ge54834b-1precise
> 2015-02-28 15:58:09,606.606 INFO:teuthology.suite:teuthology branch: ma=
ster
> 2015-02-28 15:58:10,407.407 INFO:teuthology.suite:ceph-qa-suite branch:=
 firefly
> 2015-02-28 15:58:10,409.409 INFO:teuthology.repo_utils:Fetching from up=
stream into /home/loic/src/ceph-qa-suite_firefly
> 2015-02-28 15:58:11,522.522 INFO:teuthology.repo_utils:Resetting repo a=
t /home/loic/src/ceph-qa-suite_firefly to branch firefly
> 2015-02-28 15:58:12,393.393 INFO:teuthology.suite:Suite rados in /home/=
loic/src/ceph-qa-suite_firefly/suites/rados generated 693 jobs (not yet f=
iltered)
> 2015-02-28 15:58:12,419.419 INFO:teuthology.suite:Scheduling rados/mult=
imon/{clusters/21.yaml msgr-failures/many.yaml tasks/mon_clock_with_skews=
=2Eyaml}
> Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backport=
s---basic-multi and ID 783145
> 2015-02-28 15:58:14,199.199 INFO:teuthology.suite:Scheduling rados/thra=
sh/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrash=
ers/default.yaml workloads/cache-agent-small.yaml}
> Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backport=
s---basic-multi and ID 783146
> 2015-02-28 15:58:15,650.650 INFO:teuthology.suite:Scheduling rados/thra=
sh/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrash=
ers/morepggrow.yaml workloads/small-objects.yaml}
> Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backport=
s---basic-multi and ID 783147
> 2015-02-28 15:58:16,837.837 INFO:teuthology.suite:Scheduling rados/thra=
sh/{clusters/fixed-2.yaml fs/xfs.yaml msgr-failures/osd-delay.yaml thrash=
ers/pggrow.yaml workloads/ec-small-objects.yaml}
> Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backport=
s---basic-multi and ID 783148
> 2015-02-28 15:58:18,421.421 INFO:teuthology.suite:Scheduling rados/veri=
fy/{1thrash/none.yaml clusters/fixed-2.yaml fs/btrfs.yaml msgr-failures/f=
ew.yaml tasks/mon_recovery.yaml validater/valgrind.yaml}
> Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backport=
s---basic-multi and ID 783149
> 2015-02-28 15:58:19,729.729 INFO:teuthology.suite:Suite rados in /home/=
loic/src/ceph-qa-suite_firefly/suites/rados scheduled 5 jobs.
> 2015-02-28 15:58:19,729.729 INFO:teuthology.suite:Suite rados in /home/=
loic/src/ceph-qa-suite_firefly/suites/rados -- 688 jobs were filtered out=
=2E
> Job scheduled with name loic-2015-02-28_15:58:07-rados-firefly-backport=
s---basic-multi and ID 783150
>=20
> Creates the http://pulpito.ceph.com/loic-2015-02-28_15:58:07-rados-fire=
fly-backports---basic-multi/ run with just 5 jobs.
>=20
> On 28/02/2015 11:28, Loic Dachary wrote:
>> Hi,
>>
>> A teuthology rados run ( https://github.com/ceph/ceph-qa-suite/tree/ma=
ster/suites/rados ) completed with five dead jobs out of 693. They failed=
 because of DNS errors and I'd like to re-run them. Ideally I could do so=
mething like:
>>
>> teuthology-schedule --run loic-2015-02-27_20:22:09-rados-firefly-backp=
orts---basic-multi --job-id 781444 --job-id  781457 ...
>>
>> and it would re-schedule a run of the designated jobs from the designa=
ted run. But I don't think such a command exist.=20
>>
>> I will therefore manually do what such a command would do, for each fa=
iled job:
>>
>> * download http://qa-proxy.ceph.com/teuthology/loic-2015-02-27_20:22:0=
9-rados-firefly-backports---basic-multi/781444/orig.config.yaml
>> * git clone https://github.com/ceph/ceph-qa-suite /srv/ceph-qa-suite
>> * cd /srv/ceph-qa-suite ; git checkout firefly (assuming that's the ce=
ph-qa-suite branch I'm interested in)
>> * remove the fields:
>>    job_id: '781444'
>>    last_in_suite: false
>>    worker_log: /var/lib/teuthworker/archive/worker_logs/worker.multi.1=
4588
>> * replace the suite_path: field with suite_path: /srv/ceph-qa-suite
>> * teuthology-lock --lock enough machines (i.e. one for each element in=
 the roles: section of the orig.config.yaml)
>> * turn the machine list into a consumable file for teuthology : teutho=
logy-lock --list-targets > targets.yaml=20
>> * run teuthology orig.config.yaml targets.yaml
>> * wait for the result
>>
>> Is there a better way to do that ?=20
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--3H5EUSGI8QGAj5gcaIbfDfO8TrlHHHH02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTx6hsACgkQ8dLMyEl6F20qRwCeOK1Pokv0vwjQceqQaMIpTO6l
PbIAoKVRRL8AWr1r6BFqN8M+FfNz39xg
=5Lp+
-----END PGP SIGNATURE-----

--3H5EUSGI8QGAj5gcaIbfDfO8TrlHHHH02--
