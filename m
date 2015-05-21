From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Osd: temperature based object eviction for cache tiering
Date: Thu, 21 May 2015 21:34:05 +0800
Message-ID: <cover.1432214851.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:58857 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbbEUNfn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 09:35:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, MingXin Liu <mingxinliu@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

This is an implementation of temperature based object 
eviction policy for cache tiering. The current eviction 
policy is based only on the latest access time, without 
considering the access frequency in the history. This 
policy is apt to leave the just-accessed object in the 
cache pool, even it will no longer be accessed. Obviously, 
this policy will make bad choices in some scenarios. 
This motivates us to present temperature based object 
eviction policy, which makes eviction decision by considering 
both latest access time and access frequency, while keeping 
the simplicity of the current algorithm framework, and 
making minimal revision to it. The algorithm is simple, 
associate each hitset with a weight, the latest hitset 
with the heaviest weight, say, 1000000. And the least 
latest hitset with a lighter weight, decayed by an 
user-defined factor, say, 50, then the least latest 
hitset has a weight of 1000000*(100-50)/100=500000, 
and so on. Each object in the cache pool will be calculated 
a total weight according to its appearance in all the 
hitsets, then those objects with the least total weights 
are chosen as the eviction candidates. In fact, the 
algorithm reduces to the current atime based eviction 
policy by setting decay rate be 100.

The patches:
https://github.com/ceph/ceph/pull/4737

MingXin Liu (5):
  Osd: add three fields to pg_pool_t
  Mon: expose commands for temperature related setting
  Osd: add a temperature based object eviction policy for cache tiering
  Mon: add temperature support for existing cache related commands
  Doc: add temperature related stuff in documents and test scripts

 doc/dev/cache-pool.rst         |   4 ++
 doc/man/8/ceph.rst             |  12 +++--
 doc/rados/operations/pools.rst |   7 +++
 qa/workunits/cephtool/test.sh  |  14 ++++++
 src/common/config_opts.h       |   2 +
 src/mon/MonCommands.h          |   8 ++-
 src/mon/OSDMonitor.cc          | 101 ++++++++++++++++++++++++++++++++++---
 src/osd/ReplicatedPG.cc        | 110 ++++++++++++++++++++++-------------------
 src/osd/osd_types.cc           |  32 +++++++++++-
 src/osd/osd_types.h            |  49 ++++++++++++++++++
 10 files changed, 274 insertions(+), 65 deletions(-)

-- 
1.9.1

