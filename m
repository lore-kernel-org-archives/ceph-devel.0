From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 1/2] Rados: cache-tierng support CEPH_OP_FLAG_TIER_NOCACHE
Date: Mon, 25 May 2015 11:32:16 +0800
Message-ID: <b4c2927f500e9ebbcf4dd8fec027c9da865a9563.1432523122.git.liwang@ubuntukylin.com>
References: <cover.1432523122.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:58207 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbEYDdz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 May 2015 23:33:55 -0400
In-Reply-To: <cover.1432523122.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1432523122.git.liwang@ubuntukylin.com>
References: <cover.1432523122.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>

From: Min Chen <minchen@ubuntukylin.com>

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Reviewed-by: Li Wang <liwang@ubuntukylin.com>
---
 src/include/rados.h            | 1 +
 src/include/rados/librados.h   | 1 +
 src/include/rados/librados.hpp | 1 +
 src/librados/librados.cc       | 2 ++
 src/osd/ReplicatedPG.cc        | 5 +++++
 src/osd/osd_types.cc           | 1 +
 6 files changed, 11 insertions(+)

diff --git a/src/include/rados.h b/src/include/rados.h
index 424bef1..203e9ad 100644
--- a/src/include/rados.h
+++ b/src/include/rados.h
@@ -410,6 +410,7 @@ enum {
 						      pool uses pool snaps */
 	CEPH_OSD_FLAG_REDIRECTED   = 0x200000,  /* op has been redirected */
 	CEPH_OSD_FLAG_KNOWN_REDIR = 0x400000,  /* redirect bit is authoritative */
+	CEPH_OSD_FLAG_TIER_NOCACHE = 0x800000,  /* DO NOT cache data in any cache-mode */
 };
 
 enum {
diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index 8d8d11b..41c3b14 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -120,6 +120,7 @@ enum {
   LIBRADOS_OPERATION_IGNORE_CACHE       = 8,
   LIBRADOS_OPERATION_SKIPRWLOCKS        = 16,
   LIBRADOS_OPERATION_IGNORE_OVERLAY     = 32,
+  LIBRADOS_OPERATION_TIER_NOCACHE     = 64,
 };
 /** @} */
 
diff --git a/src/include/rados/librados.hpp b/src/include/rados/librados.hpp
index 6a0253d..3aeecc9 100644
--- a/src/include/rados/librados.hpp
+++ b/src/include/rados/librados.hpp
@@ -259,6 +259,7 @@ namespace librados
     OPERATION_IGNORE_CACHE       = LIBRADOS_OPERATION_IGNORE_CACHE,
     OPERATION_SKIPRWLOCKS        = LIBRADOS_OPERATION_SKIPRWLOCKS,
     OPERATION_IGNORE_OVERLAY     = LIBRADOS_OPERATION_IGNORE_OVERLAY,
+    OPERATION_TIER_NOCACHE     = LIBRADOS_OPERATION_TIER_NOCACHE,
   };
 
   /*
diff --git a/src/librados/librados.cc b/src/librados/librados.cc
index a9eadfa..d5dd5fb 100644
--- a/src/librados/librados.cc
+++ b/src/librados/librados.cc
@@ -1290,6 +1290,8 @@ static int translate_flags(int flags)
     op_flags |= CEPH_OSD_FLAG_SKIPRWLOCKS;
   if (flags & librados::OPERATION_IGNORE_OVERLAY)
     op_flags |= CEPH_OSD_FLAG_IGNORE_OVERLAY;
+  if (flags & librados::OPERATION_TIER_NOCACHE)
+    op_flags |= CEPH_OSD_FLAG_TIER_NOCACHE;
 
   return op_flags;
 }
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 4c549a5..36a6269 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1807,6 +1807,11 @@ bool ReplicatedPG::maybe_handle_cache(OpRequestRef op,
   MOSDOp *m = static_cast<MOSDOp*>(op->get_req());
   const object_locator_t& oloc = m->get_object_locator();
 
+  if (m->has_flag(CEPH_OSD_FLAG_TIER_NOCACHE)) {
+    do_cache_redirect(op);
+    return true;
+  }
+
   if (must_promote || op->need_promote()) {
     promote_object(obc, missing_oid, oloc, op);
     return true;
diff --git a/src/osd/osd_types.cc b/src/osd/osd_types.cc
index a73b46f..8caae62 100644
--- a/src/osd/osd_types.cc
+++ b/src/osd/osd_types.cc
@@ -50,6 +50,7 @@ const char *ceph_osd_flag_name(unsigned flag)
   case CEPH_OSD_FLAG_ENFORCE_SNAPC: return "enforce_snapc";
   case CEPH_OSD_FLAG_REDIRECTED: return "redirected";
   case CEPH_OSD_FLAG_KNOWN_REDIR: return "known_if_redirected";
+  case CEPH_OSD_FLAG_TIER_NOCACHE: return "tier_nocache";
   default: return "???";
   }
 }
-- 
1.9.1

