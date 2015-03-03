From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V5 4/6] OSD support for blkin (LTTng + Zipkin) tracing
Date: Mon,  2 Mar 2015 16:35:13 -0800
Message-ID: <1425342915-12553-5-git-send-email-agshew@gmail.com>
References: <1425342915-12553-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:37217 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbbCCAfO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 19:35:14 -0500
Received: by paceu11 with SMTP id eu11so4896936pac.4
        for <ceph-devel@vger.kernel.org>; Mon, 02 Mar 2015 16:35:13 -0800 (PST)
In-Reply-To: <1425342915-12553-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

 * Adds tracing for OSDs and Placement Groups, specifically:
   messages for OSD operations, FileJournal, FileStore,
   ECBackend, replication, and traced versions of Objecter
   read/write (only basic read/write functions).
 * Moves global_init_daemonize() earlier in ceph_osd.c:main

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
Signed-off-by: Chendi.Xue <chendi.xue@intel.com>
---
 src/ceph_osd.cc               |  6 ++--
 src/messages/MOSDOp.h         | 14 +++++++-
 src/messages/MOSDOpReply.h    | 13 ++++++++
 src/messages/MOSDSubOp.h      | 11 +++++++
 src/messages/MOSDSubOpReply.h | 12 +++++++
 src/os/FileJournal.cc         | 14 ++++++--
 src/os/FileJournal.h          |  6 +++-
 src/os/FileStore.cc           | 20 ++++++++++++
 src/os/FileStore.h            |  1 +
 src/osd/ECBackend.cc          |  8 +++--
 src/osd/OSD.cc                | 21 ++++++++++++
 src/osd/OSD.h                 |  1 +
 src/osd/OpRequest.cc          | 74 +++++++++++++++++++++++++++++++++++++++++++
 src/osd/OpRequest.h           |  9 ++++++
 src/osd/PG.cc                 |  2 ++
 src/osd/PG.h                  |  1 +
 src/osd/ReplicatedBackend.cc  | 19 ++++++++---
 src/osd/ReplicatedPG.cc       | 35 ++++++++++++++++++++
 src/osdc/Objecter.cc          |  7 ++++
 src/osdc/Objecter.h           | 63 +++++++++++++++++++++++++++++++++++-
 20 files changed, 323 insertions(+), 14 deletions(-)

diff --git a/src/ceph_osd.cc b/src/ceph_osd.cc
index 884b7ed..2774b5f 100644
--- a/src/ceph_osd.cc
+++ b/src/ceph_osd.cc
@@ -172,6 +172,9 @@ int main(int argc, const char **argv)
     return 0;
   }
 
+  global_init_daemonize(g_ceph_context, 0);
+  BLKIN_ZTRACE_INIT();
+
   // whoami
   char *end;
   const char *id = g_conf->name.get_id().c_str();
@@ -480,8 +483,7 @@ int main(int argc, const char **argv)
   if (r < 0)
     exit(1);
 
-  // Set up crypto, daemonize, etc.
-  global_init_daemonize(g_ceph_context, 0);
+  // Set up crypto, etc.
   common_init_finish(g_ceph_context);
 
   MonClient mc(g_ceph_context);
diff --git a/src/messages/MOSDOp.h b/src/messages/MOSDOp.h
index 5b88f31..6a7dac8 100644
--- a/src/messages/MOSDOp.h
+++ b/src/messages/MOSDOp.h
@@ -32,7 +32,11 @@ class OSD;
 
 class MOSDOp : public Message {
 
+#ifdef WITH_BLKIN
+  static const int HEAD_VERSION = 6;
+#else
   static const int HEAD_VERSION = 5;
+#endif
   static const int COMPAT_VERSION = 3;
 
 private:
@@ -185,6 +189,7 @@ public:
 
   // marshalling
   virtual void encode_payload(uint64_t features) {
+    BLKIN_GET_MASTER(mt);
 
     OSDOp::merge_osd_op_vector_in_data(ops, data);
 
@@ -260,12 +265,14 @@ struct ceph_osd_request_head {
       ::encode(snaps, payload);
 
       ::encode(retry_attempt, payload);
-      ::encode(features, payload);
+
+      BLKIN_MSG_ENCODE_TRACE();
     }
   }
 
   virtual void decode_payload() {
     bufferlist::iterator p = payload.begin();
+    BLKIN_MSG_DO_INIT_TRACE();
 
     if (header.version < 2) {
       // old decode
@@ -348,6 +355,8 @@ struct ceph_osd_request_head {
 	::decode(features, p);
       else
 	features = 0;
+
+      BLKIN_MSG_DECODE_TRACE(6);
     }
 
     OSDOp::split_osd_op_vector_in_data(ops, data);
@@ -390,6 +399,9 @@ struct ceph_osd_request_head {
     out << " e" << osdmap_epoch;
     out << ")";
   }
+
+  BLKIN_MSG_INFO_DECL("MOSDOp")
+  BLKIN_MSG_END_DECL("MOSDOp")
 };
 
 
diff --git a/src/messages/MOSDOpReply.h b/src/messages/MOSDOpReply.h
index b2d5155..64f01c1 100644
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
@@ -143,6 +147,7 @@ public:
       if (ignore_out_data)
 	ops[i].outdata.clear();
     }
+    BLKIN_MSG_CHECK_SPAN();
   }
 private:
   ~MOSDOpReply() {}
@@ -150,6 +155,8 @@ private:
 public:
   virtual void encode_payload(uint64_t features) {
 
+    BLKIN_GET_MASTER(mt);
+
     OSDOp::merge_osd_op_vector_out_data(ops, data);
 
     if ((features & CEPH_FEATURE_PGID64) == 0) {
@@ -189,10 +196,13 @@ public:
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
@@ -244,6 +254,8 @@ public:
 
       if (header.version >= 6)
 	::decode(redirect, p);
+
+      BLKIN_MSG_DECODE_TRACE(7);
     }
   }
 
@@ -270,6 +282,7 @@ public:
     out << ")";
   }
 
+  BLKIN_MSG_END_DECL("MOSDOpReply")
 };
 
 
diff --git a/src/messages/MOSDSubOp.h b/src/messages/MOSDSubOp.h
index 544dfcf..96f48a9 100644
--- a/src/messages/MOSDSubOp.h
+++ b/src/messages/MOSDSubOp.h
@@ -25,8 +25,13 @@
 
 class MOSDSubOp : public Message {
 
+#ifdef WITH_BLKIN
+  static const int HEAD_VERSION = 12;
+#else
   static const int HEAD_VERSION = 11;
   static const int COMPAT_VERSION = 7;
+#endif
+  static const int COMPAT_VERSION = 1;
 
 public:
   epoch_t map_epoch;
@@ -103,6 +108,7 @@ public:
     //version >=7
     assert (header.version >= 7);
     bufferlist::iterator p = payload.begin();
+    BLKIN_MSG_DO_INIT_TRACE();
     ::decode(map_epoch, p);
     ::decode(reqid, p);
     ::decode(pgid.pgid, p);
@@ -170,6 +176,7 @@ public:
     } else {
       pg_trim_rollback_to = pg_trim_to;
     }
+    BLKIN_MSG_DECODE_TRACE(12);
   }
 
   virtual void encode_payload(uint64_t features) {
@@ -177,6 +184,7 @@ public:
     ::encode(reqid, payload);
     ::encode(pgid.pgid, payload);
     ::encode(poid, payload);
+    BLKIN_GET_MASTER(mt);
 
     __u32 num_ops = ops.size();
     ::encode(num_ops, payload);
@@ -221,6 +229,7 @@ public:
     ::encode(pgid.shard, payload);
     ::encode(updated_hit_set_history, payload);
     ::encode(pg_trim_rollback_to, payload);
+    BLKIN_MSG_ENCODE_TRACE();
   }
 
   MOSDSubOp()
@@ -262,6 +271,8 @@ public:
       out << ", has_updated_hit_set_history";
     out << ")";
   }
+
+  BLKIN_MSG_END_DECL("MOSDSubOp")
 };
 
 
diff --git a/src/messages/MOSDSubOpReply.h b/src/messages/MOSDSubOpReply.h
index a084246..dfff58e 100644
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
 	shard_id_t::NO_SHARD);
       pgid.shard = shard_id_t::NO_SHARD;
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
 
+  BLKIN_MSG_END_DECL("MOSDSubOpReply")
 };
 
 
diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index c6bb6f2..8e024d0 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -874,8 +874,11 @@ void FileJournal::queue_completions_thru(uint64_t seq)
     }
     if (next.finish)
       finisher->queue(next.finish);
-    if (next.tracked_op)
+    if (next.tracked_op) {
       next.tracked_op->mark_event("journaled_completion_queued");
+      BLKIN_OP_TRACE_EVENT(next.tracked_op, journal, "journaled_completion_queued");
+      BLKIN_OP_TRACE_EVENT(next.tracked_op, journal, "span_ended");
+    }
   }
   finisher_cond.Signal();
 }
@@ -934,8 +937,10 @@ int FileJournal::prepare_single_write(bufferlist& bl, off64_t& queue_pos, uint64
   }
   bl.append((const char*)&h, sizeof(h));
 
-  if (next_write.tracked_op)
+  if (next_write.tracked_op) {
     next_write.tracked_op->mark_event("write_thread_in_journal_buffer");
+    BLKIN_OP_TRACE_EVENT(next_write.tracked_op, journal, "write_thread_in_journal_buffer");
+  }
 
   // pop from writeq
   pop_write();
@@ -1498,8 +1503,11 @@ void FileJournal::submit_entry(uint64_t seq, bufferlist& e, int alignment,
 
   throttle_ops.take(1);
   throttle_bytes.take(e.length());
-  if (osd_op)
+  if (osd_op) {
     osd_op->mark_event("commit_queued_for_journal_write");
+    BLKIN_OP_CREATE_TRACE(osd_op, journal, journal_endpoint);
+    BLKIN_OP_TRACE_EVENT(osd_op, journal, "commit_queued_for_journal_write");
+  }
   if (logger) {
     logger->set(l_os_jq_max_ops, throttle_ops.get_max());
     logger->set(l_os_jq_max_bytes, throttle_bytes.get_max());
diff --git a/src/os/FileJournal.h b/src/os/FileJournal.h
index 574c902..dfeab81 100644
--- a/src/os/FileJournal.h
+++ b/src/os/FileJournal.h
@@ -215,6 +215,7 @@ public:
   } __attribute__((__packed__, aligned(4)));
 
 private:
+  BLKIN_END_REF(journal_endpoint)
   string fn;
 
   char *zero_buf;
@@ -385,7 +386,10 @@ private:
     write_stop(false),
     aio_stop(false),
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
index f6c3bb8..a3a6859 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -563,6 +563,7 @@ FileStore::FileStore(const std::string &base, const std::string &jdev, osflagbit
   m_filestore_max_inline_xattrs(0)
 {
   m_filestore_kill_at.set(g_conf->filestore_kill_at);
+  BLKIN_MSG_END(filestore, "", 0, "Filestore (" + basedir + "(" + name + ")" + ")");
 
   ostringstream oss;
   oss << basedir << "/current";
@@ -1717,6 +1718,9 @@ void FileStore::queue_op(OpSequencer *osr, Op *o)
   // so that regardless of which order the threads pick up the
   // sequencer, the op order will be preserved.
 
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, osd, "queueing_for_filestore");
+  }
   osr->queue(o);
 
   logger->inc(l_os_ops);
@@ -1728,6 +1732,9 @@ void FileStore::queue_op(OpSequencer *osr, Op *o)
 	  << "   (queue has " << op_queue_len << " ops and " << op_queue_bytes << " bytes)"
 	  << dendl;
   op_wq.queue(osr);
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, osd, "queued_for_filestore");
+  }
 }
 
 void FileStore::op_queue_reserve_throttle(Op *o, ThreadPool::TPHandle *handle)
@@ -1798,8 +1805,17 @@ void FileStore::_do_op(OpSequencer *osr, ThreadPool::TPHandle &handle)
   osr->apply_lock.Lock();
   Op *o = osr->peek_queue();
   apply_manager.op_apply_start(o->op);
+
+  if (o->osd_op) {
+    BLKIN_OP_CREATE_TRACE(o->osd_op, filestore, filestore_endpoint);
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, "filestore_dequeued");
+  }
   dout(5) << "_do_op " << o << " seq " << o->op << " " << *osr << "/" << osr->parent << " start" << dendl;
   int r = _do_transactions(o->tls, o->op, &handle);
+
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, "filestore_finished");
+  }
   apply_manager.op_apply_finish(o->op);
   dout(10) << "_do_op " << o << " seq " << o->op << " r = " << r
 	   << ", finisher " << o->onreadable << " " << o->onreadable_sync << dendl;
@@ -1809,6 +1825,10 @@ void FileStore::_finish_op(OpSequencer *osr)
 {
   list<Context*> to_queue;
   Op *o = osr->dequeue(&to_queue);
+  if (o->osd_op) {
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, "filestore_finishing_op");
+    BLKIN_OP_TRACE_EVENT(o->osd_op, filestore, "span_ended");
+  }
   
   dout(10) << "_finish_op " << o << " seq " << o->op << " " << *osr << "/" << osr->parent << dendl;
   osr->apply_lock.Unlock();  // locked in _do_op
diff --git a/src/os/FileStore.h b/src/os/FileStore.h
index af1fb8d..6605a97 100644
--- a/src/os/FileStore.h
+++ b/src/os/FileStore.h
@@ -118,6 +118,7 @@ public:
   }
 
 private:
+  BLKIN_END_REF(filestore_endpoint)
   string internal_name;         ///< internal name, used to name the perfcounter instance
   string basedir, journalpath;
   osflagbits_t generic_flags;
diff --git a/src/osd/ECBackend.cc b/src/osd/ECBackend.cc
index 951b249..8fc4459 100644
--- a/src/osd/ECBackend.cc
+++ b/src/osd/ECBackend.cc
@@ -727,8 +727,10 @@ struct SubWriteCommitted : public Context {
     : pg(pg), msg(msg), tid(tid),
       version(version), last_complete(last_complete) {}
   void finish(int) {
-    if (msg)
+    if (msg) {
       msg->mark_event("sub_op_committed");
+      BLKIN_OP_TRACE_EVENT(msg, pg, "sub_op_committed");
+    }
     pg->sub_write_committed(tid, version, last_complete);
   }
 };
@@ -769,8 +771,10 @@ struct SubWriteApplied : public Context {
     eversion_t version)
     : pg(pg), msg(msg), tid(tid), version(version) {}
   void finish(int) {
-    if (msg)
+    if (msg) {
       msg->mark_event("sub_op_applied");
+      BLKIN_OP_TRACE_EVENT(msg, pg, "sub_op_applied");
+    }
     pg->sub_write_applied(tid, version);
   }
 };
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 9ce5a44..572cc82 100644
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
@@ -1572,6 +1575,8 @@ OSD::OSD(CephContext *cct_, ObjectStore *store_,
                                          cct->_conf->osd_op_log_threshold);
   op_tracker.set_history_size_and_duration(cct->_conf->osd_op_history_size,
                                            cct->_conf->osd_op_history_duration);
+
+  BLKIN_MSG_END(osd, "", 0, "osd." + boost::lexical_cast<string>(whoami));
 }
 
 OSD::~OSD()
@@ -5414,6 +5419,9 @@ void OSD::ms_fast_dispatch(Message *m)
 #endif
     tracepoint(osd, ms_fast_dispatch, reqid.name._type,
         reqid.name._num, reqid.tid, reqid.inc);
+
+    BLKIN_OP_CREATE_TRACE(op, osd, osd_endpoint);
+    BLKIN_OP_TRACE_EVENT(op, osd, "waiting_on_osdmap");
   }
   OSDMapRef nextmap = service.get_nextmap_reserved();
   Session *session = static_cast<Session*>(m->get_connection()->get_priv());
@@ -5761,6 +5769,8 @@ void OSD::_dispatch(Message *m)
     {
       OpRequestRef op = op_tracker.create_request<OpRequest, Message*>(m);
       op->mark_event("waiting_for_osdmap");
+      BLKIN_OP_CREATE_TRACE(op, osd, osd_endpoint);
+      BLKIN_OP_TRACE_EVENT(op, osd, "waiting_for_osdmap");
       // no map?  starting up?
       if (!osdmap) {
         dout(7) << "no OSDMap, not booted" << dendl;
@@ -7999,6 +8009,8 @@ void OSD::handle_op(OpRequestRef& op, OSDMapRef& osdmap)
     return;
   }
 
+  BLKIN_OP_TRACE_EVENT(op, osd, "handling_op");
+
   // we don't need encoded payload anymore
   m->clear_payload();
 
@@ -8136,7 +8148,10 @@ void OSD::handle_op(OpRequestRef& op, OSDMapRef& osdmap)
   if (pg) {
     op->send_map_update = share_map.should_send;
     op->sent_epoch = m->get_map_epoch();
+    BLKIN_OP_CREATE_TRACE(op, pg, pg->pg_endpoint);
+    BLKIN_OP_TRACE_EVENT(op, pg, "enqueuing_op");
     enqueue_op(pg, op);
+    BLKIN_OP_TRACE_EVENT(op, pg, "enqueued_op");
     share_map.should_send = false;
   }
 }
@@ -8147,6 +8162,8 @@ void OSD::handle_replica_op(OpRequestRef& op, OSDMapRef& osdmap)
   T *m = static_cast<T *>(op->get_req());
   assert(m->get_type() == MSGTYPE);
 
+  BLKIN_OP_TRACE_EVENT(op, osd, "handling_replica_op");
+
   dout(10) << __func__ << " " << *m << " epoch " << m->map_epoch << dendl;
   if (!require_self_aliveness(op->get_req(), m->map_epoch))
     return;
@@ -8179,7 +8196,9 @@ void OSD::handle_replica_op(OpRequestRef& op, OSDMapRef& osdmap)
   if (pg) {
     op->send_map_update = should_share_map;
     op->sent_epoch = m->map_epoch;
+    BLKIN_OP_CREATE_TRACE(op, pg, pg->pg_endpoint);
     enqueue_op(pg, op);
+    BLKIN_OP_TRACE_EVENT(op, osd, "enqueued_replica_op");
   } else if (should_share_map && m->get_connection()->is_connected()) {
     C_SendMap *send_map = new C_SendMap(this, m->get_source(),
 					m->get_connection(),
@@ -8270,7 +8289,9 @@ void OSD::ShardedOpWQ::_process(uint32_t thread_index, heartbeat_handle_d *hb )
   delete f;
   *_dout << dendl;
 
+  BLKIN_OP_TRACE_EVENT(op, pg, "dequeuing_op");
   osd->dequeue_op(item.first, op, tp_handle);
+  BLKIN_OP_TRACE_EVENT(op, pg, "dequeued_op");
 
   {
 #ifdef WITH_LTTNG
diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index b043d28..1e814cd 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -919,6 +919,7 @@ protected:
   AuthAuthorizeHandlerRegistry *authorize_handler_cluster_registry;
   AuthAuthorizeHandlerRegistry *authorize_handler_service_registry;
 
+  BLKIN_END_REF(osd_endpoint)
   Messenger   *cluster_messenger;
   Messenger   *client_messenger;
   Messenger   *objecter_messenger;
diff --git a/src/osd/OpRequest.cc b/src/osd/OpRequest.cc
index 1296334..fb8f981 100644
--- a/src/osd/OpRequest.cc
+++ b/src/osd/OpRequest.cc
@@ -131,3 +131,77 @@ void OpRequest::mark_flag_point(uint8_t flag, const string& s) {
 	     reqid.name._num, reqid.tid, reqid.inc, rmw_flags,
 	     flag, s.c_str(), old_flags, hit_flag_points);
 }
+
+#ifdef WITH_BLKIN
+bool OpRequest::create_osd_trace(TrackedOpEndpointRef ep)
+{
+  string name = "OSD Handling op";
+  if (!request) {
+    return false;
+  }
+
+  TrackedOpTraceRef mt = request->get_master_trace();
+  if (!mt) {
+    return false;
+  }
+
+  osd_trace = ZTracer::create_ZTrace(name, mt, ep);
+  if(!osd_trace){
+    return false;
+  }
+
+  return true;
+}
+
+bool OpRequest::create_pg_trace(TrackedOpEndpointRef ep)
+{
+  string name = "PG";
+  if (!request) {
+    return false;
+  }
+
+  TrackedOpTraceRef mt = request->get_master_trace();
+  if (!mt) {
+    return false;
+  }
+
+  pg_trace = ZTracer::create_ZTrace(name, mt, ep);
+  if(!pg_trace){
+    return false;
+  }
+
+  return true;
+}
+
+bool OpRequest::create_journal_trace(TrackedOpEndpointRef ep)
+{
+  string name = "Journal access";
+
+  if (!osd_trace) {
+    return false;
+  }
+
+  journal_trace = ZTracer::create_ZTrace(name, osd_trace, ep);
+  if(!journal_trace){
+    return false;
+  }
+
+  return true;
+}
+
+bool OpRequest::create_filestore_trace(TrackedOpEndpointRef ep)
+{
+  string name = "Filestore access";
+
+  if (!osd_trace) {
+    return false;
+  }
+
+  filestore_trace = ZTracer::create_ZTrace(name, osd_trace, ep);
+  if(!filestore_trace){
+    return false;
+  }
+
+  return true;
+}
+#endif // WITH_BLKIN
diff --git a/src/osd/OpRequest.h b/src/osd/OpRequest.h
index 88a2704..65b5bbc 100644
--- a/src/osd/OpRequest.h
+++ b/src/osd/OpRequest.h
@@ -76,6 +76,13 @@ struct OpRequest : public TrackedOp {
 
   void _dump(utime_t now, Formatter *f) const;
 
+#ifdef WITH_BLKIN
+  bool create_osd_trace(TrackedOpEndpointRef ep);
+  bool create_pg_trace(TrackedOpEndpointRef ep);
+  bool create_journal_trace(TrackedOpEndpointRef ep);
+  bool create_filestore_trace(TrackedOpEndpointRef ep);
+#endif // WITH_BLKIN
+
   bool has_feature(uint64_t f) const {
     return request->get_connection()->has_feature(f);
   }
@@ -146,9 +153,11 @@ public:
   }
   void mark_sub_op_sent(const string& s) {
     mark_flag_point(flag_sub_op_sent, s);
+    BLKIN_TYPE_TRACE_EVENT(pg, "sub_op_sent | " + s);
   }
   void mark_commit_sent() {
     mark_flag_point(flag_commit_sent, "commit_sent");
+    BLKIN_TYPE_TRACE_EVENT(pg, "commit_sent");
   }
 
   utime_t get_dequeued_time() const {
diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index 7447ecc..2a2292b 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -220,6 +220,8 @@ PG::PG(OSDService *o, OSDMapRef curmap,
 #ifdef PG_DEBUG_REFS
   osd->add_pgid(p, this);
 #endif
+  BLKIN_OSS(oss, "PG " << info.pgid);
+  BLKIN_MSG_END(pg, "", 0, oss.str());
 }
 
 PG::~PG()
diff --git a/src/osd/PG.h b/src/osd/PG.h
index 870fdf2..2ab78f2 100644
--- a/src/osd/PG.h
+++ b/src/osd/PG.h
@@ -197,6 +197,7 @@ public:
   void update_snap_mapper_bits(uint32_t bits) {
     snap_mapper.update_bits(bits);
   }
+  BLKIN_END_REF(pg_endpoint)
 protected:
   // Ops waiting for map, should be queued at back
   Mutex map_lock;
diff --git a/src/osd/ReplicatedBackend.cc b/src/osd/ReplicatedBackend.cc
index 680c27a..afbd4c9 100644
--- a/src/osd/ReplicatedBackend.cc
+++ b/src/osd/ReplicatedBackend.cc
@@ -130,6 +130,7 @@ bool ReplicatedBackend::handle_message(
   OpRequestRef op
   )
 {
+  BLKIN_OP_TRACE_EVENT(op, pg, "handling_message");
   dout(10) << __func__ << ": " << op << dendl;
   switch (op->get_req()->get_type()) {
   case MSG_OSD_PG_PUSH:
@@ -608,8 +609,10 @@ void ReplicatedBackend::op_applied(
   InProgressOp *op)
 {
   dout(10) << __func__ << ": " << op->tid << dendl;
-  if (op->op)
+  if (op->op) {
     op->op->mark_event("op_applied");
+    BLKIN_OP_TRACE_EVENT(op->op, pg, "op_applied");
+  }
 
   op->waiting_for_applied.erase(get_parent()->whoami_shard());
   parent->op_applied(op->v);
@@ -628,8 +631,10 @@ void ReplicatedBackend::op_commit(
   InProgressOp *op)
 {
   dout(10) << __func__ << ": " << op->tid << dendl;
-  if (op->op)
+  if (op->op) {
     op->op->mark_event("op_commit");
+    BLKIN_OP_TRACE_EVENT(op->op, pg, "op_commit");
+  }
 
   op->waiting_for_commit.erase(get_parent()->whoami_shard());
 
@@ -680,12 +685,18 @@ void ReplicatedBackend::sub_op_modify_reply(OpRequestRef op)
     if (r->ack_type & CEPH_OSD_FLAG_ONDISK) {
       assert(ip_op.waiting_for_commit.count(from));
       ip_op.waiting_for_commit.erase(from);
-      if (ip_op.op)
+      if (ip_op.op) {
 	ip_op.op->mark_event("sub_op_commit_rec");
+	BLKIN_OP_TRACE_EVENT(ip_op.op, pg, "sub_op_commit_rec");
+	BLKIN_MSG_TRACE_EVENT(op->get_req(), "span_ended");
+      }
     } else {
       assert(ip_op.waiting_for_applied.count(from));
-      if (ip_op.op)
+      if (ip_op.op) {
 	ip_op.op->mark_event("sub_op_applied_rec");
+	BLKIN_OP_TRACE_EVENT(ip_op.op, pg, "sub_op_applied_rec");
+	BLKIN_MSG_TRACE_EVENT(op->get_req(), "span_ended");
+      }
     }
     ip_op.waiting_for_applied.erase(from);
 
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index aebcbf7..e2b6a39 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1301,6 +1301,7 @@ void ReplicatedPG::do_request(
   OpRequestRef& op,
   ThreadPool::TPHandle &handle)
 {
+  BLKIN_OP_TRACE_EVENT(op, pg, "starting_request");
   if (!op_has_sufficient_caps(op)) {
     osd->reply_op_error(op, -EPERM);
     return;
@@ -1422,6 +1423,7 @@ bool ReplicatedPG::check_src_targ(const hobject_t& soid, const hobject_t& toid)
  */
 void ReplicatedPG::do_op(OpRequestRef& op)
 {
+  BLKIN_OP_TRACE_EVENT(op, pg, "do_op");
   MOSDOp *m = static_cast<MOSDOp*>(op->get_req());
   assert(m->get_type() == CEPH_MSG_OSD_OP);
   if (op->includes_pg_op()) {
@@ -1432,6 +1434,7 @@ void ReplicatedPG::do_op(OpRequestRef& op)
     return do_pg_op(op);
   }
 
+  BLKIN_OP_TRACE_KEYVAL(op, osd, "object", m->get_oid().name);
   if (get_osdmap()->is_blacklisted(m->get_source_addr())) {
     dout(10) << "do_op " << m->get_source_addr() << " is blacklisted" << dendl;
     osd->reply_op_error(op, -EBLACKLISTED);
@@ -1535,6 +1538,7 @@ void ReplicatedPG::do_op(OpRequestRef& op)
 	if (m->wants_ack()) {
 	  if (already_ack(replay_version)) {
 	    MOSDOpReply *reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, false);
+	    BLKIN_MSG_INIT_TRACE(reply, op->get_osd_trace());
 	    reply->add_flags(CEPH_OSD_FLAG_ACK);
 	    reply->set_reply_versions(replay_version, user_version);
 	    osd->send_message_osd_client(reply, m->get_connection());
@@ -2253,6 +2257,8 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)
   const hobject_t& soid = obc->obs.oi.soid;
   map<hobject_t,ObjectContextRef>& src_obc = ctx->src_obc;
 
+  BLKIN_OP_TRACE_EVENT(op, pg, "executing_ctx");
+
   // this method must be idempotent since we may call it several times
   // before we finally apply the resulting transaction.
   delete ctx->op_t;
@@ -2358,6 +2364,7 @@ void ReplicatedPG::execute_ctx(OpContext *ctx)
   // prepare the reply
   ctx->reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0,
 			       successful_write);
+  BLKIN_MSG_INIT_TRACE(ctx->reply, op->get_osd_trace());
 
   // Write operations aren't allowed to return a data payload because
   // we can't do so reliably. If the client has to resend the request
@@ -2507,6 +2514,8 @@ void ReplicatedPG::do_sub_op(OpRequestRef op)
   assert(m->get_type() == MSG_OSD_SUBOP);
   dout(15) << "do_sub_op " << *op->get_req() << dendl;
 
+  BLKIN_OP_TRACE_EVENT(op, pg, "do_sub_op");
+
   OSDOp *first = NULL;
   if (m->ops.size() >= 1) {
     first = &m->ops[0];
@@ -3596,6 +3605,13 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
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
 	tracepoint(osd, do_osd_op_pre_read, soid.oid.name.c_str(), soid.snap.val, size, seq, op.extent.offset, op.extent.length, op.extent.truncate_size, op.extent.truncate_seq);
@@ -7506,12 +7522,14 @@ void ReplicatedPG::eval_repop(RepGather *repop)
 	repop->ctx->reply = NULL;
       else {
 	reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, true);
+	BLKIN_MSG_INIT_TRACE(reply, repop->ctx->op->get_osd_trace());
 	reply->set_reply_versions(repop->ctx->at_version,
 				  repop->ctx->user_at_version);
       }
       reply->add_flags(CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK);
       dout(10) << " sending commit on " << *repop << " " << reply << dendl;
       osd->send_message_osd_client(reply, m->get_connection());
+      BLKIN_MSG_TRACE_EVENT(m, "replied_commit");
       repop->sent_disk = true;
       repop->ctx->op->mark_commit_sent();
     }
@@ -7529,10 +7547,12 @@ void ReplicatedPG::eval_repop(RepGather *repop)
 	   ++i) {
 	MOSDOp *m = (MOSDOp*)i->first->get_req();
 	MOSDOpReply *reply = new MOSDOpReply(m, 0, get_osdmap()->get_epoch(), 0, true);
+	BLKIN_MSG_INIT_TRACE(reply, repop->ctx->op->get_osd_trace());
 	reply->set_reply_versions(repop->ctx->at_version,
 				  i->second);
 	reply->add_flags(CEPH_OSD_FLAG_ACK);
 	osd->send_message_osd_client(reply, m->get_connection());
+	BLKIN_MSG_TRACE_EVENT(m, "replied_ack");
       }
       waiting_for_ack.erase(repop->v);
     }
@@ -7586,6 +7606,8 @@ void ReplicatedPG::eval_repop(RepGather *repop)
       dout(0) << "   q front is " << *repop_queue.front() << dendl; 
       assert(repop_queue.front() == repop);
     }
+    BLKIN_OP_TRACE_EVENT(repop->ctx->op, pg, "all_done");
+    BLKIN_MSG_TRACE_EVENT(m, "span_ended");
     repop_queue.pop_front();
     remove_repop(repop);
   }
@@ -7605,6 +7627,8 @@ void ReplicatedPG::issue_repop(RepGather *repop, utime_t now)
           << " o " << soid
           << dendl;
 
+  BLKIN_OP_TRACE_EVENT(ctx->op, pg, "issuing_repop");
+
   repop->v = ctx->at_version;
   if (ctx->at_version > eversion_t()) {
     for (set<pg_shard_t>::iterator i = actingbackfill.begin();
@@ -7769,6 +7793,7 @@ void ReplicatedBackend::issue_op(
   InProgressOp *op,
   ObjectStore::Transaction *op_t)
 {
+  BLKIN_OP_TRACE_EVENT(op->op, pg, "issuing_replication");
 
   if (parent->get_actingbackfill_shards().size() > 1) {
     ostringstream ss;
@@ -7805,6 +7830,8 @@ void ReplicatedBackend::issue_op(
 	    op_t,
 	    peer,
 	    pinfo);
+
+      BLKIN_MSG_INIT_TRACE_IF(op->op->get_req(), wr, op->op->get_osd_trace());
     } else {
       wr = generate_subop<MOSDRepOp, MSG_OSD_REPOP>(
 	    soid,
@@ -8634,6 +8661,7 @@ void ReplicatedBackend::sub_op_modify_impl(OpRequestRef op)
 void ReplicatedBackend::sub_op_modify_applied(RepModifyRef rm)
 {
   rm->op->mark_event("sub_op_applied");
+  BLKIN_OP_TRACE_EVENT(rm->op, pg, "sub_op_applied");
   rm->applied = true;
 
   dout(10) << "sub_op_modify_applied on " << rm << " op "
@@ -8665,6 +8693,9 @@ void ReplicatedBackend::sub_op_modify_applied(RepModifyRef rm)
   // send ack to acker only if we haven't sent a commit already
   if (ack) {
     ack->set_priority(CEPH_MSG_PRIO_HIGH); // this better match commit priority!
+    BLKIN_MSG_INIT_TRACE(ack, rm->op->get_osd_trace());
+    BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), "replied_apply");
+    BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), "span_ended");
     get_parent()->send_message_osd_cluster(
       rm->ackerosd, ack, get_osdmap()->get_epoch());
   }
@@ -8708,6 +8739,9 @@ void ReplicatedBackend::sub_op_modify_commit(RepModifyRef rm)
   }
 
   commit->set_priority(CEPH_MSG_PRIO_HIGH); // this better match ack priority!
+  BLKIN_MSG_INIT_TRACE(commit, rm->op->get_osd_trace());
+  BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), "replied_commit");
+  BLKIN_MSG_TRACE_EVENT(rm->op->get_req(), "span_ended");
   get_parent()->send_message_osd_cluster(
     rm->ackerosd, commit, get_osdmap()->get_epoch());
   
@@ -9387,6 +9421,7 @@ struct C_OnPushCommit : public Context {
   OpRequestRef op;
   C_OnPushCommit(ReplicatedPG *pg, OpRequestRef op) : pg(pg), op(op) {}
   void finish(int) {
+    BLKIN_OP_TRACE_EVENT(op, pg, "committed");
     op->mark_event("committed");
     log_subop_stats(pg->osd->logger, op, l_osd_sop_push);
   }
diff --git a/src/osdc/Objecter.cc b/src/osdc/Objecter.cc
index b4792d6..80a7dab 100644
--- a/src/osdc/Objecter.cc
+++ b/src/osdc/Objecter.cc
@@ -2728,6 +2728,7 @@ MOSDOp *Objecter::_prepare_osd_op(Op *op)
   m->ops = op->ops;
   m->set_mtime(op->mtime);
   m->set_retry_attempt(op->attempts++);
+  BLKIN_MSG_INIT_TRACE_IF(op->trace, m, op->trace);
 
   if (op->replay_version != eversion_t())
     m->set_version(op->replay_version);  // we're replaying this op!
@@ -2868,6 +2869,7 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
 	    << " ... stray" << dendl;
     s->lock.unlock();
     put_session(s);
+    BLKIN_MSG_TRACE_EVENT(m, "span_ended");
     m->put();
     return;
   }
@@ -2880,6 +2882,10 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
 		<< dendl;
   Op *op = iter->second;
 
+  BLKIN_MSG_TRACE_EVENT_IF(op->oncommit, m, "oncommit_message");
+  BLKIN_MSG_TRACE_EVENT_IF(op->onack, m, "onack_message");
+  BLKIN_MSG_TRACE_EVENT(m, "span_ended");
+
   if (m->get_retry_attempt() >= 0) {
     if (m->get_retry_attempt() != (op->attempts - 1)) {
       ldout(cct, 7) << " ignoring reply from attempt " << m->get_retry_attempt()
@@ -2970,6 +2976,7 @@ void Objecter::handle_osd_op_reply(MOSDOpReply *m)
   assert(op->out_bl.size() == op->out_rval.size());
   assert(op->out_bl.size() == op->out_handler.size());
   vector<OSDOp>::iterator p = out_ops.begin();
+  BLKIN_OP_EVENT_IF(op->trace, op->trace, "in_handle_osd_op_reply");
   for (unsigned i = 0;
        p != out_ops.end() && pb != op->out_bl.end();
        ++i, ++p, ++pb, ++pr, ++ph) {
diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
index fef7cd4..cb37cf1 100644
--- a/src/osdc/Objecter.h
+++ b/src/osdc/Objecter.h
@@ -54,6 +54,7 @@ struct ObjectOperation {
   vector<OSDOp> ops;
   int flags;
   int priority;
+  BLKIN_TRACE_REF(trace);
 
   vector<bufferlist*> out_bl;
   vector<Context*> out_handler;
@@ -71,6 +72,8 @@ struct ObjectOperation {
     return ops.size();
   }
 
+  BLKIN_OP_SET_TRACE_DECL()
+
   void set_last_op_flags(int flags) {
     assert(!ops.empty());
     ops.rbegin()->op.flags = flags;
@@ -1056,6 +1059,7 @@ private:
   atomic_t global_op_flags; // flags which are applied to each IO op
   bool keep_balanced_budget;
   bool honor_osdmap_full;
+  BLKIN_END_REF(objecter_endpoint)
 
 public:
   void maybe_request_map();
@@ -1175,6 +1179,7 @@ public:
     epoch_t map_dne_bound;
 
     bool budgeted;
+    BLKIN_TRACE_REF(trace);
 
     /// true if we should resend this message on failure
     bool should_resend;
@@ -1224,6 +1229,8 @@ public:
 	target.base_oloc.key.clear();
     }
 
+    BLKIN_OP_SET_TRACE_DECL()
+
     bool operator<(const Op& other) const {
       return tid < other.tid;
     }
@@ -1234,6 +1241,7 @@ public:
 	delete out_handler.back();
 	out_handler.pop_back();
       }
+      BLKIN_OP_EVENT_IF(trace, trace, "span_ended");
     }
   };
 
@@ -1855,7 +1863,9 @@ private:
     op_throttle_bytes(cct, "objecter_bytes", cct->_conf->objecter_inflight_op_bytes),
     op_throttle_ops(cct, "objecter_ops", cct->_conf->objecter_inflight_ops),
     epoch_barrier(0)
-  { }
+  {
+    BLKIN_MSG_END(objecter, "0.0.0.0", 0, "objecter");
+  }
   ~Objecter();
 
   void init();
@@ -2047,6 +2057,7 @@ public:
     Op *o = prepare_read_op(oid, oloc, op, snapid, pbl, flags, onack, objver, data_offset);
     if (features)
       o->features = features;
+    BLKIN_OP_SET_TRACE(o, op.trace);
     return op_submit(o);
   }
   ceph_tid_t pg_read(uint32_t hash, object_locator_t oloc,
@@ -2225,6 +2236,29 @@ public:
     return read(oid, oloc, 0, 0, snap, pbl, flags | global_op_flags.read() | CEPH_OSD_FLAG_READ, onfinish, objver);
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
+    Op *o = new Op(oid, oloc, ops, flags | global_op_flags.read() | CEPH_OSD_FLAG_READ, onfinish, 0, objver);
+    o->snapid = snap;
+    o->outbl = pbl;
+    ZTracer::ZTraceRef t = ZTracer::create_ZTrace("librados", objecter_endpoint);
+    t->set_trace_info(info);
+    t->event("objecter_read");
+    o->set_trace(t);
+    free(info);
+    return op_submit(o);
+  }
+#endif // WITH_BLKIN
 
   // writes
   ceph_tid_t _modify(const object_t& oid, const object_locator_t& oloc,
@@ -2424,11 +2458,38 @@ public:
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
+    Op *o = new Op(oid, oloc, ops, flags | global_op_flags.read() | CEPH_OSD_FLAG_WRITE, onack, oncommit, objver);
+    o->mtime = mtime;
+    o->snapc = snapc;
+    ZTracer::ZTraceRef t = ZTracer::create_ZTrace("librados", objecter_endpoint);
+    t->set_trace_info(info);
+    t->event("objecter_write");
+    o->set_trace(t);
+    free(info);
+    return op_submit(o);
+  }
+#endif // WITH_BLKIN
+
   void list_nobjects(NListContext *p, Context *onfinish);
   uint32_t list_nobjects_seek(NListContext *p, uint32_t pos);
   void list_objects(ListContext *p, Context *onfinish);
   uint32_t list_objects_seek(ListContext *p, uint32_t pos);
 
+
   // -------------------------
   // pool ops
 private:
-- 
2.1.0

