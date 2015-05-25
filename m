From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 0/2] IO hint for no caching object for cache-tiering
Date: Mon, 25 May 2015 11:32:15 +0800
Message-ID: <cover.1432523122.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:58044 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbEYDdp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 May 2015 23:33:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

The conventional io hints by fadvise() is to give chance
for applications to manipulate page cache. This patch extends
io hint ability to control cache pool behavior to avoid cache 
pollution. For example, under WRITEBACK mode, consider the 
following operation series, WRITE A; WRITE B; READ A, 
if B is never accessed later, then the write of B pollutes 
the cache by forcing A evicted, the reuse of A causes a cache miss. 
With the io hint, we could explicitly tell rados to not to 
cache B, thereby avoid cache pollution.

The patches:
https://github.com/ceph/ceph/pull/4754

Min Chen (2):
  Rados: cache-tierng support CEPH_OP_FLAG_TIER_NOCACHE
  Rados: add test case for CEPH_OP_FLAG_TIER_NOCACHE

 src/include/rados.h            |   1 +
 src/include/rados/librados.h   |   1 +
 src/include/rados/librados.hpp |   1 +
 src/librados/librados.cc       |   2 +
 src/osd/ReplicatedPG.cc        |   5 ++
 src/osd/osd_types.cc           |   1 +
 src/test/librados/tier.cc      | 176 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 187 insertions(+)

-- 
1.9.1

