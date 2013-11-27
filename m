From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 02/18] ceph: Add inline state definition
Date: Wed, 27 Nov 2013 21:40:41 +0800
Message-ID: <f102b223595153764aa0a44d84f2a19e6ef41d68.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48401 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab3K0NlU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:20 -0500
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
 src/include/ceph_fs.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/include/ceph_fs.h b/src/include/ceph_fs.h
index 47ec1f1..07a78b8 100644
--- a/src/include/ceph_fs.h
+++ b/src/include/ceph_fs.h
@@ -526,6 +526,9 @@ struct ceph_filelock {
 
 int ceph_flags_to_mode(int flags);
 
+/* inline data state */
+#define CEPH_INLINE_NONE	((__u64)-1)
+#define CEPH_INLINE_SIZE	(1 << 12)
 
 /* capability bits */
 #define CEPH_CAP_PIN         1  /* no specific capabilities beyond the pin */
-- 
1.7.9.5

