From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 08/18] mds: Push inline data to client in cap message
Date: Wed, 27 Nov 2013 21:40:47 +0800
Message-ID: <e752c3950aba1024fe96a6ee43d25a2601ed44d3.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48456 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3K0NlW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:22 -0500
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/mds/CInode.cc |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index c8b00ef..4756865 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2989,6 +2989,13 @@ void CInode::encode_cap_message(MClientCaps *m, Capability *cap)
   i->atime.encode_timeval(&m->head.atime);
   m->head.time_warp_seq = i->time_warp_seq;
 
+  if (cap->client_inline_version < i->inline_version) {
+    m->inline_version = cap->client_inline_version = i->inline_version;
+    m->inline_data = i->inline_data;
+  } else {
+    m->inline_version = 0;
+  }
+
   // max_size is min of projected, actual.
   uint64_t oldms = oi->client_ranges.count(client) ? oi->client_ranges[client].range.last : 0;
   uint64_t newms = pi->client_ranges.count(client) ? pi->client_ranges[client].range.last : 0;
-- 
1.7.9.5

