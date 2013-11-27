From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 14/18] client: Push inline data to mds by send cap
Date: Wed, 27 Nov 2013 21:40:53 +0800
Message-ID: <88f90b03dd634d91d2a8e5c7bba9cd25956d8f85.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48497 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab3K0NlY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:24 -0500
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
 src/client/Client.cc |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 19d31e0..3beab8f 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -2399,6 +2399,11 @@ void Client::send_cap(Inode *in, MetaSession *session, Cap *cap,
   in->ctime.encode_timeval(&m->head.ctime);
   m->head.time_warp_seq = in->time_warp_seq;
     
+  if (flush & CEPH_CAP_FILE_WR) {
+    m->inline_version = in->inline_version;
+    m->inline_data = in->inline_data;
+  }
+
   in->reported_size = in->size;
   m->set_snap_follows(follows);
   cap->wanted = want;
-- 
1.7.9.5

