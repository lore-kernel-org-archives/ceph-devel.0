From: Loic Dachary <loic@dachary.org>
Subject: proposal to run Ceph tests on pull requests
Date: Sat, 5 Dec 2015 12:49:41 +0100
Message-ID: <5662CF55.3050702@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Tjk3LdMUux5a4lJaPAMX4IiFDu6dvC9ka"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44707 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751768AbbLELtu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Dec 2015 06:49:50 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 5836542B28
	for <ceph-devel@vger.kernel.org>; Sat,  5 Dec 2015 12:49:41 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tjk3LdMUux5a4lJaPAMX4IiFDu6dvC9ka
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

TL;DR: a ceph-qa-suite bot running on pull requests is sustainable and is=
 an incentive for contributors to use teuthology-openstack independently

When a pull request is submitted, it is compiled, some tests are run[1] a=
nd the result is added to the pull request to confirm that it does not in=
troduce a trivial problem. Such tests are however limited because they mu=
st:

* run within a few minutes at most
* not require multiple machines
* not require root privileges

More extensive tests (primarily integration tests) are needed before a co=
ntribution can be merged into Ceph [2], to verify it does not introduce a=
 subtle regression. It would be ideal to run these integration tests on e=
ach pull request but there are two obstacles:

* each test takes ~ 1.5 hour
* each test cost ~ 0.30 euros

On the current master, running all tests would require ~1000 jobs [3]. Th=
at would cost ~ 300 euros on each pull request and take ~10 hours assumin=
g 100 jobs can run in parallel. We could resolve that problem by:

* maintaining a ceph-qa-suite map to be used as a white list mapping a di=
ff to a set of tests. For instance, if the diff modifies the src/ceph-dis=
k file, it outputs the ceph-disk suite[4]. This would effectively trim th=
e tests that are unrelated to the contribution and reduce the number of t=
ests to a maximum of ~100 [4] and most likely a dozen.
* tests are run if one of the commits of the pull request has the *Needs-=
qa: true* flag in the commit message[5]
* limiting the number of tests to fit in the allocated budget. If there w=
as enough funding for 10,000 jobs during the previous period and there wa=
s a total of 1,000 test run required (a test run is a set of tests as pro=
duced by the ceph-qa-suite map), each run is trimmed to a maximum of ten =
tests, regardless.

Here is an example:

Joe submits a pull request to fix a bug in the librados API
The make check bot compiles and fails make check because it introduces a =
bug
Joe uses run-make-check.sh locally to repeat the failure, fixes it and re=
push
The make check bot compiles and passes make check
Joe amends the commit message to add *Needs-qa: true* and repushes
The ceph-qa-suite map script finds a change on the librados API and outpu=
ts smoke/basic/tasks/rados_api_tests.yaml
The ceph-qa-suite bot runs the test smoke/basic/tasks/rados_api_tests.yam=
l which fails
Joe examines the logs found at http://teuthology-logs.public.ceph.com/ an=
d decides to debug by running the test himself
Joe runs teuthology-openstack --suite smoke/basic/tasks/rados_api_tests.y=
aml against his own OpenStack tenant [6]
Joe repush with a fix
The ceph-qa-suite bot runs the test smoke/basic/tasks/rados_api_tests.yam=
l which succeeds
Kefu reviews the pull request and has a link to the successful test runs =
in the comments

This approach scales with the size of the Ceph developer community [7] be=
cause regular contributors benefit directly from funding the ceph-qa-suit=
e bot. New contributors can focus on learning how to interpret the ceph-q=
a-suite error logs for their contribution and learn about how to debug it=
 via teuthology-openstack if needed, which is a better user experience th=
an trying to figure out which ceph-qa-suite job to run, learning about te=
uthology, schedule the test and interpret the results.

The maintenance workload of a ceph-qa-suite bot probably requires one wor=
k day a week, to handle funding, sysadmin of the server where the bot run=
s but mostly to sort out the false negatives. I believe a pure self-servi=
ce approach where each contributor would be asked to run teuthology-opens=
tack independently would actually require more work. The ceph-qa-suite bo=
t provides a baseline on which everybody can agree to sort out the false =
negatives. When a contributor runs teuthology-openstack by herself/himsel=
f, it is difficult for her/him to figure out if a failure comes from some=
thing she/he did incorrectly because she/he is not familiar with teutholo=
gy-openstack or if it is related to her/his contribution. She/He will ask=
s for assistance  in situations where comparing her/his run with the outp=
ut of the ceph-qa-suite bot would probably give her/him enough hints to f=
ix the problem herself/himself.

If the ceph-qa-suite bot becomes unavailable, the contributors are not bl=
ocked because they can run it by themselves on their own OpenStack tenant=
 and link the results to the pull request in the same way the bot would. =
Debugging a failed test is essentially the same thing as running the ceph=
-qa-suite bot.

Cheers

[1] run-make-check.sh https://github.com/ceph/ceph/blob/master/run-make-c=
heck.sh
[2] Ceph test suites https://github.com/ceph/ceph-qa-suite/tree/master/su=
ites
[3] teuthology-suite --suite .  --subset 1/40000
[4] minimal number of tests to run all tasks at least once: 130 for rados=
, 76 for fs, 113 for upgrade, 18 for rgw, 45 for rbd.
[5] a former proposal was to include the test suite to run in the commit =
message, but this is more difficult to maintain that a boolean flag that =
states a given commit needs to pass all the relevant tests
[6] teuthology-openstack https://github.com/dachary/teuthology/tree/opens=
tack#openstack-backend
[7] Scaling out the Ceph community lab http://dachary.org/?p=3D3852
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Tjk3LdMUux5a4lJaPAMX4IiFDu6dvC9ka
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZiz1UACgkQ8dLMyEl6F20kjACfR9Shq65Rib3MmjdKEFpoRu9h
MK0AmgJekjaCBn3hZ3WVP2X+yz4xmytw
=6VNv
-----END PGP SIGNATURE-----

--Tjk3LdMUux5a4lJaPAMX4IiFDu6dvC9ka--
