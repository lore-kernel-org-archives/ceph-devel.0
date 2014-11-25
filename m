From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V2 4/6] OSD support for blkin (LTTng + Zipkin) tracing
Date: Tue, 25 Nov 2014 10:54:26 -0800
Message-ID: <1416941668-26150-5-git-send-email-agshew@gmail.com>
References: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47835 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbaKYSyd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 13:54:33 -0500
Received: by mail-pd0-f182.google.com with SMTP id r10so1117561pdi.13
        for <ceph-devel@vger.kernel.org>; Tue, 25 Nov 2014 10:54:32 -0800 (PST)
In-Reply-To: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Andrew Shewmaker <agshew@gmail.com>, Marios-Evaggelos Kogias <marioskogias@gmail.com>, Filippos Giannakos <philipgian@grnet.gr>

 * Adds tracing for OSDs and Placement Groups, specifically:
   messages for OSD operations, FileJournal, FileStore,
   ECBackend, replication, and traced versions of Objecter
   read/write (only basic read/write functions).
 * Moves global_init_daemonize() earlier in ceph_osd.c:main

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 src/ceph_osd.cc               |  6 +++--
 src/messages/MOSDOp.h         | 13 +++++++++
 src/messages/MOSDOpReply.h    | 13 +++++++++
 src/messages/MOSDSubOp.h      | 12 +++++++++
 src/messages/MOSDSubOpReply.h | 12 +++++++++
 src/os/FileJournal.cc         | 14 +++++++---
 src/os/FileJournal.h          |  6 ++++-
 src/os/FileStore.cc           | 20 ++++++++++++++
 src/os/FileStore.h            |  1 +
 src/osd/ECBackend.cc          |  8 ++++--
 src/osd/OSD.cc                | 18 +++++++++++++
 src/osd/OSD.h                 |  1 +
 src/osd/OpRequest.h           |  2 ++
 src/osd/PG.cc                 |  2 ++
 src/osd/PG.h                  |  1 +
 src/osd/ReplicatedBackend.cc  | 19 ++++++++++---
 src/osd/ReplicatedPG.cc       | 35 ++++++++++++++++++++++++
 src/osdc/Objecter.cc          |  7 +++++
 src/osdc/Objecter.h           | 62 ++++++++++++++++++++++++++++++++++++++++++-
 19 files changed, 239 insertions(+), 13 deletions(-)

diff --git a/src/ceph_osd.cc b/src/ceph_osd.cc
index 029ef28..efd5b2e 100644
--- a/src/ceph_osd.cc
+++ b/src/ceph_osd.cc
@@ -148,6 +148,9 @@ int main(int argc, const char **argv)
     return 0;
   }
 
+  global_init_daemonize(g_ceph_context, 0);
+  BLKIN_ZTRACE_INIT();
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
index ed0a669..d3a9274 100644
--- a/src/messages/MOSDOp.h
+++ b/src/messages/MOSDOp.h
@@ -32,7 +32,11 @@ class OSD;
 
 class MOSDOp : public Message {
 
+#ifdef WITH_BLKIN
+  static const int HEAD_VERSION = 5;
+#else
   static const int HEAD_VERSION = 4;
+#endif
   static const int COMPAT_VERSION = 3;
 
 private:
@@ -176,6 +180,7 @@ public:
 
   // marshalling
   virtual void encode_payload(uint64_t features) {
+    BLKIN_GET_MASTER(mt);
 
     OSDOp::merge_osd_op_vector_in_data(ops, data);
 
@@ -251,11 +256,14 @@ struct ceph_osd_request_head {
       ::encode(snaps, payload);
 
       ::encode(retry_attempt, payload);
+
+      BLKIN_MSG_ENCODE_TRACE();
     }
   }
 
   virtual void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    BLKIN_MSG_DO_INIT_TRACE();
 
     if (header.version < 2) {
       // old decode
@@ -332,6 +340,8 @@ struct ceph_osd_request_head {
 	::decode(retry_attempt, p);
       else
 	retry_attempt = -1;
+
+      BLKIN_MSG_DECODE_TRACE(5);
     }
 
     OSDOp::split_osd_op_vector_in_data(ops, data);
@@ -374,6 +384,9 @@ struct ceph_osd_request_head {
     out << " e" << osdmap_epoch;
     out << ")";
   }
+
+  BLKIN_MSG_INFO_DECL(MOSDOp)
+  BLKIN_MSG_END_DECL(MOSDOp)
 };
 
 
diff --git a/src/messages/MOSDOpReply.h b/src/messages/MOSDOpReply.h
index 91c50e7..647993d 100644
--- a/src/messages/MOSDOpReply.h
+++ b/src/messages/MOSDOpReply.h
@@ -32,7 +32,11 @@
 
 class MOSDOpReply : public Message {
 
+#ifdef WITH_BLKIN
+  static const int HEAD_VERSION = 7;
+#else
   static const int HEAD_VERSION = 6;
+#endif
   static const int COMPAT_VERSION = 2;
 
   object_t oid;
@@ -144,6 +148,7 @@ public:
       if (ignore_out_data)
 	ops[i].outdata.clear();
     }
+    BLKIN_MSG_CHECK_SPAN();
   }
 private:
   ~MOSDOpReply() {}
@@ -151,6 +156,8 @@ private:
 public:
   virtual void encode_payload(uint64_t features) {
 
+    BLKIN_GET_MASTER(mt);
+
     OSDOp::merge_osd_op_vector_out_data(ops, data);
 
     if ((features & CEPH_FEATURE_PGID64) == 0) {
@@ -190,10 +197,13 @@ public:
       ::encode(replay_version, payload);
       ::encode(user_version, payload);
       ::encode(redirect, payload);
+
+      BLKIN_MSG_ENCODE_TRACE();
     }
   }
   virtual void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    BLKIN_MSG_DO_INIT_TRACE();
     if (header.version < 2) {
       ceph_osd_reply_head head;
       ::decode(head, p);
@@ -245,6 +255,8 @@ public:
 
       if (header.version >= 6)
 	::decode(redirect, p);
+
+      BLKIN_MSG_DECODE_TRACE(7);
     }
   }
 
@@ -271,6 +283,7 @@ public:
     out << ")";
   }
 
+  BLKIN_MSG_END_DECL(MOSDOpReply)
 };
 
 
diff --git a/src/messages/MOSDSubOp.h b/src/messages/MOSDSubOp.h
index 6a38186..d308075 100644
--- a/src/messages/MOSDSubOp.h
+++ b/src/messages/MOSDSubOp.h
@@ -25,7 +25,11 @@
 
 class MOSDSubOp : public Message {
 
+#ifdef WITH_BLKIN
+  static const int HEAD_VERSION = 11;
+#else
   static const int HEAD_VERSION = 10;
+#endif
   static const int COMPAT_VERSION = 1;
 
 public:
@@ -102,6 +106,7 @@ public:
   virtual void decode_payload() {
     hobject_incorrect_pool = false;
     bufferlist::iterator p = payload.begin();
+    BLKIN_MSG_DO_INIT_TRACE();
     ::decode(map_epoch, p);
     ::decode(reqid, p);
     ::decode(pgid.pgid, p);
@@ -175,6 +180,8 @@ public:
     if (header.version >= 10) {
       ::decode(updated_hit_set_history, p);
     }
+
+    BLKIN_MSG_DECODE_TRACE(11);
   }
 
   virtual void encode_payload(uint64_t features) {
@@ -182,6 +189,7 @@ public:
     ::encode(reqid, payload);
     ::encode(pgid.pgid, payload);
     ::encode(poid, payload);
+    BLKIN_GET_MASTER(mt);
 
     __u32 num_ops = ops.size();
     ::encode(num_ops, payload);
@@ -224,6 +232,8 @@ public:
     ::encode(from, payload);
     ::encode(pgid.shard, payload);
     ::encode(updated_hit_set_history, payload);
+
+    BLKIN_MSG_ENCODE_TRACE();
   }
 
   MOSDSubOp()
@@ -269,6 +279,8 @@ public:
       out << ", has_updated_hit_set_history";
     out << ")";
   }
+
+  BLKIN_MSG_END_DECL(MOSDSubOp)
 };
 
 
diff --git a/src/messages/MOSDSubOpReply.h b/src/messages/MOSDSubOpReply.h
index 270629f..a0d4e2c 100644
--- a/src/messages/MOSDSubOpReply.h
+++ b/src/messages/MOSDSubOpReply.h
@@ -30,7 +30,11 @@
  */
 
 class MOSDSubOpReply : public Message {
+#ifdef WITH_BLKIN
+  static const int HEAD_VERSION = 3;
+#else
   static const int HEAD_VERSION = 2;
+#endif
   static const int COMPAT_VERSION = 1;
 public:
   epoch_t map_epoch;
@@ -55,6 +59,7 @@ public:
 
   virtual void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    BLKIN_MSG_DO_INIT_TRACE();
     ::decode(map_epoch, p);
     ::decode(reqid, p);
     ::decode(pgid.pgid, p);
@@ -84,8 +89,11 @@ public:
 	ghobject_t::NO_SHARD);
       pgid.shard = ghobject_t::NO_SHARD;
     }
+    BLKIN_MSG_DECODE_TRACE(3);
   }
   virtual void encode_payload(uint64_t features) {
+    BLKIN_GET_MASTER(mt);
+
     ::encode(map_epoch, payload);
     ::encode(reqid, payload);
     ::encode(pgid.pgid, payload);
@@ -102,6 +110,8 @@ public:
     ::encode(attrset, payload);
     ::encode(from, payload);
     ::encode(pgid.shard, payload);
+
+    BLKIN_MSG_ENCODE_TRACE();
   }
 
   epoch_t get_map_epoch() { return map_epoch; }
@@ -138,6 +148,7 @@ public:
     result(result_) {
     memset(&peer_stat, 0, sizeof(peer_stat));
     set_tid(req->get_tid());
+    BLKIN_MSG_CHECK_SPAN();
   }
   MOSDSubOpReply() : Message(MSG_OSD_SUBOPREPLY) {}
 private:
@@ -160,6 +171,7 @@ public:
     out << ")";
   }
 
+  BLKIN_MSG_END_DECL(MOSDSubOpReply)
 };
 
 
diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index c6bd616..5377272 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -837,8 +837,11 @@ void FileJournal::queue_completions_thru(uint64_t seq)
     }
     if (next.finish)
       finisher->queue(next.finish);
-    if (next.tracked_op)
+    if (next.tracked_op) {
       next.tracked_op->mark_event("journaled_completion_queued");
+      BLKIN_OP_TRACE_EVENT(next.tracked_op, journal, journaled_completion_queued);
+      BLKIN_OP_TRACE_EVENT(next.tracked_op, journal, span_ended);
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
+    BLKIN_OP_TRACE_EVENT(next_write.tracked_op, journal, write_thread_in_journal_buffer);
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
+    BLKIN_OP_CREATE_TRACE(osd_op, journal, journal_endpoint);
+    BLKIN_OP_TRACE_EVENT(osd_op, journal, commit_queued_for_journal_write);
+  }
   if (logger) {
     logger->set(l_os_jq_max_ops, throttle_ops.get_max());
     logger->set(l_os_jq_max_bytes, throttle_bytes.get_max());
diff --git a/src/os/FileJournal.h b/src/os/FileJournal.h
index dbb1181..8420a8d 100644
--- a/src/os/FileJournal.h
+++ b/src/os/FileJournal.h
@@ -215,6 +215,7 @@ public:
   } __attribute__((__packed__, aligned(4)));
 
 private:
+  BLKIN_END_REF(journal_endpoint)
   string fn;
 
   char *zero_buf;
@@ -380,7 +381,10 @@ private:
     write_lock("FileJournal::write_lock", false, true, false, g_ceph_context),
     write_stop(false),
     write_thread(this),
-    write_finish_thread(this) { }
+    write_finish_thread(this)
+  {
+    BLKIN_MSG_END(journal, "", 0, "Journal (" + fn + ")");
+  }
   ~FileJournal() {
     delete[] zero_buf;
   }
diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index 9d6252c..11b63df 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -467,6 +467,7 @@ FileStore::FileStore(const std::string &base, const std::string &jdev, const cha
   m_filestore_max_inline_xattrs(0)
 {
   m_filestore_kill_at.set(g_conf->filestore_kill_at);
+  BLKIN_MSG_END(filestore, "", 0, "Filestore (" + basedir + "(" + name + ")" + ")");
 
   ostringstream oss;
   oss << basedir << "/current";
@@ -1613,6 +1614,9 @@ void FileStore::queue_op(OpSequencer *osr, Op *o)
   // so that regardless of which order the threads pick up the
   // sequencer, the op order will be preserved.
 
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, osd, queueing_for_filestore);
+  }
   osr->queue(o);
 
   logger->inc(l_os_ops);
@@ -1624,6 +1628,9 @@ void FileStore::queue_op(OpSequencer *osr, Op *o)
 	  << "   (queue has " << op_queue_len << " ops and " << op_queue_bytes << " bytes)"
 	  << dendl;
   op_wq.queue(osr);
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, osd, queued_for_filestore);
+  }
 }
 
 void FileStore::op_queue_reserve_throttle(Op *o, ThreadPool::TPHandle *handle)
@@ -1694,8 +1701,17 @@ void FileStore::_do_op(OpSequencer *osr, ThreadPool::TPHandle &handle)
   osr->apply_lock.Lock();
   Op *o = osr->peek_queue();
   apply_manager.op_apply_start(o->op);
+
+  if (o->osd_op) {
+    BLKIN_OP_CREATE_TRACE(o->osd_op, filestore, filestore_endpoint);
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, filestore_dequeued);
+  }
   dout(5) << "_do_op " << o << " seq " << o->op << " " << *osr << "/" << osr->parent << " start" << dendl;
   int r = _do_transactions(o->tls, o->op, &handle);
+
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, filestore_finished);
+  }
   apply_manager.op_apply_finish(o->op);
   dout(10) << "_do_op " << o << " seq " << o->op << " r = " << r
 	   << ", finisher " << o->onreadable << " " << o->onreadable_sync << dendl;
@@ -1704,6 +1720,10 @@ void FileStore::_do_op(OpSequencer *osr, ThreadPool::TPHandle &handle)
 void FileStore::_finish_op(OpSequencer *osr)
 {
   Op *o = osr->dequeue();
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, filestore_finishing_op);
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, span_ended);
+  }
   
   dout(10) << "_finish_op " << o << " seq " << o->op << " " << *osr << "/" << osr->parent << dendl;
   osr->apply_lock.Unlock();  // locked in _do_op
diff --git a/src/os/FileStore.h b/src/os/FileStore.h
index 4c9ffdb..1db2edf 100644
--- a/src/os/FileStore.h
+++ b/src/os/FileStore.h
@@ -124,6 +124,7 @@ public:
   }
 
 private:
+  BLKIN_END_REF(filestore_endpoint)
   string internal_name;         ///< internal name, used to name the perfcounter instance
   string basedir, journalpath;
   std::string current_fn;
diff --git a/src/osd/ECBackend.cc b/src/osd/ECBackend.cc
index 3c27288..7c0bb79 100644
--- a/src/osd/ECBackend.cc
+++ b/src/osd/ECBackend.cc
@@ -724,8 +724,10 @@ struct SubWriteCommitted : public Context {
     : pg(pg), msg(msg), tid(tid),
       version(version), last_complete(last_complete) {}
   void finish(int) {
-    if (msg)
+    if (msg) {
       msg->mark_event("sub_op_committed");
+      BLKIN_OP_TRACE_EVENT(msg, pg, sub_op_committed);
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
       msg->mark_event("sub_op_applied");
+      BLKIN_OP_TRACE_EVENT(msg, pg, sub_op_applied);
+    }
     pg->sub_write_applied(tid, version);
   }
 };
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 4240ba8..5b93d80 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -21,6 +21,9 @@
 #include <signal.h>
 #include <ctype.h>
 #include <boost/scoped_ptr.hpp>
+#ifdef WITH_BLKIN
+#include <boost/lexical_cast.hpp>
+#endif
 
 #ifdef HAVE_SYS_PARAM_H
 #include <sys/param.h>
@@ -963,6 +966,8 @@ OSD::OSD(CephContext *cct_, ObjectStore *store_,
                                          cct->_conf->osd_op_log_threshold);
   op_tracker.set_history_size_and_duration(cct->_conf->osd_op_history_size,
                                            cct->_conf->osd_op_history_duration);
+
+  BLKIN_MSG_END(osd, "", 0, "osd." + boost::lexical_cast<string>(whoami));
 }
 
 OSD::~OSD()
@@ -5024,6 +5029,8 @@ void OSD::_dispatch(Message *m)
     {
       OpRequestRef op = op_tracker.create_request<OpRequest>(m);
       op->mark_event("waiting_for_osdmap");
+      BLKIN_OP_CREATE_TRACE(op, osd, osd_endpoint);
+      BLKIN_OP_TRACE_EVENT(op, osd, waiting_for_osdmap);
       // no map?  starting up?
       if (!osdmap) {
         dout(7) << "no OSDMap, not booted" << dendl;
@@ -7386,6 +7393,8 @@ void OSD::handle_op(OpRequestRef op)
     return;
   }
 
+  BLKIN_OP_TRACE_EVENT(op, osd, handling_op);
+
   // we don't need encoded payload anymore
   m->clear_payload();
 
@@ -7513,7 +7522,10 @@ void OSD::handle_op(OpRequestRef op)
     return;
   }
 
+  BLKIN_OP_CREATE_TRACE(op, pg, pg->pg_endpoint);
+  BLKIN_OP_TRACE_EVENT(op, pg, enqueuing_op);
   enqueue_op(pg, op);
+  BLKIN_OP_TRACE_EVENT(op, pg, enqueued_op);
 }
 
 template<typename T, int MSGTYPE>
@@ -7522,6 +7534,8 @@ void OSD::handle_replica_op(OpRequestRef op)
   T *m = static_cast<T *>(op->get_req());
   assert(m->get_header().type == MSGTYPE);
 
+  BLKIN_OP_TRACE_EVENT(op, osd, handling_replica_op);
+
   dout(10) << __func__ << " " << *m << " epoch " << m->map_epoch << dendl;
   if (m->map_epoch < up_epoch) {
     dout(3) << "replica op from before up" << dendl;
@@ -7553,7 +7567,9 @@ void OSD::handle_replica_op(OpRequestRef op)
   if (!pg) {
     return;
   }
+  BLKIN_OP_CREATE_TRACE(op, pg, pg->pg_endpoint);
   enqueue_op(pg, op);
+  BLKIN_OP_TRACE_EVENT(op, osd, enqueued_replica_op);
 }
 
 bool OSD::op_is_discardable(MOSDOp *op)
@@ -7655,7 +7671,9 @@ void OSD::OpWQ::_process(PGRef pg, ThreadPool::TPHandle &handle)
   delete f;
   *_dout << dendl;
 
+  BLKIN_OP_TRACE_EVENT(op, pg, dequeuing_op);
   osd->dequeue_op(pg, op, handle);
+  BLKIN_OP_TRACE_EVENT(op, pg, dequeued_op);
   pg->unlock();
 }
 
diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index ce8b74c..f2874e1 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -791,6 +791,7 @@ protected:
   AuthAuthorizeHandlerRegistry *authorize_handler_cluster_registry;
   AuthAuthorizeHandlerRegistry *authorize_handler_service_registry;
 
+  BLKIN_END_REF(osd_endpoint)
   Messenger   *cluster_messenger;
   Messenger   *client_messenger;
   Messenger   *objecter_messenger;
diff --git a/src/osd/OpRequest.h b/src/osd/OpRequest.h
index 569b6fc..c26d5d4 100644
--- a/src/osd/OpRequest.h
+++ b/src/osd/OpRequest.h
@@ -140,12 +140,14 @@ public:
     latest_flag_point = flag_started;
   }
   void mark_sub_op_sent(string s) {
+    BLKIN_TYPE_TRACE_EVENT(pg, "sub_op_sent | " + s);
     mark_event(s);
     current = s;
     hit_flag_points |= flag_sub_op_sent;
     latest_flag_point = flag_sub_op_sent;
   }
   void mark_commit_sent() {
+    BLKIN_TYPE_TRACE_EVENT(pg, "commit_sent");
     mark_event("commit_sent");
     current = "commit sent";
     hit_flag_points |= flag_commit_sent;
diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index 6deb099..263283c 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -199,6 +199,8 @@ PG::PG(OSDService *o, OSDMapRef curmap,
 #ifdef PG_DEBUG_REFS
   osd->add_pgid(p, this);
 #endif
+  BLKIN_OSS(oss, "PG " << info.pgid);
+  BLKIN_MSG_END(pg, "", 0, oss.str());
 }
 
 PG::~PG()
diff --git a/src/osd/PG.h b/src/osd/PG.h
index 1fce297..f6132a5 100644
--- a/src/osd/PG.h
+++ b/src/osd/PG.h
@@ -199,6 +199,7 @@ public:
   void update_snap_mapper_bits(uint32_t bits) {
     snap_mapper.update_bits(bits);
   }
+  BLKIN_END_REF(pg_endpoint)
 protected:
   // Ops waiting for map, should be queued at back
   Mutex map_lock;
diff --git a/src/osd/ReplicatedBackend.cc b/src/osd/ReplicatedBackend.cc
index 5a9668f..2b5be9a 100644
--- a/src/osd/ReplicatedBackend.cc
+++ b/src/osd/ReplicatedBackend.cc
@@ -128,6 +128,7 @@ bool ReplicatedBackend::handle_message(
   OpRequestRef op
   )
 {
+  BLKIN_OP_TRACE_EVENT(op, pg, handling_message);
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
+    BLKIN_OP_TRACE_EVENT(op->op, pg, op_applied);
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
+    BLKIN_OP_TRACE_EVENT(op->op, pg, op_commit);
+  }
 
   op->waiting_for_commit.erase(get_parent()->whoami_shard());
 
@@ -640,12 +645,18 @@ void ReplicatedBackend::sub_op_modify_reply(OpRequestRef op)
     if (r->ack_type & CEPH_OSD_FLAG_ONDISK) {
       assert(ip_op.waiting_for_commit.count(from));
       ip_op.waiting_for_commit.erase(from);
-      if (ip_op.op)
+      if (ip_op.op) {
 	ip_op.op->mark_event("sub_op_commit_rec");
+	BLKIN_OP_TRACE_EVENT(ip_op.op, pg, sub_op_commit_rec);
+	BLKIN_MSG_TRACE_EVENT(op->get_req(), span_ended);
+      }
     } else {
       assert(ip_op.waiting_for_applied.count(from));
-      if (ip_op.op)
+      if (ip_op.op) {
 	ip_op.op->mark_event("sub_op_applied_rec");
+	BLKIN_OP_TRACE_EVENT(ip_op.op, pg, sub_op_applied_rec);
+	BLKIN_MSG_TRACE_EVENT(op->get_req(), span_ended);
+      }
     }
     ip_op.waiting_for_applied.erase(from);
 
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 94eec05..6988c6d 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1081,6 +1081,7 @@ void ReplicatedPG::do_request(
   OpRequestRef op,
   ThreadPool::TPHandle &handle)
 {
+  BLKIN_OP_TRACE_EVENT(op, pg, starting_request);
   if (!op_has_sufficient_caps(op)) {
     osd->reply_op_error(op, -EPERM);
     return;
@@ -1190,6 +1191,7 @@ bool ReplicatedPG::check_src_targ(const hobject_t& soid, const hobject_t& toid)
  */
 void ReplicatedPG::do_op(OpRequestRef op)
 {
+  BLKIN_OP_TRACE_EVENT(op, pg, do_op);
   MOSDOp *m = static_cast<MOSDOp*>(op->get_req());
   assert(m->get_header().type == CEPH_MSG_OSD_OP);
   if (op->includes_pg_op()) {
@@ -1200,6 +1202,7 @@ void ReplicatedPG::do_op(OpRequestRef op)
     return do_pg_op(op);
   }
 
+  BLKIN_OP_TRACE_KEYVAL(op, osd, "object", m->get_oid().name);
   if (get_osdmap()->is_blacklisted(m->get_source_addr())) {
     dout(10) << "do_op " << m->get_source_addr() << " is blacklisted" << dendl;
     osd->reply_op_error(op, -EBLACKLISTED);
@@ -1278,6 +1281,7 @@ void ReplicatedPG::do_op(OpRequestRef op)
 	if (m->wants_ack()) {
 	  if (already_ack(oldv)) {
 	    MOSDOpReply *reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, false);
+	    BLKIN_MSG_INIT_TRACE(reply, op->get_osd_trace());
 	    reply->add_flags(CEPH_OSD_FLAG_ACK);
 	    reply->set_reply_versions(oldv, entry->user_version);
 	    osd->send_message_osd_client(reply, m->get_connection());
@@ -1713,6 +1717,8 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)
   const hobject_t& soid = obc->obs.oi.soid;
   map<hobject_t,ObjectContextRef>& src_obc = ctx->src_obc;
 
+  BLKIN_OP_TRACE_EVENT(op, pg, executing_ctx);
+
   // this method must be idempotent since we may call it several times
   // before we finally apply the resulting transaction.
   delete ctx->op_t;
@@ -1804,6 +1810,7 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)
   // prepare the reply
   ctx->reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0,
 			       successful_write);
+  BLKIN_MSG_INIT_TRACE(ctx->reply, op->get_osd_trace());
 
   // Write operations aren't allowed to return a data payload because
   // we can't do so reliably. If the client has to resend the request
@@ -1945,6 +1952,8 @@ void ReplicatedPG::do_sub_op(OpRequestRef op)
   assert(m->get_header().type == MSG_OSD_SUBOP);
   dout(15) << "do_sub_op " << *op->get_req() << dendl;
 
+  BLKIN_OP_TRACE_EVENT(op, pg, do_sub_op);
+
   OSDOp *first = NULL;
   if (m->ops.size() >= 1) {
     first = &m->ops[0];
@@ -3010,6 +3019,13 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
     case CEPH_OSD_OP_READ:
       ++ctx->num_read;
       {
+        BLKIN_OP_TRACE_KEYVAL(ctx->op, osd, "type", "read");
+        BLKIN_OSS(oss1, op.extent.offset);
+        BLKIN_OP_TRACE_KEYVAL(ctx->op, osd, "offset", oss1.str());
+        BLKIN_OSS(oss2, op.extent.length);
+        BLKIN_OP_TRACE_KEYVAL(ctx->op, osd, "length", oss2.str());
+      }
+      {
 	__u32 seq = oi.truncate_seq;
 	uint64_t size = oi.size;
 	bool trimmed_read = false;
@@ -6583,12 +6599,14 @@ void ReplicatedPG::eval_repop(RepGather *repop)
 	  repop->ctx->reply = NULL;
 	else {
 	  reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, true);
+	  BLKIN_MSG_INIT_TRACE(reply, repop->ctx->op->get_osd_trace());
 	  reply->set_reply_versions(repop->ctx->at_version,
 	                            repop->ctx->user_at_version);
 	}
 	reply->add_flags(CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK);
 	dout(10) << " sending commit on " << *repop << " " << reply << dendl;
 	osd->send_message_osd_client(reply, m->get_connection());
+	BLKIN_MSG_TRACE_EVENT(m, replied_commit);
 	repop->sent_disk = true;
 	repop->ctx->op->mark_commit_sent();
       }
@@ -6605,6 +6623,7 @@ void ReplicatedPG::eval_repop(RepGather *repop)
 	     ++i) {
 	  MOSDOp *m = (MOSDOp*)(*i)->get_req();
 	  MOSDOpReply *reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, true);
+	  BLKIN_MSG_INIT_TRACE(reply, repop->ctx->op->get_osd_trace());
 	  reply->set_reply_versions(repop->ctx->at_version,
 	                            repop->ctx->user_at_version);
 	  reply->add_flags(CEPH_OSD_FLAG_ACK);
@@ -6628,6 +6647,7 @@ void ReplicatedPG::eval_repop(RepGather *repop)
         assert(entity_name_t::TYPE_OSD != m->get_connection()->peer_type);
 	osd->send_message_osd_client(reply, m->get_connection());
 	repop->sent_ack = true;
+	BLKIN_MSG_TRACE_EVENT(m, replied_ack);
       }
 
       // note the write is now readable (for rlatency calc).  note
@@ -6660,6 +6680,8 @@ void ReplicatedPG::eval_repop(RepGather *repop)
       dout(0) << "   q front is " << *repop_queue.front() << dendl; 
       assert(repop_queue.front() == repop);
     }
+    BLKIN_OP_TRACE_EVENT(repop->ctx->op, pg, all_done);
+    BLKIN_MSG_TRACE_EVENT(m, span_ended);
     repop_queue.pop_front();
     remove_repop(repop);
   }
@@ -6679,6 +6701,8 @@ void ReplicatedPG::issue_repop(RepGather *repop, utime_t now)
           << " o " << soid
           << dendl;
 
+  BLKIN_OP_TRACE_EVENT(ctx->op, pg, issuing_repop);
+
   repop->v = ctx->at_version;
   if (ctx->at_version > eversion_t()) {
     for (set<pg_shard_t>::iterator i = actingbackfill.begin();
@@ -6750,6 +6774,7 @@ void ReplicatedBackend::issue_op(
   InProgressOp *op,
   ObjectStore::Transaction *op_t)
 {
+  BLKIN_OP_TRACE_EVENT(op->op, pg, issuing_replication);
   int acks_wanted = CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK;
 
   if (parent->get_actingbackfill_shards().size() > 1) {
@@ -6777,6 +6802,8 @@ void ReplicatedBackend::issue_op(
       get_osdmap()->get_epoch(),
       tid, at_version);
 
+    BLKIN_MSG_INIT_TRACE_IF(op->op->get_req(), wr, op->op->get_osd_trace());
+
     // ship resulting transaction, log entries, and pg_stats
     if (!parent->should_send_op(peer, soid)) {
       dout(10) << "issue_repop shipping empty opt to osd." << peer
@@ -7628,6 +7655,7 @@ void ReplicatedBackend::sub_op_modify(OpRequestRef op)
 void ReplicatedBackend::sub_op_modify_applied(RepModifyRef rm)
 {
   rm->op->mark_event("sub_op_applied");
+  BLKIN_OP_TRACE_EVENT(rm->op, pg, sub_op_applied);
   rm->applied = true;
 
   dout(10) << "sub_op_modify_applied on " << rm << " op "
@@ -7641,6 +7669,9 @@ void ReplicatedBackend::sub_op_modify_applied(RepModifyRef rm)
       m, parent->whoami_shard(),
       0, get_osdmap()->get_epoch(), CEPH_OSD_FLAG_ACK);
     ack->set_priority(CEPH_MSG_PRIO_HIGH); // this better match commit priority!
+    BLKIN_MSG_INIT_TRACE(ack, rm->op->get_osd_trace());
+    BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), replied_apply);
+    BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), span_ended);
     get_parent()->send_message_osd_cluster(
       rm->ackerosd, ack, get_osdmap()->get_epoch());
   }
@@ -7666,6 +7697,9 @@ void ReplicatedBackend::sub_op_modify_commit(RepModifyRef rm)
     0, get_osdmap()->get_epoch(), CEPH_OSD_FLAG_ONDISK);
   commit->set_last_complete_ondisk(rm->last_complete);
   commit->set_priority(CEPH_MSG_PRIO_HIGH); // this better match ack priority!
+  BLKIN_MSG_INIT_TRACE(commit, rm->op->get_osd_trace());
+  BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), replied_commit);
+  BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), span_ended);
   get_parent()->send_message_osd_cluster(
     rm->ackerosd, commit, get_osdmap()->get_epoch());
   
@@ -8345,6 +8379,7 @@ struct C_OnPushCommit : public Context {
   OpRequestRef op;
   C_OnPushCommit(ReplicatedPG *pg, OpRequestRef op) : pg(pg), op(op) {}
   void finish(int) {
+    BLKIN_OP_TRACE_EVENT(op, pg, committed);
     op->mark_event("committed");
     log_subop_stats(pg->osd->logger, op, l_osd_push_inb, l_osd_sop_push_lat);
   }
diff --git a/src/osdc/Objecter.cc b/src/osdc/Objecter.cc
index 9da65b0..f421f5b 100644
--- a/src/osdc/Objecter.cc
+++ b/src/osdc/Objecter.cc
@@ -1650,6 +1650,7 @@ void Objecter::send_op(Op *op)
   m->ops = op->ops;
   m->set_mtime(op->mtime);
   m->set_retry_attempt(op->attempts++);
+  BLKIN_MSG_INIT_TRACE_IF(op->trace, m, op->trace);
 
   if (op->replay_version != eversion_t())
     m->set_version(op->replay_version);  // we're replaying this op!
@@ -1724,6 +1725,7 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
     ldout(cct, 7) << "handle_osd_op_reply " << tid
 	    << (m->is_ondisk() ? " ondisk":(m->is_onnvram() ? " onnvram":" ack"))
 	    << " ... stray" << dendl;
+    BLKIN_MSG_TRACE_EVENT(m, span_ended);
     m->put();
     return;
   }
@@ -1736,6 +1738,10 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
 		<< dendl;
   Op *op = ops[tid];
 
+  BLKIN_MSG_TRACE_EVENT_IF(op->oncommit, m, oncommit_message);
+  BLKIN_MSG_TRACE_EVENT_IF(op->onack, m, onack_message);
+  BLKIN_MSG_TRACE_EVENT(m, span_ended);
+
   if (m->get_retry_attempt() >= 0) {
     if (m->get_retry_attempt() != (op->attempts - 1)) {
       ldout(cct, 7) << " ignoring reply from attempt " << m->get_retry_attempt()
@@ -1794,6 +1800,7 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
   assert(op->out_bl.size() == op->out_rval.size());
   assert(op->out_bl.size() == op->out_handler.size());
   vector<OSDOp>::iterator p = out_ops.begin();
+  BLKIN_OP_EVENT_IF(op->trace, op->trace, in_handle_osd_op_reply);
   for (unsigned i = 0;
        p != out_ops.end() && pb != op->out_bl.end();
        ++i, ++p, ++pb, ++pr, ++ph) {
diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
index 1e6fcf3..98a8dcb 100644
--- a/src/osdc/Objecter.h
+++ b/src/osdc/Objecter.h
@@ -53,6 +53,7 @@ struct ObjectOperation {
   vector<OSDOp> ops;
   int flags;
   int priority;
+  BLKIN_TRACE_REF(trace);
 
   vector<bufferlist*> out_bl;
   vector<Context*> out_handler;
@@ -70,6 +71,8 @@ struct ObjectOperation {
     return ops.size();
   }
 
+  BLKIN_OP_SET_TRACE_DECL()
+
   void set_last_op_flags(int flags) {
     assert(!ops.empty());
     ops.rbegin()->op.flags = flags;
@@ -1021,6 +1024,7 @@ private:
   int global_op_flags; // flags which are applied to each IO op
   bool keep_balanced_budget;
   bool honor_osdmap_full;
+  BLKIN_END_REF(objecter_endpoint)
 
 public:
   void maybe_request_map();
@@ -1129,6 +1133,7 @@ public:
     epoch_t map_dne_bound;
 
     bool budgeted;
+    BLKIN_TRACE_REF(trace);
 
     /// true if we should resend this message on failure
     bool should_resend;
@@ -1167,8 +1172,11 @@ public:
 	delete out_handler.back();
 	out_handler.pop_back();
       }
+      BLKIN_OP_EVENT_IF(trace, trace, span_ended);
     }
 
+    BLKIN_OP_SET_TRACE_DECL()
+
     bool operator<(const Op& other) const {
       return tid < other.tid;
     }
@@ -1555,7 +1563,9 @@ public:
     osd_timeout(osd_timeout),
     op_throttle_bytes(cct, "objecter_bytes", cct->_conf->objecter_inflight_op_bytes),
     op_throttle_ops(cct, "objecter_ops", cct->_conf->objecter_inflight_ops)
-  { }
+  {
+    BLKIN_MSG_END(objecter, "0.0.0.0", 0, objecter);
+  }
   ~Objecter() {
     assert(!tick_event);
     assert(!m_request_state_hook);
@@ -1701,6 +1711,7 @@ public:
 	     snapid_t snapid, bufferlist *pbl, int flags,
 	     Context *onack, version_t *objver = NULL) {
     Op *o = prepare_read_op(oid, oloc, op, snapid, pbl, flags, onack, objver);
+    BLKIN_OP_SET_TRACE(o, op.trace);
     return op_submit(o);
   }
   ceph_tid_t pg_read(uint32_t hash, object_locator_t oloc,
@@ -1865,6 +1876,29 @@ public:
     return read(oid, oloc, 0, 0, snap, pbl, flags | global_op_flags | CEPH_OSD_FLAG_READ, onfinish, objver);
   }
 
+#ifdef WITH_BLKIN
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
+    ZTracer::ZTraceRef t = ZTracer::create_ZTrace("librados", objecter_endpoint);
+    t->set_trace_info(info);
+    t->event("Objecter read");
+    o->set_trace(t);
+    free(info);
+    return op_submit(o);
+  }
+#endif // WITH_BLKIN
      
   // writes
   ceph_tid_t _modify(const object_t& oid, const object_locator_t& oloc,
@@ -2064,6 +2098,32 @@ public:
     return op_submit(o);
   }
 
+#ifdef WITH_BLKIN
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
+    ZTracer::ZTraceRef t = ZTracer::create_ZTrace("librados", objecter_endpoint);
+    t->set_trace_info(info);
+    t->event("Objecter write");
+    o->set_trace(t);
+    free(info);
+    return op_submit(o);
+  }
+#endif // WITH_BLKIN
+
   void list_objects(ListContext *p, Context *onfinish);
   uint32_t list_objects_seek(ListContext *p, uint32_t pos);
 
-- 
2.1.0

