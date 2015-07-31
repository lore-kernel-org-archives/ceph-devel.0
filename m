From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/4] tracing: add missing tracepoints for writesame and extent_cmp
Date: Fri, 31 Jul 2015 18:32:52 +0200
Message-ID: <1438360373-14377-1-git-send-email-ddiss@suse.de>
References: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56212 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbbGaQdH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Jul 2015 12:33:07 -0400
In-Reply-To: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 src/tracing/osd.tp | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/tracing/osd.tp b/src/tracing/osd.tp
index ba0fd32..a9f2d13 100644
--- a/src/tracing/osd.tp
+++ b/src/tracing/osd.tp
@@ -91,6 +91,28 @@ TRACEPOINT_EVENT(osd, do_osd_op_pre,
     )
 )
 
+TRACEPOINT_EVENT(osd, do_osd_op_pre_extent_cmp,
+    TP_ARGS(
+        const char*, oid,
+        uint64_t, snap,
+        uint64_t, osize,
+        uint32_t, oseq,
+        uint64_t, offset,
+        uint64_t, length,
+        uint64_t, truncate_size,
+        uint32_t, truncate_seq),
+    TP_FIELDS(
+        ctf_string(oid, oid)
+        ctf_integer(uint64_t, snap, snap)
+        ctf_integer(uint64_t, osize, osize)
+        ctf_integer(uint32_t, oseq, oseq)
+        ctf_integer(uint64_t, offset, offset)
+        ctf_integer(uint64_t, length, length)
+        ctf_integer(uint64_t, truncate_size, truncate_size)
+        ctf_integer(uint32_t, truncate_seq, truncate_seq)
+    )
+)
+
 TRACEPOINT_EVENT(osd, do_osd_op_pre_read,
     TP_ARGS(
         const char*, oid,
@@ -381,6 +403,24 @@ TRACEPOINT_EVENT(osd, do_osd_op_pre_writefull,
     )
 )
 
+TRACEPOINT_EVENT(osd, do_osd_op_pre_writesame,
+    TP_ARGS(
+        const char*, oid,
+        uint64_t, snap,
+        uint64_t, osize,
+        uint64_t, offset,
+        uint64_t, length,
+        uint64_t, data_length),
+    TP_FIELDS(
+        ctf_string(oid, oid)
+        ctf_integer(uint64_t, snap, snap)
+        ctf_integer(uint64_t, osize, osize)
+        ctf_integer(uint64_t, offset, offset)
+        ctf_integer(uint64_t, length, length)
+        ctf_integer(uint64_t, data_length, data_length)
+    )
+)
+
 TRACEPOINT_EVENT(osd, do_osd_op_pre_rollback,
     TP_ARGS(
         const char*, oid,
-- 
2.1.4

