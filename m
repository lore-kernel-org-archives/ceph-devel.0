From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 07/18] mds: Add inline fields to Capability
Date: Wed, 27 Nov 2013 21:40:46 +0800
Message-ID: <9bdf9fbd2e51a5ceed328ba975dfea1e3de0887e.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48455 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab3K0NlW (ORCPT
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
 src/mds/Capability.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index fb6b3dc..995ea3a 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -209,6 +209,7 @@ private:
 public:
   snapid_t client_follows;
   version_t client_xattr_version;
+  uint64_t client_inline_version;
   
   xlist<Capability*>::item item_session_caps;
   xlist<Capability*>::item item_snaprealm_caps;
@@ -223,6 +224,7 @@ public:
     mseq(0),
     suppress(0), stale(false),
     client_follows(0), client_xattr_version(0),
+    client_inline_version(0),
     item_session_caps(this), item_snaprealm_caps(this) {
     g_num_cap++;
     g_num_capa++;
-- 
1.7.9.5

