From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: teuthology timeout error
Date: Wed, 20 May 2015 02:20:27 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AAF9237@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:30618 "EHLO
	mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbETCUb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 22:20:31 -0400
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
	by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id E6BEDAC04F4
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 11:20:28 +0900 (JST)
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>, "Imai, Hiroki" <imai.hiroki@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>

Hi Loic,

When we fixed our own issue and restarted teuthology, we encountered another issue
(timeout error) which occurs in case of LRC as well.
Do you have any information about that ?

[error messages (in case of LRC pool)]

2015-04-28 12:38:54,128.128 INFO:teuthology.orchestra.run.RX35-1:Running: 'adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage ceph status --format=json-pretty'
2015-04-28 12:38:54,516.516 INFO:tasks.ceph.ceph_manager:no progress seen, keeping timeout for now
2015-04-28 12:38:54,516.516 INFO:tasks.thrashosds.thrasher:Traceback (most recent call last):
  File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 632, in wrapper
    return func(self)
  File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 665, in do_thrash
    timeout=self.config.get('timeout')
  File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 1566, in wait_for_recovery
    'failed to recover before timeout expired'
AssertionError: failed to recover before timeout expired

Traceback (most recent call last):
  File "/root/work/teuthology/virtualenv/lib/python2.7/site-packages/gevent/greenlet.py", line 390, in run
    result = self._run(*self.args, **self.kwargs)
  File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 632, in wrapper
    return func(self)
  File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 665, in do_thrash
    timeout=self.config.get('timeout')
  File "/root/src/ceph-qa-suite_master/tasks/ceph_manager.py", line 1566, in wait_for_recovery
    'failed to recover before timeout expired'
AssertionError: failed to recover before timeout expired <Greenlet at 0x2a7d550: <bound method Thrasher.do_thrash of <tasks.ceph_manager.Thrasher instance at 0x2bd12d8>>> failed with AssertionError

[ceph version]
0.93-952-gfe28daa

[teuthology, ceph-qa-suite]
newest version at 3/25/2015

[configurations]
  check-locks: false
  overrides:
    ceph:
      conf:
        global:
          ms inject socket failures: 5000
        osd:
          osd heartbeat use min delay socket: true
          osd sloppy crc: true
      fs: xfs
  roles:
  - - mon.a
    - osd.0
    - osd.4
    - osd.8
    - osd.12
  - - mon.b
    - osd.1
    - osd.5
    - osd.9
    - osd.13
  - - mon.c
    - osd.2
    - osd.6
    - osd.10
    - osd.14
  - - osd.3
    - osd.7
    - osd.11
    - osd.15
    - client.0
  targets:
    ubuntu@RX35-1.primary.ceph-poc.fsc.net:
    ubuntu@RX35-2.primary.ceph-poc.fsc.net:
    ubuntu@RX35-3.primary.ceph-poc.fsc.net:
    ubuntu@RX35-4.primary.ceph-poc.fsc.net:
  tasks:
  - ceph:
      conf:
        osd:
          osd debug reject backfill probability: 0.3
          osd max backfills: 1
          osd scrub max interval: 120
          osd scrub min interval: 60
      log-whitelist:
      - wrongly marked me down
      - objects unfound and apparently lost
  - thrashosds:
      chance_pgnum_grow: 1
      chance_pgpnum_fix: 1
      min_in: 4
      timeout: 1200
  - rados:
      clients:
      - client.0
      ec_pool: true
      erasure_code_profile:
        k: 4
        l: 3
        m: 2
        name: lrcprofile
        plugin: lrc
        ruleset-failure-domain: osd
      objects: 50
      op_weights:
        append: 100
        copy_from: 50
        delete: 50
        read: 100
        rmattr: 25
        rollback: 50
        setattr: 25
        snap_create: 50
        snap_remove: 50
        write: 0
      ops: 190000

Best regards,
Takeshi Miyamae

