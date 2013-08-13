From: Loic Dachary <loic@dachary.org>
Subject: teuthology and code coverage
Date: Tue, 13 Aug 2013 19:01:53 +0200
Message-ID: <520A6681.9040804@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC19A5804991019DCA0229534"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:45315 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab3HMRB4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 13:01:56 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 13A7726394
	for <ceph-devel@vger.kernel.org>; Tue, 13 Aug 2013 19:01:54 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC19A5804991019DCA0229534
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

When running teuthology from a laptop with the configuration below and

=2E/virtualenv/bin/teuthology --archive=3D/tmp/teuthology try.yaml

it then fails on

=2E/virtualenv/bin/teuthology-coverage -v --html-output /tmp/html   -o /t=
mp/lcov   --cov-tools-dir $(pwd)/coverage   /tmp/teuthology
ERROR:teuthology.coverage:error generating coverage
Traceback (most recent call last):
  File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line=
 145, in analyze
    _analyze(args)
  File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line=
 171, in _analyze
    assert len(test_summaries) > 0
AssertionError
Traceback (most recent call last):
  File "./virtualenv/bin/teuthology-coverage", line 9, in <module>
    load_entry_point('teuthology=3D=3D0.0.1', 'console_scripts', 'teuthol=
ogy-coverage')()
  File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line=
 145, in analyze
    _analyze(args)
  File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line=
 171, in _analyze
    assert len(test_summaries) > 0
AssertionError

/tmp/teuthology looks like this:

=2E/config.yaml
=2E/summary.yaml
=2E/owner
=2E/pid
=2E/teuthology.log
=2E/orig.config.yaml
=2E/remote
=2E/remote/target1
=2E/remote/target1/log
=2E/remote/target1/log/ceph-osd.0.log.gz
=2E/remote/target1/log/ceph.log.gz
=2E/remote/target1/log/ceph-mon.c.log.gz
=2E/remote/target1/log/ceph-osd.2.log.gz
=2E/remote/target1/log/ceph-osd.1.log.gz
=2E/remote/target1/log/ceph-mon.a.log.gz
=2E/remote/target1/syslog
=2E/remote/target1/syslog/kern.log
=2E/remote/target1/syslog/misc.log
=2E/remote/target1
=2E/remote/target1/log
=2E/remote/target1/log/ceph-osd.3.log.gz
=2E/remote/target1/log/ceph-mds.a.log.gz
=2E/remote/target1/log/ceph-osd.4.log.gz
=2E/remote/target1/log/ceph.log.gz
=2E/remote/target1/log/ceph-osd.5.log.gz
=2E/remote/target1/log/ceph-mon.b.log.gz
=2E/remote/target1/syslog
=2E/remote/target1/syslog/kern.log
=2E/remote/target1/syslog/misc.log
=2E/data
=2E/data/mon.b.tgz
=2E/data/mon.c.tgz
=2E/data/mon.a.tgz

with summary.yaml

duration: 1615.8156020641327
flavor: basic
owner: loic@dachary.org
success: true

and orig.config.yaml ( targets edited out )

nuke-on-error: true
overrides:
  admin_socket:
    branch: master
  ceph:
    branch: master
    conf:
      global:
        ms inject delay max: 1
        ms inject delay probability: 0.005
        ms inject delay type: osd
        ms inject socket failures: 2500
        osd map cache size: 1
      mon:
        debug mon: 20
        debug ms: 20
        debug paxos: 20
        mon min osdmap epochs: 2
      osd:
        debug filestore: 20
        debug ms: 1
        debug osd: 20
        osd debug verify stray on activate: true
        osd op thread timeout: 60
    fs: xfs
    log-whitelist:
    - slow request
  install:
    ceph:
      branch: master
roles:
- - mon.a
  - mon.c
  - osd.0
  - osd.1
  - osd.2
- - mon.b
  - mds.a
  - osd.3
  - osd.4
  - osd.5
  - client.0
tasks:
- chef: null
- install: null
- ceph:
    coverage: true
    flavor: gcov
    log-whitelist:
    - wrongly marked me down
    - objects unfound and apparently lost
- rados:
    clients:
    - client.0
    objects: 500
    op_weights:
      delete: 10
      read: 45
      rollback: 50
      snap_create: 50
      snap_remove: 50
      write: 45
    ops: 4000

I guess I'm not placing the "flavor: gcov" where I should.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigC19A5804991019DCA0229534
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIKZoEACgkQ8dLMyEl6F20GIQCfRZXu5lL1utkd/pok7R0glA1p
y0QAnigKN2AiNxb+mM8oJItmV2t+KFU4
=AucU
-----END PGP SIGNATURE-----

--------------enigC19A5804991019DCA0229534--
