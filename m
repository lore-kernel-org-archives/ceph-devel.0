From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: teuthology and code coverage
Date: Wed, 14 Aug 2013 00:38:19 -0700
Message-ID: <520B33EB.2020207@inktank.com>
References: <520A6681.9040804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44399 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957Ab3HNHhd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 03:37:33 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so3725579obb.37
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 00:37:32 -0700 (PDT)
In-Reply-To: <520A6681.9040804@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 08/13/2013 10:01 AM, Loic Dachary wrote:
> Hi,
>
> When running teuthology from a laptop with the configuration below and
>
> ./virtualenv/bin/teuthology --archive=/tmp/teuthology try.yaml
>
> it then fails on
>
> ./virtualenv/bin/teuthology-coverage -v --html-output /tmp/html   -o /tmp/lcov   --cov-tools-dir $(pwd)/coverage   /tmp/teuthology

Using /tmp instead of /tmp/teuthology here might work if /tmp is
otherwise empty.

This is meant to run on a directory full of results from multiple
tests, and analyze coverage per-test and in aggregate across a suite.
The argument name should probably be changed to be clearer.

> ERROR:teuthology.coverage:error generating coverage
> Traceback (most recent call last):
>    File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line 145, in analyze
>      _analyze(args)
>    File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line 171, in _analyze
>      assert len(test_summaries) > 0
> AssertionError
> Traceback (most recent call last):
>    File "./virtualenv/bin/teuthology-coverage", line 9, in <module>
>      load_entry_point('teuthology==0.0.1', 'console_scripts', 'teuthology-coverage')()
>    File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line 145, in analyze
>      _analyze(args)
>    File "/home/loic/software/ceph/teuthology/teuthology/coverage.py", line 171, in _analyze
>      assert len(test_summaries) > 0
> AssertionError
>
> /tmp/teuthology looks like this:
>
> ./config.yaml
> ./summary.yaml
> ./owner
> ./pid
> ./teuthology.log
> ./orig.config.yaml
> ./remote
> ./remote/target1
> ./remote/target1/log
> ./remote/target1/log/ceph-osd.0.log.gz
> ./remote/target1/log/ceph.log.gz
> ./remote/target1/log/ceph-mon.c.log.gz
> ./remote/target1/log/ceph-osd.2.log.gz
> ./remote/target1/log/ceph-osd.1.log.gz
> ./remote/target1/log/ceph-mon.a.log.gz
> ./remote/target1/syslog
> ./remote/target1/syslog/kern.log
> ./remote/target1/syslog/misc.log
> ./remote/target1
> ./remote/target1/log
> ./remote/target1/log/ceph-osd.3.log.gz
> ./remote/target1/log/ceph-mds.a.log.gz
> ./remote/target1/log/ceph-osd.4.log.gz
> ./remote/target1/log/ceph.log.gz
> ./remote/target1/log/ceph-osd.5.log.gz
> ./remote/target1/log/ceph-mon.b.log.gz
> ./remote/target1/syslog
> ./remote/target1/syslog/kern.log
> ./remote/target1/syslog/misc.log
> ./data
> ./data/mon.b.tgz
> ./data/mon.c.tgz
> ./data/mon.a.tgz
>
> with summary.yaml
>
> duration: 1615.8156020641327
> flavor: basic
> owner: loic@dachary.org
> success: true
>
> and orig.config.yaml ( targets edited out )
>
> nuke-on-error: true
> overrides:
>    admin_socket:
>      branch: master
>    ceph:
>      branch: master
>      conf:
>        global:
>          ms inject delay max: 1
>          ms inject delay probability: 0.005
>          ms inject delay type: osd
>          ms inject socket failures: 2500
>          osd map cache size: 1
>        mon:
>          debug mon: 20
>          debug ms: 20
>          debug paxos: 20
>          mon min osdmap epochs: 2
>        osd:
>          debug filestore: 20
>          debug ms: 1
>          debug osd: 20
>          osd debug verify stray on activate: true
>          osd op thread timeout: 60
>      fs: xfs
>      log-whitelist:
>      - slow request
>    install:
>      ceph:
>        branch: master
> roles:
> - - mon.a
>    - mon.c
>    - osd.0
>    - osd.1
>    - osd.2
> - - mon.b
>    - mds.a
>    - osd.3
>    - osd.4
>    - osd.5
>    - client.0
> tasks:
> - chef: null
> - install: null
> - ceph:
>      coverage: true
>      flavor: gcov
>      log-whitelist:
>      - wrongly marked me down
>      - objects unfound and apparently lost
> - rados:
>      clients:
>      - client.0
>      objects: 500
>      op_weights:
>        delete: 10
>        read: 45
>        rollback: 50
>        snap_create: 50
>        snap_remove: 50
>        write: 45
>      ops: 4000
>
> I guess I'm not placing the "flavor: gcov" where I should.

I think these days it should go in the install task.
coverage: true still belongs in the ceph task though, so it uses
SIGTERM on daemons.

