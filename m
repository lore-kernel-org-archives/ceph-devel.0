From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH 3/6] OSD support for blkin (LTTng + Zipkin) tracing
Date: Wed, 12 Nov 2014 16:20:40 -0700
Message-ID: <20141112232040.GD6892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:45054 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbaKLXUo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 18:20:44 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so14074615pad.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 15:20:43 -0800 (PST)
Received: from localhost (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id rz6sm23047250pbc.74.2014.11.12.15.20.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 15:20:43 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Adds tracing for OSDs and Placement Groups, specifically:
messages for OSD operations, FileJournal, FileStore,
ECBackend, replication, and traced versions of Objecter
read/write (only basic read/write functions).

Moves global_init_daemonize() earlier in ceph_osd.c:main

These changes are Marios', with the following exceptions:
 - split out OSD support from other tracing changes
 - only Message.h includes blkin, as others include Message.h
 - commented code has been removed
 - whitespace issues have been fixed
 - braces added to conditionals to match recommended coding style
   - note: did not change member variable names to use m_ prefix
           since member vars in same class did not
 - Ref suffix added to TrackedOp shared_ptr vars to be consistent
   - note: did not add -Ref suffix to ZTrace*Ref vars

Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 src/ceph_osd.cc               |  6 +++--
 src/messages/MOSDOp.h         | 51 ++++++++++++++++++++++++++++++++++-
 src/messages/MOSDOpReply.h    | 47 +++++++++++++++++++++++++++++++-
 src/messages/MOSDSubOp.h      | 37 ++++++++++++++++++++++++-
 src/messages/MOSDSubOpReply.h | 47 +++++++++++++++++++++++++++++++-
 src/os/FileJournal.cc         | 14 +++++++---
 src/os/FileJournal.h          |  7 ++++-
 src/os/FileStore.cc           | 20 ++++++++++++++
 src/os/FileStore.h            |  4 +++
 src/osd/ECBackend.cc          |  8 ++++--
 src/osd/OSD.cc                | 16 +++++++++++
 src/osd/OSD.h                 |  1 +
 src/osd/OpRequest.h           |  2 ++
 src/osd/PG.cc                 |  3 +++
 src/osd/PG.h                  |  2 ++
 src/osd/ReplicatedBackend.cc  | 19 ++++++++++---
 src/osd/ReplicatedPG.cc       | 38 ++++++++++++++++++++++++++
 src/osdc/Objecter.cc          | 15 +++++++++++
 src/osdc/Objecter.h           | 63 ++++++++++++++++++++++++++++++++++++++++++-
 19 files changed, 383 insertions(+), 17 deletions(-)

diff --git a/src/ceph_osd.cc b/src/ceph_osd.cc
index 029ef28..7a714c9 100644
--- a/src/ceph_osd.cc
+++ b/src/ceph_osd.cc
@@ -148,6 +148,9 @@ int main(int argc, const char **argv)
     return 0;
   }
 
+  global_init_daemonize(g_ceph_context, 0);
+  ZTracer::ztrace_init();
+
   // whoami
   char *end;
   const char *id = g_conf->name.get_id().c_str();
@@ -433,8 +436,7 @@ int main(int argc, const char **argv)
 
   ms_objecter->bind(g_conf->public_addr);
 
-  // Set up crypto, daemonize, etc.
-  global_init_daemonize(g_ceph_context, 0);
+  // Set up crypto, etc.
   common_init_finish(g_ceph_context);
 
   if (g_conf->filestore_update_to >= (int)store->get_target_version()) {
diff --git a/src/messages/MOSDOp.h b/src/messages/MOSDOp.h
index ed0a669..8f509e0 100644
--- a/src/messages/MOSDOp.h
+++ b/src/messages/MOSDOp.h
@@ -32,7 +32,7 @@ class OSD;
 
 class MOSDOp : public Message {
 
-  static const int HEAD_VERSION = 4;
+  static const int HEAD_VERSION = 5;
   static const int COMPAT_VERSION = 3;
 
 private:
@@ -176,6 +176,7 @@ public:
 
   // marshalling
   virtual void encode_payload(uint64_t features) {
+    ZTracer::ZTraceRef mt = get_master_trace();
 
     OSDOp::merge_osd_op_vector_in_data(ops, data);
 
@@ -251,11 +252,28 @@ struct ceph_osd_request_head {
       ::encode(snaps, payload);
 
       ::encode(retry_attempt, payload);
+
+      if (mt) {
+	struct blkin_trace_info tinfo;
+	mt->get_trace_info(&tinfo); //master_trace_info
+	::encode(tinfo.trace_id, payload);
+	::encode(tinfo.span_id, payload);
+	::encode(tinfo.parent_span_id, payload);
+      } else {
+	int64_t zero = 0;
+	::encode(zero, payload);
+	::encode(zero, payload);
+	::encode(zero, payload);
+      }
     }
   }
 
   virtual void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    struct blkin_trace_info tinfo;
+    tinfo.trace_id = 0;
+    tinfo.span_id = 0;
+    tinfo.parent_span_id = 0;
 
     if (header.version < 2) {
       // old decode
@@ -332,8 +350,16 @@ struct ceph_osd_request_head {
 	::decode(retry_attempt, p);
       else
 	retry_attempt = -1;
+
+      if (header.version >= 5) {
+        ::decode(tinfo.trace_id, p);
+        ::decode(tinfo.span_id, p);
+        ::decode(tinfo.parent_span_id, p);
+      }
     }
 
+    init_trace_info(&tinfo);
+
     OSDOp::split_osd_op_vector_in_data(ops, data);
   }
 
@@ -374,6 +400,29 @@ struct ceph_osd_request_head {
     out << " e" << osdmap_epoch;
     out << ")";
   }
+
+  void trace_msg_info()
+  {
+    if (!master_trace) {
+      return;
+    }
+
+    ostringstream oss;
+    oss << get_reqid();
+
+    master_trace->keyval("Type", "MOSDOp");
+    master_trace->keyval("Reqid", oss.str());
+  }
+
+  bool create_message_endpoint()
+  {
+    message_endpoint = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "MOSDOp");
+    if (!message_endpoint) {
+      return false;
+    }
+
+    return true;
+  }
 };
 
 
diff --git a/src/messages/MOSDOpReply.h b/src/messages/MOSDOpReply.h
index 91c50e7..abf21b5 100644
--- a/src/messages/MOSDOpReply.h
+++ b/src/messages/MOSDOpReply.h
@@ -32,7 +32,7 @@
 
 class MOSDOpReply : public Message {
 
-  static const int HEAD_VERSION = 6;
+  static const int HEAD_VERSION = 7;
   static const int COMPAT_VERSION = 2;
 
   object_t oid;
@@ -144,6 +144,15 @@ public:
       if (ignore_out_data)
 	ops[i].outdata.clear();
     }
+    struct blkin_trace_info tinfo;
+    ZTracer::ZTraceRef mt = req->get_master_trace();
+    if (!mt) {
+      return;
+    }
+    mt->get_trace_info(&tinfo);
+    if (!tinfo.parent_span_id) {
+	    trace_end_after_span = false;
+    }
   }
 private:
   ~MOSDOpReply() {}
@@ -151,6 +160,7 @@ private:
 public:
   virtual void encode_payload(uint64_t features) {
 
+    ZTracer::ZTraceRef mt = get_master_trace();
     OSDOp::merge_osd_op_vector_out_data(ops, data);
 
     if ((features & CEPH_FEATURE_PGID64) == 0) {
@@ -190,10 +200,28 @@ public:
       ::encode(replay_version, payload);
       ::encode(user_version, payload);
       ::encode(redirect, payload);
+
+      if (mt) {
+	struct blkin_trace_info tinfo;
+	mt->get_trace_info(&tinfo); //master_trace_info
+	::encode(tinfo.trace_id, payload);
+	::encode(tinfo.span_id, payload);
+	::encode(tinfo.parent_span_id, payload);
+      } else {
+	int64_t zero = 0;
+	::encode(zero, payload);
+	::encode(zero, payload);
+	::encode(zero, payload);
+      }
     }
+
   }
   virtual void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    struct blkin_trace_info tinfo;
+    tinfo.trace_id = 0;
+    tinfo.span_id = 0;
+    tinfo.parent_span_id = 0;
     if (header.version < 2) {
       ceph_osd_reply_head head;
       ::decode(head, p);
@@ -245,6 +273,13 @@ public:
 
       if (header.version >= 6)
 	::decode(redirect, p);
+
+      if (header.version >= 7) {
+	::decode(tinfo.trace_id, p);
+	::decode(tinfo.span_id, p);
+	::decode(tinfo.parent_span_id, p);
+      }
+      init_trace_info(&tinfo);
     }
   }
 
@@ -271,6 +306,16 @@ public:
     out << ")";
   }
 
+  bool create_message_endpoint()
+  {
+    message_endpoint = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "MOSDOpReply");
+    if (!message_endpoint) {
+      return false;
+    }
+
+    return true;
+  }
+
 };
 
 
diff --git a/src/messages/MOSDSubOp.h b/src/messages/MOSDSubOp.h
index 6a38186..da31f44 100644
--- a/src/messages/MOSDSubOp.h
+++ b/src/messages/MOSDSubOp.h
@@ -25,7 +25,7 @@
 
 class MOSDSubOp : public Message {
 
-  static const int HEAD_VERSION = 10;
+  static const int HEAD_VERSION = 11;
   static const int COMPAT_VERSION = 1;
 
 public:
@@ -102,6 +102,10 @@ public:
   virtual void decode_payload() {
     hobject_incorrect_pool = false;
     bufferlist::iterator p = payload.begin();
+    struct blkin_trace_info tinfo;
+    tinfo.trace_id = 0;
+    tinfo.span_id = 0;
+    tinfo.parent_span_id= 0;
     ::decode(map_epoch, p);
     ::decode(reqid, p);
     ::decode(pgid.pgid, p);
@@ -175,6 +179,13 @@ public:
     if (header.version >= 10) {
       ::decode(updated_hit_set_history, p);
     }
+
+    if (header.version >= 11) {
+      ::decode(tinfo.trace_id, p);
+      ::decode(tinfo.span_id, p);
+      ::decode(tinfo.parent_span_id, p);
+    }
+    init_trace_info(&tinfo);
   }
 
   virtual void encode_payload(uint64_t features) {
@@ -182,6 +193,7 @@ public:
     ::encode(reqid, payload);
     ::encode(pgid.pgid, payload);
     ::encode(poid, payload);
+    ZTracer::ZTraceRef mt = get_master_trace();
 
     __u32 num_ops = ops.size();
     ::encode(num_ops, payload);
@@ -224,6 +236,19 @@ public:
     ::encode(from, payload);
     ::encode(pgid.shard, payload);
     ::encode(updated_hit_set_history, payload);
+
+    if (mt) {
+      struct blkin_trace_info tinfo;
+      mt->get_trace_info(&tinfo);
+      ::encode(tinfo.trace_id, payload);
+      ::encode(tinfo.span_id, payload);
+      ::encode(tinfo.parent_span_id, payload);
+    } else {
+      int64_t zero = 0;
+      ::encode(zero, payload);
+      ::encode(zero, payload);
+      ::encode(zero, payload);
+    }
   }
 
   MOSDSubOp()
@@ -269,6 +294,16 @@ public:
       out << ", has_updated_hit_set_history";
     out << ")";
   }
+
+  bool create_message_endpoint()
+  {
+    message_endpoint = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "MOSDSubOp");
+    if (!message_endpoint) {
+      return false;
+    }
+
+    return true;
+  }
 };
 
 
diff --git a/src/messages/MOSDSubOpReply.h b/src/messages/MOSDSubOpReply.h
index 270629f..3fb8120 100644
--- a/src/messages/MOSDSubOpReply.h
+++ b/src/messages/MOSDSubOpReply.h
@@ -30,7 +30,7 @@
  */
 
 class MOSDSubOpReply : public Message {
-  static const int HEAD_VERSION = 2;
+  static const int HEAD_VERSION = 3;
   static const int COMPAT_VERSION = 1;
 public:
   epoch_t map_epoch;
@@ -55,6 +55,10 @@ public:
 
   virtual void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    struct blkin_trace_info tinfo;
+    tinfo.trace_id = 0;
+    tinfo.span_id = 0;
+    tinfo.parent_span_id = 0;
     ::decode(map_epoch, p);
     ::decode(reqid, p);
     ::decode(pgid.pgid, p);
@@ -84,8 +88,16 @@ public:
 	ghobject_t::NO_SHARD);
       pgid.shard = ghobject_t::NO_SHARD;
     }
+    if (header.version >= 3) {
+      ::decode(tinfo.trace_id, p);
+      ::decode(tinfo.span_id, p);
+      ::decode(tinfo.parent_span_id, p);
+    }
+    init_trace_info(&tinfo);
   }
   virtual void encode_payload(uint64_t features) {
+    ZTracer::ZTraceRef mt = get_master_trace();
+
     ::encode(map_epoch, payload);
     ::encode(reqid, payload);
     ::encode(pgid.pgid, payload);
@@ -102,6 +114,20 @@ public:
     ::encode(attrset, payload);
     ::encode(from, payload);
     ::encode(pgid.shard, payload);
+
+    if (mt) {
+      struct blkin_trace_info tinfo;
+      mt->get_trace_info(&tinfo); //master_trace_info
+      ::encode(tinfo.trace_id, payload);
+      ::encode(tinfo.span_id, payload);
+      ::encode(tinfo.parent_span_id, payload);
+    } else {
+      int64_t zero = 0;
+      ::encode(zero, payload);
+      ::encode(zero, payload);
+      ::encode(zero, payload);
+    }
+
   }
 
   epoch_t get_map_epoch() { return map_epoch; }
@@ -138,6 +164,15 @@ public:
     result(result_) {
     memset(&peer_stat, 0, sizeof(peer_stat));
     set_tid(req->get_tid());
+    struct blkin_trace_info tinfo;
+    ZTracer::ZTraceRef mt = req->get_master_trace();
+    if (!mt) {
+      return;
+    }
+    mt->get_trace_info(&tinfo);
+    if (!tinfo.parent_span_id) {
+	    trace_end_after_span = false;
+    }
   }
   MOSDSubOpReply() : Message(MSG_OSD_SUBOPREPLY) {}
 private:
@@ -160,6 +195,16 @@ public:
     out << ")";
   }
 
+  bool create_message_endpoint()
+  {
+    message_endpoint = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "MOSDSubOpReply");
+    if (!message_endpoint) {
+      return false;
+    }
+
+    return true;
+  }
+
 };
 
 
diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index c6bd616..f82caa8 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -837,8 +837,11 @@ void FileJournal::queue_completions_thru(uint64_t seq)
     }
     if (next.finish)
       finisher->queue(next.finish);
-    if (next.tracked_op)
+    if (next.tracked_op) {
       next.tracked_op->mark_event("journaled_completion_queued");
+      next.tracked_op->trace_journal("Journaled completion queued");
+      next.tracked_op->trace_journal("Span ended");
+    }
   }
   finisher_cond.Signal();
 }
@@ -897,8 +900,10 @@ int FileJournal::prepare_single_write(bufferlist& bl, off64_t& queue_pos, uint64
   }
   bl.append((const char*)&h, sizeof(h));
 
-  if (next_write.tracked_op)
+  if (next_write.tracked_op) {
     next_write.tracked_op->mark_event("write_thread_in_journal_buffer");
+    next_write.tracked_op->trace_journal("write thread in journal buffer");
+  }
 
   // pop from writeq
   pop_write();
@@ -1428,8 +1433,11 @@ void FileJournal::submit_entry(uint64_t seq, bufferlist& e, int alignment,
   dout(30) << "XXX throttle take " << e.length() << dendl;
   throttle_ops.take(1);
   throttle_bytes.take(e.length());
-  if (osd_op)
+  if (osd_op) {
     osd_op->mark_event("commit_queued_for_journal_write");
+    osd_op->create_journal_trace(get_trace_endpoint());
+    osd_op->trace_journal("Commit queued for journal write");
+  }
   if (logger) {
     logger->set(l_os_jq_max_ops, throttle_ops.get_max());
     logger->set(l_os_jq_max_bytes, throttle_bytes.get_max());
diff --git a/src/os/FileJournal.h b/src/os/FileJournal.h
index dbb1181..3607467 100644
--- a/src/os/FileJournal.h
+++ b/src/os/FileJournal.h
@@ -215,6 +215,7 @@ public:
   } __attribute__((__packed__, aligned(4)));
 
 private:
+  TrackedOpEndpointRef journal_endpoint;
   string fn;
 
   char *zero_buf;
@@ -380,11 +381,15 @@ private:
     write_lock("FileJournal::write_lock", false, true, false, g_ceph_context),
     write_stop(false),
     write_thread(this),
-    write_finish_thread(this) { }
+    write_finish_thread(this)
+  {
+      journal_endpoint = ZTracer::create_ZTraceEndpoint("", 0, "Journal (" + fn + ")");
+  }
   ~FileJournal() {
     delete[] zero_buf;
   }
 
+  TrackedOpEndpointRef get_trace_endpoint() { return journal_endpoint; }
   int check();
   int create();
   int open(uint64_t fs_op_seq);
diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index 9d6252c..10346dc 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -467,6 +467,7 @@ FileStore::FileStore(const std::string &base, const std::string &jdev, const cha
   m_filestore_max_inline_xattrs(0)
 {
   m_filestore_kill_at.set(g_conf->filestore_kill_at);
+  filestore_endpoint = ZTracer::create_ZTraceEndpoint("", 0, "Filestore (" + basedir + "(" + name + ")" + ")");
 
   ostringstream oss;
   oss << basedir << "/current";
@@ -1613,6 +1614,9 @@ void FileStore::queue_op(OpSequencer *osr, Op *o)
   // so that regardless of which order the threads pick up the
   // sequencer, the op order will be preserved.
 
+  if (o->osd_op) {
+    o->osd_op->trace_osd("Queueing for filestore");
+  }
   osr->queue(o);
 
   logger->inc(l_os_ops);
@@ -1624,6 +1628,9 @@ void FileStore::queue_op(OpSequencer *osr, Op *o)
 	  << "   (queue has " << op_queue_len << " ops and " << op_queue_bytes << " bytes)"
 	  << dendl;
   op_wq.queue(osr);
+  if (o->osd_op) {
+    o->osd_op->trace_osd("Queued for filestore");
+  }
 }
 
 void FileStore::op_queue_reserve_throttle(Op *o, ThreadPool::TPHandle *handle)
@@ -1694,8 +1701,17 @@ void FileStore::_do_op(OpSequencer *osr, ThreadPool::TPHandle &handle)
   osr->apply_lock.Lock();
   Op *o = osr->peek_queue();
   apply_manager.op_apply_start(o->op);
+
+  if (o->osd_op) {
+    o->osd_op->create_filestore_trace(get_trace_endpoint());
+    o->osd_op->trace_filestore("Filestore dequeued");
+  }
   dout(5) << "_do_op " << o << " seq " << o->op << " " << *osr << "/" << osr->parent << " start" << dendl;
   int r = _do_transactions(o->tls, o->op, &handle);
+
+  if (o->osd_op) {
+    o->osd_op->trace_filestore("Filestore finished");
+  }
   apply_manager.op_apply_finish(o->op);
   dout(10) << "_do_op " << o << " seq " << o->op << " r = " << r
 	   << ", finisher " << o->onreadable << " " << o->onreadable_sync << dendl;
@@ -1704,6 +1720,10 @@ void FileStore::_do_op(OpSequencer *osr, ThreadPool::TPHandle &handle)
 void FileStore::_finish_op(OpSequencer *osr)
 {
   Op *o = osr->dequeue();
+  if (o->osd_op) {
+    o->osd_op->trace_filestore("Filestore finishing op");
+    o->osd_op->trace_filestore("Span ended");
+  }
   
   dout(10) << "_finish_op " << o << " seq " << o->op << " " << *osr << "/" << osr->parent << dendl;
   osr->apply_lock.Unlock();  // locked in _do_op
diff --git a/src/os/FileStore.h b/src/os/FileStore.h
index 4c9ffdb..b4414b8 100644
--- a/src/os/FileStore.h
+++ b/src/os/FileStore.h
@@ -124,6 +124,7 @@ public:
   }
 
 private:
+  TrackedOpEndpointRef filestore_endpoint;
   string internal_name;         ///< internal name, used to name the perfcounter instance
   string basedir, journalpath;
   std::string current_fn;
@@ -353,6 +354,9 @@ public:
   int get_max_object_name_length();
   int mkfs();
   int mkjournal();
+  TrackedOpEndpointRef get_trace_endpoint() {
+    return filestore_endpoint;
+  };
 
   /**
    * set_allow_sharded_objects()
diff --git a/src/osd/ECBackend.cc b/src/osd/ECBackend.cc
index 3c27288..960d4aa 100644
--- a/src/osd/ECBackend.cc
+++ b/src/osd/ECBackend.cc
@@ -724,8 +724,10 @@ struct SubWriteCommitted : public Context {
     : pg(pg), msg(msg), tid(tid),
       version(version), last_complete(last_complete) {}
   void finish(int) {
-    if (msg)
+    if (msg) {
+      msg->trace_pg("sub op commited");
       msg->mark_event("sub_op_committed");
+    }
     pg->sub_write_committed(tid, version, last_complete);
   }
 };
@@ -766,8 +768,10 @@ struct SubWriteApplied : public Context {
     eversion_t version)
     : pg(pg), msg(msg), tid(tid), version(version) {}
   void finish(int) {
-    if (msg)
+    if (msg) {
+      msg->trace_pg("sub op applied");
       msg->mark_event("sub_op_applied");
+    }
     pg->sub_write_applied(tid, version);
   }
 };
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 4240ba8..40992a7 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -21,6 +21,7 @@
 #include <signal.h>
 #include <ctype.h>
 #include <boost/scoped_ptr.hpp>
+#include <boost/lexical_cast.hpp>
 
 #ifdef HAVE_SYS_PARAM_H
 #include <sys/param.h>
@@ -963,6 +964,9 @@ OSD::OSD(CephContext *cct_, ObjectStore *store_,
                                          cct->_conf->osd_op_log_threshold);
   op_tracker.set_history_size_and_duration(cct->_conf->osd_op_history_size,
                                            cct->_conf->osd_op_history_duration);
+
+  string s = "osd." + boost::lexical_cast<string>(whoami);
+  osd_endpoint = ZTracer::create_ZTraceEndpoint("", 0, s);
 }
 
 OSD::~OSD()
@@ -5023,6 +5027,8 @@ void OSD::_dispatch(Message *m)
   default:
     {
       OpRequestRef op = op_tracker.create_request<OpRequest>(m);
+      op->create_osd_trace(osd_endpoint);
+      op->trace_osd("waiting of osdmap");
       op->mark_event("waiting_for_osdmap");
       // no map?  starting up?
       if (!osdmap) {
@@ -7386,6 +7392,8 @@ void OSD::handle_op(OpRequestRef op)
     return;
   }
 
+  op->trace_osd("Handling op");
+
   // we don't need encoded payload anymore
   m->clear_payload();
 
@@ -7513,7 +7521,10 @@ void OSD::handle_op(OpRequestRef op)
     return;
   }
 
+  op->create_pg_trace(pg->get_trace_endpoint());
+  op->trace_pg("Enqueuing op");
   enqueue_op(pg, op);
+  op->trace_pg("Enqueued op");
 }
 
 template<typename T, int MSGTYPE>
@@ -7522,6 +7533,8 @@ void OSD::handle_replica_op(OpRequestRef op)
   T *m = static_cast<T *>(op->get_req());
   assert(m->get_header().type == MSGTYPE);
 
+  op->trace_osd("Handling replica op");
+
   dout(10) << __func__ << " " << *m << " epoch " << m->map_epoch << dendl;
   if (m->map_epoch < up_epoch) {
     dout(3) << "replica op from before up" << dendl;
@@ -7553,7 +7566,9 @@ void OSD::handle_replica_op(OpRequestRef op)
   if (!pg) {
     return;
   }
+  op->create_pg_trace(pg->get_trace_endpoint());
   enqueue_op(pg, op);
+  op->trace_osd("Enqueued replica op");
 }
 
 bool OSD::op_is_discardable(MOSDOp *op)
@@ -7655,6 +7670,7 @@ void OSD::OpWQ::_process(PGRef pg, ThreadPool::TPHandle &handle)
   delete f;
   *_dout << dendl;
 
+  op->trace_pg("Dequeued op");
   osd->dequeue_op(pg, op, handle);
   pg->unlock();
 }
diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index ce8b74c..58cf10c 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -791,6 +791,7 @@ protected:
   AuthAuthorizeHandlerRegistry *authorize_handler_cluster_registry;
   AuthAuthorizeHandlerRegistry *authorize_handler_service_registry;
 
+  TrackedOpEndpointRef osd_endpoint;
   Messenger   *cluster_messenger;
   Messenger   *client_messenger;
   Messenger   *objecter_messenger;
diff --git a/src/osd/OpRequest.h b/src/osd/OpRequest.h
index 569b6fc..9743d6d 100644
--- a/src/osd/OpRequest.h
+++ b/src/osd/OpRequest.h
@@ -140,12 +140,14 @@ public:
     latest_flag_point = flag_started;
   }
   void mark_sub_op_sent(string s) {
+    trace_pg("Sub op sent | " + s);
     mark_event(s);
     current = s;
     hit_flag_points |= flag_sub_op_sent;
     latest_flag_point = flag_sub_op_sent;
   }
   void mark_commit_sent() {
+    trace_pg("Commit sent");
     mark_event("commit_sent");
     current = "commit sent";
     hit_flag_points |= flag_commit_sent;
diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index 6deb099..9fb6ff3 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -199,6 +199,9 @@ PG::PG(OSDService *o, OSDMapRef curmap,
 #ifdef PG_DEBUG_REFS
   osd->add_pgid(p, this);
 #endif
+  ostringstream oss;
+  oss << "PG " << info.pgid;
+  pg_endpoint = ZTracer::create_ZTraceEndpoint("", 0, oss.str());
 }
 
 PG::~PG()
diff --git a/src/osd/PG.h b/src/osd/PG.h
index 1fce297..3f69b4c 100644
--- a/src/osd/PG.h
+++ b/src/osd/PG.h
@@ -206,6 +206,7 @@ protected:
   OSDMapRef osdmap_ref;
   OSDMapRef last_persisted_osdmap_ref;
   PGPool pool;
+  TrackedOpEndpointRef pg_endpoint;
 
   void queue_op(OpRequestRef op);
   void take_op_map_waiters();
@@ -265,6 +266,7 @@ public:
     return _lock.is_locked();
   }
 
+  TrackedOpEndpointRef get_trace_endpoint() { return pg_endpoint; }
 #ifdef PG_DEBUG_REFS
   uint64_t get_with_id();
   void put_with_id(uint64_t);
diff --git a/src/osd/ReplicatedBackend.cc b/src/osd/ReplicatedBackend.cc
index 5a9668f..308e433 100644
--- a/src/osd/ReplicatedBackend.cc
+++ b/src/osd/ReplicatedBackend.cc
@@ -128,6 +128,7 @@ bool ReplicatedBackend::handle_message(
   OpRequestRef op
   )
 {
+  op->trace_pg("Handling message");
   dout(10) << __func__ << ": " << op << dendl;
   switch (op->get_req()->get_type()) {
   case MSG_OSD_PG_PUSH:
@@ -570,8 +571,10 @@ void ReplicatedBackend::op_applied(
   InProgressOp *op)
 {
   dout(10) << __func__ << ": " << op->tid << dendl;
-  if (op->op)
+  if (op->op) {
     op->op->mark_event("op_applied");
+    op->op->trace_pg("OP applied");
+  }
 
   op->waiting_for_applied.erase(get_parent()->whoami_shard());
   parent->op_applied(op->v);
@@ -590,8 +593,10 @@ void ReplicatedBackend::op_commit(
   InProgressOp *op)
 {
   dout(10) << __func__ << ": " << op->tid << dendl;
-  if (op->op)
+  if (op->op) {
     op->op->mark_event("op_commit");
+    op->op->trace_pg("OP committed");
+  }
 
   op->waiting_for_commit.erase(get_parent()->whoami_shard());
 
@@ -640,12 +645,18 @@ void ReplicatedBackend::sub_op_modify_reply(OpRequestRef op)
     if (r->ack_type & CEPH_OSD_FLAG_ONDISK) {
       assert(ip_op.waiting_for_commit.count(from));
       ip_op.waiting_for_commit.erase(from);
-      if (ip_op.op)
+      if (ip_op.op) {
 	ip_op.op->mark_event("sub_op_commit_rec");
+	ip_op.op->trace_pg("Sub op commit received");
+	op->get_req()->trace("Span ended");
+      }
     } else {
       assert(ip_op.waiting_for_applied.count(from));
-      if (ip_op.op)
+      if (ip_op.op) {
 	ip_op.op->mark_event("sub_op_applied_rec");
+	ip_op.op->trace_pg("Sub op applied received");
+	op->get_req()->trace("Span ended");
+      }
     }
     ip_op.waiting_for_applied.erase(from);
 
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 94eec05..ca1fba6 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1081,6 +1081,7 @@ void ReplicatedPG::do_request(
   OpRequestRef op,
   ThreadPool::TPHandle &handle)
 {
+  op->trace_pg("Starting request");
   if (!op_has_sufficient_caps(op)) {
     osd->reply_op_error(op, -EPERM);
     return;
@@ -1190,6 +1191,7 @@ bool ReplicatedPG::check_src_targ(const hobject_t& soid, const hobject_t& toid)
  */
 void ReplicatedPG::do_op(OpRequestRef op)
 {
+  op->trace_pg("Do op");
   MOSDOp *m = static_cast<MOSDOp*>(op->get_req());
   assert(m->get_header().type == CEPH_MSG_OSD_OP);
   if (op->includes_pg_op()) {
@@ -1200,6 +1202,7 @@ void ReplicatedPG::do_op(OpRequestRef op)
     return do_pg_op(op);
   }
 
+  op->trace_osd("Object", m->get_oid().name);
   if (get_osdmap()->is_blacklisted(m->get_source_addr())) {
     dout(10) << "do_op " << m->get_source_addr() << " is blacklisted" << dendl;
     osd->reply_op_error(op, -EBLACKLISTED);
@@ -1278,6 +1281,7 @@ void ReplicatedPG::do_op(OpRequestRef op)
 	if (m->wants_ack()) {
 	  if (already_ack(oldv)) {
 	    MOSDOpReply *reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, false);
+	    reply->init_trace_info(op->get_osd_trace());
 	    reply->add_flags(CEPH_OSD_FLAG_ACK);
 	    reply->set_reply_versions(oldv, entry->user_version);
 	    osd->send_message_osd_client(reply, m->get_connection());
@@ -1713,6 +1717,8 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)
   const hobject_t& soid = obc->obs.oi.soid;
   map<hobject_t,ObjectContextRef>& src_obc = ctx->src_obc;
 
+  op->trace_pg("Executing ctx");
+
   // this method must be idempotent since we may call it several times
   // before we finally apply the resulting transaction.
   delete ctx->op_t;
@@ -1804,6 +1810,7 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)
   // prepare the reply
   ctx->reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0,
 			       successful_write);
+  ctx->reply->init_trace_info(op->get_osd_trace());
 
   // Write operations aren't allowed to return a data payload because
   // we can't do so reliably. If the client has to resend the request
@@ -1945,6 +1952,8 @@ void ReplicatedPG::do_sub_op(OpRequestRef op)
   assert(m->get_header().type == MSG_OSD_SUBOP);
   dout(15) << "do_sub_op " << *op->get_req() << dendl;
 
+  op->trace_pg("Do sub op");
+
   OSDOp *first = NULL;
   if (m->ops.size() >= 1) {
     first = &m->ops[0];
@@ -2933,6 +2942,7 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
   ObjectState& obs = ctx->new_obs;
   object_info_t& oi = obs.oi;
   const hobject_t& soid = oi.soid;
+  ostringstream oss;
 
   bool first_read = true;
 
@@ -3009,6 +3019,13 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
       // fall through
     case CEPH_OSD_OP_READ:
       ++ctx->num_read;
+      ctx->op->trace_osd("Type", "Read");
+      oss << op.extent.offset;
+      ctx->op->trace_osd("Offset", oss.str());
+      oss.str("");
+      oss.clear();
+      oss << op.extent.length;
+      ctx->op->trace_osd("Length", oss.str());
       {
 	__u32 seq = oi.truncate_seq;
 	uint64_t size = oi.size;
@@ -6583,12 +6600,14 @@ void ReplicatedPG::eval_repop(RepGather *repop)
 	  repop->ctx->reply = NULL;
 	else {
 	  reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, true);
+	  reply->init_trace_info(repop->ctx->op->get_osd_trace());
 	  reply->set_reply_versions(repop->ctx->at_version,
 	                            repop->ctx->user_at_version);
 	}
 	reply->add_flags(CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK);
 	dout(10) << " sending commit on " << *repop << " " << reply << dendl;
 	osd->send_message_osd_client(reply, m->get_connection());
+    m->trace("Replied commit");
 	repop->sent_disk = true;
 	repop->ctx->op->mark_commit_sent();
       }
@@ -6605,6 +6624,7 @@ void ReplicatedPG::eval_repop(RepGather *repop)
 	     ++i) {
 	  MOSDOp *m = (MOSDOp*)(*i)->get_req();
 	  MOSDOpReply *reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, true);
+	  reply->init_trace_info(repop->ctx->op->get_osd_trace());
 	  reply->set_reply_versions(repop->ctx->at_version,
 	                            repop->ctx->user_at_version);
 	  reply->add_flags(CEPH_OSD_FLAG_ACK);
@@ -6628,6 +6648,7 @@ void ReplicatedPG::eval_repop(RepGather *repop)
         assert(entity_name_t::TYPE_OSD != m->get_connection()->peer_type);
 	osd->send_message_osd_client(reply, m->get_connection());
 	repop->sent_ack = true;
+	m->trace("Replied ack");
       }
 
       // note the write is now readable (for rlatency calc).  note
@@ -6660,6 +6681,8 @@ void ReplicatedPG::eval_repop(RepGather *repop)
       dout(0) << "   q front is " << *repop_queue.front() << dendl; 
       assert(repop_queue.front() == repop);
     }
+    repop->ctx->op->trace_pg("All done");
+    m->trace("Span ended");
     repop_queue.pop_front();
     remove_repop(repop);
   }
@@ -6668,6 +6691,7 @@ void ReplicatedPG::eval_repop(RepGather *repop)
 void ReplicatedPG::issue_repop(RepGather *repop, utime_t now)
 {
   OpContext *ctx = repop->ctx;
+  OpRequestRef op = ctx->op;
   const hobject_t& soid = ctx->obs->oi.soid;
   if (ctx->op &&
     ((static_cast<MOSDOp *>(
@@ -6679,6 +6703,8 @@ void ReplicatedPG::issue_repop(RepGather *repop, utime_t now)
           << " o " << soid
           << dendl;
 
+  op->trace_pg("Issuing repop");
+
   repop->v = ctx->at_version;
   if (ctx->at_version > eversion_t()) {
     for (set<pg_shard_t>::iterator i = actingbackfill.begin();
@@ -6750,6 +6776,7 @@ void ReplicatedBackend::issue_op(
   InProgressOp *op,
   ObjectStore::Transaction *op_t)
 {
+  op->op->trace_pg("Issuing replication");
   int acks_wanted = CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK;
 
   if (parent->get_actingbackfill_shards().size() > 1) {
@@ -6776,6 +6803,9 @@ void ReplicatedBackend::issue_op(
       false, acks_wanted,
       get_osdmap()->get_epoch(),
       tid, at_version);
+    if (op->op->get_req()) {
+        wr->init_trace_info(op->op->get_osd_trace());
+    }
 
     // ship resulting transaction, log entries, and pg_stats
     if (!parent->should_send_op(peer, soid)) {
@@ -7628,6 +7658,7 @@ void ReplicatedBackend::sub_op_modify(OpRequestRef op)
 void ReplicatedBackend::sub_op_modify_applied(RepModifyRef rm)
 {
   rm->op->mark_event("sub_op_applied");
+  rm->op->trace_pg("Sub op applied");
   rm->applied = true;
 
   dout(10) << "sub_op_modify_applied on " << rm << " op "
@@ -7641,6 +7672,9 @@ void ReplicatedBackend::sub_op_modify_applied(RepModifyRef rm)
       m, parent->whoami_shard(),
       0, get_osdmap()->get_epoch(), CEPH_OSD_FLAG_ACK);
     ack->set_priority(CEPH_MSG_PRIO_HIGH); // this better match commit priority!
+    ack->init_trace_info(rm->op->get_osd_trace());
+    rm->op->get_req()->trace("Replied apply");
+    rm->op->get_req()->trace("Span ended");
     get_parent()->send_message_osd_cluster(
       rm->ackerosd, ack, get_osdmap()->get_epoch());
   }
@@ -7666,6 +7700,9 @@ void ReplicatedBackend::sub_op_modify_commit(RepModifyRef rm)
     0, get_osdmap()->get_epoch(), CEPH_OSD_FLAG_ONDISK);
   commit->set_last_complete_ondisk(rm->last_complete);
   commit->set_priority(CEPH_MSG_PRIO_HIGH); // this better match ack priority!
+  commit->init_trace_info(rm->op->get_osd_trace());
+  rm->op->get_req()->trace("Replied commit");
+  rm->op->get_req()->trace("Span ended");
   get_parent()->send_message_osd_cluster(
     rm->ackerosd, commit, get_osdmap()->get_epoch());
   
@@ -8345,6 +8382,7 @@ struct C_OnPushCommit : public Context {
   OpRequestRef op;
   C_OnPushCommit(ReplicatedPG *pg, OpRequestRef op) : pg(pg), op(op) {}
   void finish(int) {
+    op->trace_pg("commited");
     op->mark_event("committed");
     log_subop_stats(pg->osd->logger, op, l_osd_push_inb, l_osd_sop_push_lat);
   }
diff --git a/src/osdc/Objecter.cc b/src/osdc/Objecter.cc
index 9da65b0..faef9a7 100644
--- a/src/osdc/Objecter.cc
+++ b/src/osdc/Objecter.cc
@@ -1650,6 +1650,9 @@ void Objecter::send_op(Op *op)
   m->ops = op->ops;
   m->set_mtime(op->mtime);
   m->set_retry_attempt(op->attempts++);
+  if (op->trace) {
+    m->init_trace_info(op->trace);
+  }
 
   if (op->replay_version != eversion_t())
     m->set_version(op->replay_version);  // we're replaying this op!
@@ -1724,6 +1727,7 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
     ldout(cct, 7) << "handle_osd_op_reply " << tid
 	    << (m->is_ondisk() ? " ondisk":(m->is_onnvram() ? " onnvram":" ack"))
 	    << " ... stray" << dendl;
+    m->trace("Span ended");
     m->put();
     return;
   }
@@ -1736,6 +1740,14 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
 		<< dendl;
   Op *op = ops[tid];
 
+  if (op->oncommit) {
+      m->trace("oncommit message");
+  }
+  if (op->onack) {
+      m->trace("onack message");
+  }
+  m->trace("Span ended");
+
   if (m->get_retry_attempt() >= 0) {
     if (m->get_retry_attempt() != (op->attempts - 1)) {
       ldout(cct, 7) << " ignoring reply from attempt " << m->get_retry_attempt()
@@ -1794,6 +1806,9 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
   assert(op->out_bl.size() == op->out_rval.size());
   assert(op->out_bl.size() == op->out_handler.size());
   vector<OSDOp>::iterator p = out_ops.begin();
+  if (op->trace) {
+      op->trace->event("in handle_osd_op_reply");
+  }
   for (unsigned i = 0;
        p != out_ops.end() && pb != op->out_bl.end();
        ++i, ++p, ++pb, ++pr, ++ph) {
diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
index 1e6fcf3..35d85ad 100644
--- a/src/osdc/Objecter.h
+++ b/src/osdc/Objecter.h
@@ -53,6 +53,7 @@ struct ObjectOperation {
   vector<OSDOp> ops;
   int flags;
   int priority;
+  TrackedOpTraceRef trace;
 
   vector<bufferlist*> out_bl;
   vector<Context*> out_handler;
@@ -70,6 +71,10 @@ struct ObjectOperation {
     return ops.size();
   }
 
+  void set_trace(TrackedOpTraceRef t) {
+    trace = t;
+  }
+
   void set_last_op_flags(int flags) {
     assert(!ops.empty());
     ops.rbegin()->op.flags = flags;
@@ -1021,6 +1026,7 @@ private:
   int global_op_flags; // flags which are applied to each IO op
   bool keep_balanced_budget;
   bool honor_osdmap_full;
+  ZTracer::ZTraceEndpointRef objecter_endp;
 
 public:
   void maybe_request_map();
@@ -1129,6 +1135,7 @@ public:
     epoch_t map_dne_bound;
 
     bool budgeted;
+    TrackedOpTraceRef trace;
 
     /// true if we should resend this message on failure
     bool should_resend;
@@ -1167,8 +1174,14 @@ public:
 	delete out_handler.back();
 	out_handler.pop_back();
       }
+      if (trace) {
+	trace->event("Span ended");
+      }
     }
 
+    void set_trace(TrackedOpTraceRef t) {
+      trace = t;
+    }
     bool operator<(const Op& other) const {
       return tid < other.tid;
     }
@@ -1555,7 +1568,9 @@ public:
     osd_timeout(osd_timeout),
     op_throttle_bytes(cct, "objecter_bytes", cct->_conf->objecter_inflight_op_bytes),
     op_throttle_ops(cct, "objecter_ops", cct->_conf->objecter_inflight_ops)
-  { }
+  {
+    objecter_endp = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "Objecter");
+  }
   ~Objecter() {
     assert(!tick_event);
     assert(!m_request_state_hook);
@@ -1701,6 +1716,7 @@ public:
 	     snapid_t snapid, bufferlist *pbl, int flags,
 	     Context *onack, version_t *objver = NULL) {
     Op *o = prepare_read_op(oid, oloc, op, snapid, pbl, flags, onack, objver);
+    o->set_trace(op.trace);
     return op_submit(o);
   }
   ceph_tid_t pg_read(uint32_t hash, object_locator_t oloc,
@@ -1865,6 +1881,28 @@ public:
     return read(oid, oloc, 0, 0, snap, pbl, flags | global_op_flags | CEPH_OSD_FLAG_READ, onfinish, objver);
   }
 
+  ceph_tid_t read_traced(const object_t& oid, const object_locator_t& oloc,
+	     uint64_t off, uint64_t len, snapid_t snap, bufferlist *pbl, int flags,
+	     Context *onfinish, struct blkin_trace_info *info,
+	     version_t *objver = NULL, ObjectOperation *extra_ops = NULL) {
+    vector<OSDOp> ops;
+    int i = init_ops(ops, 1, extra_ops);
+    ops[i].op.op = CEPH_OSD_OP_READ;
+    ops[i].op.extent.offset = off;
+    ops[i].op.extent.length = len;
+    ops[i].op.extent.truncate_size = 0;
+    ops[i].op.extent.truncate_seq = 0;
+    Op *o = new Op(oid, oloc, ops, flags | global_op_flags | CEPH_OSD_FLAG_READ, onfinish, 0, objver);
+    o->snapid = snap;
+    o->outbl = pbl;
+    ZTracer::ZTraceRef t = ZTracer::create_ZTrace("librados", objecter_endp);
+    t->set_trace_info(info);
+    t->event("Objecter read");
+    o->set_trace(t);
+    free(info);
+    return op_submit(o);
+  }
+
      
   // writes
   ceph_tid_t _modify(const object_t& oid, const object_locator_t& oloc,
@@ -2063,6 +2101,29 @@ public:
     o->snapc = snapc;
     return op_submit(o);
   }
+  ceph_tid_t write_traced(const object_t& oid, const object_locator_t& oloc,
+	      uint64_t off, uint64_t len, const SnapContext& snapc, const bufferlist &bl,
+	      utime_t mtime, int flags,
+	      Context *onack, Context *oncommit, struct blkin_trace_info *info,
+	      version_t *objver = NULL, ObjectOperation *extra_ops = NULL) {
+    vector<OSDOp> ops;
+    int i = init_ops(ops, 1, extra_ops);
+    ops[i].op.op = CEPH_OSD_OP_WRITE;
+    ops[i].op.extent.offset = off;
+    ops[i].op.extent.length = len;
+    ops[i].op.extent.truncate_size = 0;
+    ops[i].op.extent.truncate_seq = 0;
+    ops[i].indata = bl;
+    Op *o = new Op(oid, oloc, ops, flags | global_op_flags | CEPH_OSD_FLAG_WRITE, onack, oncommit, objver);
+    o->mtime = mtime;
+    o->snapc = snapc;
+    ZTracer::ZTraceRef t = ZTracer::create_ZTrace("librados", objecter_endp);
+    t->set_trace_info(info);
+    t->event("Objecter write");
+    o->set_trace(t);
+    free(info);
+    return op_submit(o);
+  }
 
   void list_objects(ListContext *p, Context *onfinish);
   uint32_t list_objects_seek(ListContext *p, uint32_t pos);
-- 
2.1.0

