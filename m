From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: [PATCH] osd: add local_mtime to struct object_info_t
Date: Fri, 1 Aug 2014 08:45:45 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489271C9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41845 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbaHAIpr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 04:45:47 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>

As we discussed before, adding a new field in struct object_info_t to solve the skipping flush problem. This patch is also available as a pull request at https://github.com/ceph/ceph/pull/2188

This fixes a bug when the time of the OSDs and clients are not
synchronized (especially when client is ahead of OSD), and the cache
tier dirty ratio reaches the threshold, the agent skips the flush work
because it thinks the object is too young.

Signed-off-by: Zhiqiang Wang <wonzhq@hotmail.com>
---
src/osd/ReplicatedPG.cc | 11 ++++++++++-
src/osd/osd_types.cc    | 10 +++++++++-
src/osd/osd_types.h     |  1 +
3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index bc431bd..4bd8a8b 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -5187,6 +5187,7 @@ void ReplicatedPG::finish_ctx(OpContext *ctx, int log_op_type, bool maintain_ssc
   dout(20) << __func__ << " " << soid << " " << ctx
           << " op " << pg_log_entry_t::get_op_name(log_op_type)
           << dendl;
+  utime_t now = ceph_clock_now(cct);

   // snapset
   bufferlist bss;
@@ -5245,6 +5246,7 @@ void ReplicatedPG::finish_ctx(OpContext *ctx, int log_op_type, bool maintain_ssc
       ctx->snapset_obc->obs.oi.version = ctx->at_version;
       ctx->snapset_obc->obs.oi.last_reqid = ctx->reqid;
       ctx->snapset_obc->obs.oi.mtime = ctx->mtime;
+      ctx->snapset_obc->obs.oi.local_mtime = now;

       bufferlist bv(sizeof(ctx->new_obs.oi));
       ::encode(ctx->snapset_obc->obs.oi, bv);
@@ -5285,6 +5287,7 @@ void ReplicatedPG::finish_ctx(OpContext *ctx, int log_op_type, bool maintain_ssc
     if (ctx->mtime != utime_t()) {
       ctx->new_obs.oi.mtime = ctx->mtime;
       dout(10) << " set mtime to " << ctx->new_obs.oi.mtime << dendl;
+      ctx->new_obs.oi.local_mtime = now;
     } else {
       dout(10) << " mtime unchanged at " << ctx->new_obs.oi.mtime << dendl;
     }
@@ -11333,7 +11336,13 @@ bool ReplicatedPG::agent_maybe_flush(ObjectContextRef& obc)
   }

   utime_t now = ceph_clock_now(NULL);
-  if (obc->obs.oi.mtime + utime_t(pool.info.cache_min_flush_age, 0) > now) {
+  utime_t ob_local_mtime;
+  if (obc->obs.oi.local_mtime != utime_t()) {
+    ob_local_mtime = obc->obs.oi.local_mtime;
+  } else {
+    ob_local_mtime = obc->obs.oi.mtime;
+  }
+  if (ob_local_mtime + utime_t(pool.info.cache_min_flush_age, 0) > now) {
     dout(20) << __func__ << " skip (too young) " << obc->obs.oi << dendl;
     osd->logger->inc(l_osd_agent_skip);
     return false;
diff --git a/src/osd/osd_types.cc b/src/osd/osd_types.cc
index 58862dc..3bd4696 100644
--- a/src/osd/osd_types.cc
+++ b/src/osd/osd_types.cc
@@ -3693,6 +3693,7 @@ void object_info_t::copy_user_bits(const object_info_t& other)
   // these bits are copied from head->clone.
   size = other.size;
   mtime = other.mtime;
+  local_mtime = other.local_mtime;
   last_reqid = other.last_reqid;
   truncate_seq = other.truncate_seq;
   truncate_size = other.truncate_size;
@@ -3724,7 +3725,7 @@ void object_info_t::encode(bufferlist& bl) const
        ++i) {
     old_watchers.insert(make_pair(i->first.second, i->second));
   }
-  ENCODE_START(13, 8, bl);
+  ENCODE_START(14, 8, bl);
   ::encode(soid, bl);
   ::encode(myoloc, bl);        //Retained for compatibility
   ::encode(category, bl);
@@ -3749,6 +3750,7 @@ void object_info_t::encode(bufferlist& bl) const
   ::encode(watchers, bl);
   __u32 _flags = flags;
   ::encode(_flags, bl);
+  ::encode(local_mtime, bl);
   ENCODE_FINISH(bl);
}

@@ -3827,6 +3829,11 @@ void object_info_t::decode(bufferlist::iterator& bl)
     ::decode(_flags, bl);
     flags = (flag_t)_flags;
   }
+  if (struct_v >= 14) {
+    ::decode(local_mtime, bl);
+  } else {
+    local_mtime = utime_t();
+  }
   DECODE_FINISH(bl);
}

@@ -3842,6 +3849,7 @@ void object_info_t::dump(Formatter *f) const
   f->dump_unsigned("user_version", user_version);
   f->dump_unsigned("size", size);
   f->dump_stream("mtime") << mtime;
+  f->dump_stream("local_mtime") << local_mtime;
   f->dump_unsigned("lost", (int)is_lost());
   f->dump_unsigned("flags", (int)flags);
   f->dump_stream("wrlock_by") << wrlock_by;
diff --git a/src/osd/osd_types.h b/src/osd/osd_types.h
index a058f06..a554979 100644
--- a/src/osd/osd_types.h
+++ b/src/osd/osd_types.h
@@ -2592,6 +2592,7 @@ struct object_info_t {

   uint64_t size;
   utime_t mtime;
+  utime_t local_mtime; // local mtime

   // note: these are currently encoded into a total 16 bits; see
   // encode()/decode() for the weirdness.
--
1.9.1
