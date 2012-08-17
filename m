From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: SimpleMessenger dispatching: cause of performance problems?
Date: Fri, 17 Aug 2012 09:30:50 +0200
Message-ID: <20120817093050.1b868fa9@andylap2.itxperts.de>
References: <502D1B07.3030101@itxperts.de>
	<CAC-hyiFgdD8EcF1uonkdbAwshDh87aP3NjXBvCPv3gbW7XpazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/eKGJTP+YMNPekxqevHgh26H"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:38838 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab2HQHaz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 03:30:55 -0400
In-Reply-To: <CAC-hyiFgdD8EcF1uonkdbAwshDh87aP3NjXBvCPv3gbW7XpazQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

--MP_/eKGJTP+YMNPekxqevHgh26H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

sorry: forgot the attachment in my previous reply....


Andreas

On Thu, 16 Aug 2012 09:44:23 -0700
Yehuda Sadeh <yehuda@inktank.com> wrote:

> On Thu, Aug 16, 2012 at 9:08 AM, Andreas Bluemle
> <andreas.bluemle@itxperts.de> wrote:
> >
> > Hi,
> >
> > I have been trying to migrate a ceph cluster (ceph-0.48argonaut)
> > to a high speed cluster network and encounter scalability problems:
> > the overall performance of the ceph cluster does not scale well
> > with an increase in the underlying networking speed.
> >
> > In short:
> >
> > I believe that the dispatching from SimpleMessenger to
> > OSD worker queues causes that scalability issue.
> >
> > Question: is it possible that this dispatching is causing
> > performance problems?
> >
> >
> > In detail:
> >
> > In order to find out more about this problem, I have added
> > profiling to the ceph code in various place; for write operations
> > to the primary or the secondary, timestamps are recorded for OSD
> > object, offset and length of the such a write request.
> >
> > Timestamps record:
> >  - receipt time at SimpleMessenger
> >  - processing time at osd
> >  - for primary write operations: wait time until replication
> > operation is acknowledged.
> 
> Did you make any code changes? We'd love to see those.
> 
> >
> > What I believe is happening: dispatching requests from
> > SimpleMessenger to OSD worker threads seems to consume a fair
> > amount of time. This ends up in a widening gap between subsequent
> > receipts of requests and the start of OSD processing them.
> >
> > A primary write suffers twice from this problem: first because
> > the delay happens on the primary OSD and second because the
> > replicating OSD also suffers from the same problem - and hence
> > causes additional delays
> > at the primary OSD when it waits for the commit from the
> > replicating OSD.
> >
> > In the attached graphics, the x-axis shows the time (in seconds)
> > The y-axis shows the offset where a request to write happened.
> >
> > The red bar represents the SimpleMessenger receive, i.e. from
> > reading the message header until enqueuing the completely decoded
> > message into the SImpleMessenger dispatch queue.
> 
> Could it be that messages were throttled here?
> There's a configurable that can be set (ms dispatch throttle bytes),
> might affect that.
> 
> >
> > The green bar represents the time required for local processing,
> > i.e. dispatching the the OSD worker, writing to filesystem and
> > journal, send out the replication operation to the replicating OSD.
> > It right end of the green bar is the time when locally everything
> > has finished and a commit could happen.
> >
> > The blue bar represents the time until the replicating OSD has sent
> > a commit
> > back to the primary OSD and the original write request can be
> > committed to the client.
> >
> > The green bar is interrupted by a black bar: the left end represents
> > the time when the request has been enqueued on the OSD worker
> > queue. The right end gives the time when the request is taken off
> > the OSD worker queue and actual OSD processing starts.
> >
> > The test was a simple sequential write to a rados block device.
> >
> > Receiption of the write requests at the OSD is also sequential in
> > the graphics: the bar to the bottom of the graphics shows an
> > earlier write request.
> >
> > Note that the dispatching of a later request in all cases relates
> > to the enqueue time at the OSD worker queue of the previous write
> > request: the left
> > end of a black bar relates nicely to the beginning of a green bar
> > above it.
> >
> >
> 
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm

--MP_/eKGJTP+YMNPekxqevHgh26H
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ITX-timestamps.patch

--- rpmsrc.old/BUILD/ceph-0.48/./src/os/JournalingObjectStore.cc	2012-04-24 22:06:39.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/os/JournalingObjectStore.cc	2012-07-25 13:40:17.000000000 +0200
@@ -1,3 +1,4 @@
+#include "common/ITX.h"
 
 #include "JournalingObjectStore.h"
 
@@ -286,6 +287,7 @@
   assert(journal_lock.is_locked());
   dout(10) << "op_journal_transactions " << op << " " << tls << dendl;
     
+  itx_profile.write_checkpoint("JournalingObjectStore::_op_journal_transactions: ", ITX_JOURNAL_PROCESS_TRANSACTION_START, op, tls);
   if (journal && journal->is_writeable()) {
     bufferlist tbl;
     unsigned data_len = 0, data_align = 0;
--- rpmsrc.old/BUILD/ceph-0.48/./src/os/ObjectStore.h	2012-06-26 19:56:38.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/os/ObjectStore.h	2012-07-25 13:35:15.000000000 +0200
@@ -197,6 +197,9 @@
     uint32_t get_data_length() {
       return largest_data_len;
     }
+    uint32_t get_largest_data_off() {
+      return largest_data_off;
+    }
     uint32_t get_data_offset() {
       if (largest_data_off_in_tbl) {
 	return largest_data_off_in_tbl +
--- rpmsrc.old/BUILD/ceph-0.48/./src/msg/SimpleMessenger.cc	2012-06-30 23:48:15.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/msg/SimpleMessenger.cc	2012-08-13 10:41:47.000000000 +0200
@@ -29,6 +29,7 @@
 #include "global/global_init.h"
 
 #include "messages/MGenericMessage.h"
+#include "common/ITX.h"
 
 #include <netdb.h>
 
@@ -307,6 +308,7 @@
       pipe->pipe_lock.Lock();
       list<Message *>& m_queue = pipe->in_q[priority];
       Message *m = m_queue.front();
+      int qlen = m_queue.size();
       m_queue.pop_front();
 
       if (m_queue.empty()) {
@@ -351,7 +353,7 @@
 	  uint64_t msize = m->get_dispatch_throttle_size();
 	  m->set_dispatch_throttle_size(0);  // clear it out, in case we requeue this message.
 
-	  ldout(cct,1) << "<== " << m->get_source_inst()
+	  ldout(cct,1) << "<== " << "[prio: " << priority << ", qsize: " << qlen << "] " << m->get_source_inst()
 		  << " " << m->get_seq()
 		  << " ==== " << *m
 		  << " ==== " << m->get_payload().length() << "+" << m->get_middle().length()
@@ -360,6 +362,7 @@
 		  << " " << m->get_footer().data_crc << ")"
 		  << " " << m << " con " << m->get_connection()
 		  << dendl;
+          itx_profile.write_checkpoint("SimpleMessenger::dispatch_entry", ITX_DISPATCH_OP, m);
 	  ms_deliver_dispatch(m);
 
 	  dispatch_throttle_release(msize);
@@ -555,6 +558,7 @@
     msgr->dispatch_queue.lock.Unlock();
   } else {
     // just queue message under pipe lock.
+    ldout(msgr->cct,1) << "queue_received: queue len: " << queue.size() << ", in_qlen: " << in_qlen+1 << dendl;
     queue.push_back(m);
   }
   
@@ -1639,6 +1643,7 @@
 	       << m->get_seq() << " " << m << " " << *m
 	       << dendl;
       queue_received(m);
+      itx_profile.write_checkpoint("SimpleMessenger::read_message", ITX_MSG_SM_QUEUED, m);
     } 
     
     else if (tag == CEPH_MSGR_TAG_CLOSE) {
@@ -1869,8 +1874,11 @@
   int aborted;
   Message *message;
   utime_t recv_stamp = ceph_clock_now(msgr->cct);
+  utime_t complete_stamp;
+  utime_t decoded_stamp;
   bool waited_on_throttle = false;
 
+
   uint64_t message_size = header.front_len + header.middle_len + header.data_len;
   if (message_size) {
     if (policy.throttler) {
@@ -1985,12 +1993,18 @@
 
   ldout(msgr->cct,20) << "reader got " << front.length() << " + " << middle.length() << " + " << data.length()
 	   << " byte message" << dendl;
+  complete_stamp = ceph_clock_now(msgr->cct);
   message = decode_message(msgr->cct, header, footer, front, middle, data);
+  decoded_stamp = ceph_clock_now(msgr->cct);
   if (!message) {
     ret = -EINVAL;
     goto out_dethrottle;
   }
 
+ itx_profile.write_checkpoint("SimpleMessenger::read_message", ITX_RECEIVED, message, recv_stamp);
+ itx_profile.write_checkpoint("SimpleMessenger::read_message", ITX_MSG_COMPLETE, message, complete_stamp, data_len);
+ itx_profile.write_checkpoint("SimpleMessenger::read_message", ITX_MSG_DECODED, message, decoded_stamp);
+
   message->set_throttler(policy.throttler);
 
   // store reservation size in message, so we don't get confused
--- rpmsrc.old/BUILD/ceph-0.48/./src/os/FileStore.cc	2012-07-02 20:43:58.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/os/FileStore.cc	2012-07-25 13:39:03.000000000 +0200
@@ -48,6 +48,8 @@
 #include <fstream>
 #include <sstream>
 
+#include "common/ITX.h"
+
 #include "FileStore.h"
 #include "common/BackTrace.h"
 #include "include/types.h"
@@ -2143,6 +2145,7 @@
 
   op_tp.unlock();
 
+  itx_profile.write_checkpoint("FileStore::queue_op:", ITX_FS_QUEUE_OP, o->op, o->tls);
   dout(5) << "queue_op " << o << " seq " << o->op
 	  << " " << *osr
 	  << " " << o->bytes << " bytes"
@@ -2205,7 +2208,11 @@
   Op *o = osr->peek_queue();
 
   dout(5) << "_do_op " << o << " seq " << o->op << " " << *osr << "/" << osr->parent << " start" << dendl;
+
+  itx_profile.write_checkpoint("_do_op: do_transactions begin :", ITX_FS_PROCESS_TRANSACTION_START, o->op, o->tls);
   int r = do_transactions(o->tls, o->op);
+  itx_profile.write_checkpoint("_do_op: do_transactions end:", ITX_FS_PROCESS_TRANSACTION_DONE, o->op, o->tls);
+
   op_apply_finish(o->op);
   dout(10) << "_do_op " << o << " seq " << o->op << " r = " << r
 	   << ", finisher " << o->onreadable << " " << o->onreadable_sync << dendl;
@@ -2292,6 +2299,7 @@
       dump_transactions(o->tls, o->op, osr);
 
     if (m_filestore_journal_parallel) {
+      itx_profile.write_checkpoint("FileStore::parallel: queue_transactions start", ITX_QUEUE_TRANSACTION_START, o->op, o->tls);
       dout(5) << "queue_transactions (parallel) " << o->op << " " << o->tls << dendl;
       
       _op_journal_transactions(o->tls, o->op, ondisk, osd_op);
@@ -2299,6 +2307,7 @@
       // queue inside journal lock, to preserve ordering
       queue_op(osr, o);
     } else if (m_filestore_journal_writeahead) {
+      itx_profile.write_checkpoint("FileStore::writeahead: queue_transactions start", ITX_QUEUE_TRANSACTION_START, o->op, o->tls);
       dout(5) << "queue_transactions (writeahead) " << o->op << " " << o->tls << dendl;
       
       osr->queue_journal(o->op);
@@ -2310,11 +2319,13 @@
       assert(0);
     }
     op_submit_finish(o->op);
+    itx_profile.write_checkpoint("FileStore::queue_transactions done", ITX_QUEUE_TRANSACTION_END, o->op);
     return 0;
   }
 
   uint64_t op = op_submit_start();
   dout(5) << "queue_transactions (trailing journal) " << op << " " << tls << dendl;
+  itx_profile.write_checkpoint("FileStore::trailing: queue_transactions start", ITX_QUEUE_TRANSACTION_START, op, tls);
 
   if (m_filestore_do_dump)
     dump_transactions(tls, op, osr);
@@ -3185,6 +3196,7 @@
   }
 
  out:
+  itx_profile.write_checkpoint("FileStore::_write done writing to filesystem", ITX_FS_WRITE_DONE, cid, oid, offset, len);
   dout(10) << "write " << cid << "/" << oid << " " << offset << "~" << len << " = " << r << dendl;
   return r;
 }
--- rpmsrc.old/BUILD/ceph-0.48/./src/osd/ReplicatedPG.cc	2012-08-17 08:04:35.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/osd/ReplicatedPG.cc	2012-07-25 13:35:15.000000000 +0200
@@ -39,6 +39,7 @@
 #include "mds/inode_backtrace.h" // Ugh
 
 #include "common/config.h"
+#include "common/ITX.h"
 #include "include/compat.h"
 
 #include "json_spirit/json_spirit_value.h"
@@ -549,6 +550,8 @@
 				       CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK); 
   reply->set_data(outdata);
   reply->set_result(result);
+  itx_profile.write_checkpoint("ReplicatedPG::do_pg_op: commit", ITX_PG_OP_COMMIT, m);
+  itx_profile.write_checkpoint("ReplicatedPG::do_pg_op: commit", ITX_OP_FINISHED, m);
   osd->client_messenger->send_message(reply, m->get_connection());
   delete filter;
 }
@@ -950,6 +953,8 @@
     reply->set_version(info.last_update);
     ctx->reply = NULL;
     reply->add_flags(CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK);
+    itx_profile.write_checkpoint("ReplicatedPG::do_op: commit read", ITX_OP_READ_COMMIT, m);
+    itx_profile.write_checkpoint("ReplicatedPG::do_op: commit read", ITX_OP_FINISHED, m);
     osd->client_messenger->send_message(reply, m->get_connection());
     delete ctx;
     put_object_context(obc);
@@ -3379,6 +3384,10 @@
   repop->applying = false;
   repop->applied = true;
 
+  if (repop->ctx->op) {
+    itx_profile.write_checkpoint("ReplicatedPG::op_applied: ", ITX_PG_OP_LOCAL_APPLIED, repop->ctx->op->request);
+  }
+
   // (logical) local ack.
   int whoami = osd->get_nodeid();
 
@@ -3430,6 +3439,9 @@
   if (repop->ctx->op)
     repop->ctx->op->mark_event("op_commit");
 
+  if (repop->ctx->op) {
+    itx_profile.write_checkpoint("ReplicatedPG::op_commit: ", ITX_PG_OP_LOCAL_COMMIT, repop->ctx->op->request);
+  }
   if (repop->aborted) {
     dout(10) << "op_commit " << *repop << " -- aborted" << dendl;
   } else if (repop->waitfor_disk.count(osd->get_nodeid()) == 0) {
@@ -3508,6 +3520,7 @@
 	reply->add_flags(CEPH_OSD_FLAG_ACK | CEPH_OSD_FLAG_ONDISK);
 	dout(10) << " sending commit on " << *repop << " " << reply << dendl;
 	assert(entity_name_t::TYPE_OSD != m->get_connection()->peer_type);
+        itx_profile.write_checkpoint("ReplicatedPG::eval_repop: commit", ITX_OP_COMMIT, m);
 	osd->client_messenger->send_message(reply, m->get_connection());
 	repop->sent_disk = true;
       }
@@ -3525,6 +3538,7 @@
 	reply->add_flags(CEPH_OSD_FLAG_ACK);
 	dout(10) << " sending ack on " << *repop << " " << reply << dendl;
         assert(entity_name_t::TYPE_OSD != m->get_connection()->peer_type);
+        itx_profile.write_checkpoint("ReplicatedPG::eval_repop: ack", ITX_OP_ACK, m);
 	osd->client_messenger->send_message(reply, m->get_connection());
 	repop->sent_ack = true;
       }
@@ -3541,7 +3555,9 @@
   // done.
   if (repop->waitfor_ack.empty() && repop->waitfor_disk.empty()) {
     repop->done = true;
-
+    if (m) {
+      itx_profile.write_checkpoint("ReplicatedPG::eval_repop: ack", ITX_OP_FINISHED, m);
+    }
     calc_min_last_complete_ondisk();
 
     // kick snap_trimmer if necessary
@@ -3626,6 +3642,9 @@
     }
     
     wr->pg_trim_to = pg_trim_to;
+    if ((i == 1) && (ctx->op) && (ctx->op->request)) {
+      itx_profile.write_checkpoint("ReplicatedPG::issue_repop", ITX_PG_SEND_REPOP, ctx->op->request);
+    }
     osd->cluster_messenger->send_message(wr, get_osdmap()->get_cluster_inst(peer));
 
     // keep peer_info up to date
@@ -4162,7 +4181,7 @@
   else
     opname = "trans";
 
-  dout(10) << "sub_op_modify " << opname 
+  dout(10) << "sub_op_modify " << opname
            << " " << soid 
            << " v " << m->version
 	   << (m->noop ? " NOOP" : "")
@@ -4249,6 +4268,7 @@
 
     rm->bytes_written = rm->opt.get_encoded_bytes();
 
+
   } else {
     // just trim the log
     if (m->pg_trim_to != eversion_t()) {
@@ -4279,6 +4299,7 @@
     // send ack to acker only if we haven't sent a commit already
     MOSDSubOpReply *ack = new MOSDSubOpReply(m, 0, get_osdmap()->get_epoch(), CEPH_OSD_FLAG_ACK);
     ack->set_priority(CEPH_MSG_PRIO_HIGH); // this better match commit priority!
+    itx_profile.write_checkpoint("ReplicatedPG::sub_op_modify_applied: ACK", ITX_SUBOP_ACK, rm->opt);
     osd->cluster_messenger->send_message(ack, get_osdmap()->get_cluster_inst(rm->ackerosd));
   }
 
@@ -4298,6 +4319,7 @@
 
   unlock();
   if (done) {
+	itx_profile.write_checkpoint("ReplicatedPG::sub_op_modify_commit", ITX_OP_FINISHED, rm->opt);
     delete rm->ctx;
     delete rm;
     put();
@@ -4321,6 +4343,7 @@
     MOSDSubOpReply *commit = new MOSDSubOpReply((MOSDSubOp*)rm->op->request, 0, get_osdmap()->get_epoch(), CEPH_OSD_FLAG_ONDISK);
     commit->set_last_complete_ondisk(rm->last_complete);
     commit->set_priority(CEPH_MSG_PRIO_HIGH); // this better match ack priority!
+    itx_profile.write_checkpoint("ReplicatedPG::sub_op_modify_commit: ONDISK", ITX_SUBOP_COMMIT, rm->opt);
     osd->cluster_messenger->send_message(commit, get_osdmap()->get_cluster_inst(rm->ackerosd));
   }
   
@@ -4329,6 +4352,7 @@
 
   unlock();
   if (done) {
+	itx_profile.write_checkpoint("ReplicatedPG::sub_op_modify_commit", ITX_OP_FINISHED, rm->opt);
     delete rm->ctx;
     delete rm;
     put();
--- rpmsrc.old/BUILD/ceph-0.48/./src/osd/OSD.cc	2012-08-17 08:04:35.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/osd/OSD.cc	2012-08-13 14:29:43.000000000 +0200
@@ -92,6 +92,7 @@
 #include "common/safe_io.h"
 #include "common/HeartbeatMap.h"
 #include "common/admin_socket.h"
+#include "common/ITX.h"
 
 #include "global/signal_handler.h"
 #include "global/pidfile.h"
@@ -2529,6 +2530,11 @@
     ss << "reset pg recovery stats";
     pg_recovery_stats.reset();
   }
+  else if (cmd[0] == "code_profile") {
+    stringstream s;
+    itx_profile.cmd_handler(cmd, s);
+    ss << " profiling data" << s.str();
+  }
 
   else {
     ss << "unrecognized command! " << cmd;
@@ -2700,16 +2706,22 @@
 bool OSD::ms_dispatch(Message *m)
 {
   // lock!
+  itx_profile.write_checkpoint("OSD::ms_dispatch", ITX_OSD_DISPATCH1, m);
   osd_lock.Lock();
+  itx_profile.write_checkpoint("OSD::ms_dispatch", ITX_OSD_DISPATCH2, m);
   while (dispatch_running) {
     dout(10) << "ms_dispatch waiting for other dispatch thread to complete" << dendl;
     dispatch_cond.Wait(osd_lock);
   }
   dispatch_running = true;
 
+  itx_profile.write_checkpoint("OSD::ms_dispatch", ITX_OSD_DISPATCH3, m);
   do_waiters();
+  itx_profile.write_checkpoint("OSD::ms_dispatch", ITX_OSD_DISPATCH4, m);
   _dispatch(m);
+  itx_profile.write_checkpoint("OSD::ms_dispatch", ITX_OSD_DISPATCH5, m);
   do_waiters();
+  itx_profile.write_checkpoint("OSD::ms_dispatch", ITX_OSD_DISPATCH6, m);
 
   dispatch_running = false;
   dispatch_cond.Signal();
@@ -5265,7 +5277,9 @@
   }
 
   // we don't need encoded payload anymore
+  itx_profile.write_checkpoint("OSD::handle_op: clear start", ITX_OSD_HANDLE_OP_CLEAR_START, m);
   m->clear_payload();
+  itx_profile.write_checkpoint("OSD::handle_op: clear done", ITX_OSD_HANDLE_OP_CLEAR_DONE, m);
 
   // require same or newer map
   if (!require_same_or_newer_map(op, m->get_map_epoch()))
@@ -5573,6 +5587,7 @@
   dout(15) << *pg << " enqueue_op " << op->request << " "
            << *(op->request) << dendl;
   assert(pg->is_locked());
+  itx_profile.write_checkpoint("OSD::enqueue_op", ITX_OSD_ENQUEUE, pg, op->request);
 
   switch (op->request->get_type()) {
   case CEPH_MSG_OSD_OP:
@@ -5682,6 +5697,7 @@
     pg->op_queue.pop_front();
     
     dout(10) << "dequeue_op " << *op->request << " pg " << *pg << dendl;
+    itx_profile.write_checkpoint("OSD::dequeue_op", ITX_OSD_DEQUEUE, pg, op->request);
 
     // share map?
     //  do this preemptively while we hold osd_lock and pg->lock
--- rpmsrc.old/BUILD/ceph-0.48/./src/Makefile.am	2012-08-17 08:04:35.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/Makefile.am	2012-07-25 13:35:15.000000000 +0200
@@ -970,7 +970,7 @@
 libcommon_la_SOURCES = $(libcommon_files)
 libcommon_la_CFLAGS= ${CRYPTO_CFLAGS} ${AM_CFLAGS}
 libcommon_la_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
-libcommon_la_LDFLAGS = -lrt
+libcommon_la_LDFLAGS = -lrt -lboost_regex
 noinst_LTLIBRARIES += libcommon.la
 
 libglobal_la_SOURCES = \
@@ -1041,6 +1041,7 @@
 	msg/Message.cc \
 	msg/Messenger.cc \
 	msg/SimpleMessenger.cc \
+	common/ITX.cc \
 	msg/msg_types.cc \
 	msg/tcp.cc \
 	os/hobject.cc \
@@ -1106,6 +1107,12 @@
 libmon_a_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
 noinst_LIBRARIES += libmon.a
 
+libITX_la_SOURCES = \
+	common/ITX.cc
+libITX_la_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
+libITX_la_LIBADD =
+noinst_LTLIBRARIES += libITX.la
+
 libmds_a_SOURCES = \
 	mds/Dumper.cc \
 	mds/Resetter.cc \
@@ -1553,6 +1560,7 @@
         msg/Message.h\
         msg/Messenger.h\
         msg/SimpleMessenger.h\
+        common/ITX.h\
         msg/msg_types.h\
         msg/tcp.h\
 	objclass/objclass.h\
--- rpmsrc.old/BUILD/ceph-0.48/./src/common/ITX.cc	2012-08-17 08:23:18.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/common/ITX.cc	2012-08-17 07:37:03.000000000 +0200
@@ -0,0 +1,1074 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*- 
+#include <string>
+#include <sstream>
+
+#include "include/assert.h"
+#include "include/xlist.h"
+
+#include "common/ITX.h"
+#include "common/config.h"
+
+#define dout_subsys ceph_subsys_ITX
+#undef dout_prefix
+#define dout_prefix *_dout << "ITX "
+
+
+ITX	itx_profile;
+
+template<class T>
+std::string t_to_string(T i)
+{
+    std::stringstream ss;
+    std::string s;
+    ss << i;
+    s = ss.str();
+
+    return s;
+}
+
+void
+ITX::write_checkpoint(string label, uint32_t where, Message *m, utime_t stamp)
+{
+  dout(20) << "write_checkpoint(string, uint32_t, Message, utime_t): " << label << dendl;
+	write_checkpoint(label, where, m, stamp, 0);
+}
+
+void
+ITX::write_checkpoint(string label, uint32_t where, Message *m, utime_t stamp, unsigned data_len)
+{
+  string obj_name;
+  string id;
+  utime_t tmp;
+  uint64_t off, len;
+  uint32_t opclass = ITX_OPCLASS_UNKNOWN;
+
+  if (m == NULL) return;
+
+  switch (m->get_type()) {
+    case CEPH_MSG_OSD_OP: {
+      MOSDOp *mm = (MOSDOp *)m;
+      obj_name = mm->get_oid().name;
+      get_offset_and_len(mm->ops, &off, &len);
+      dout(20) << "write_checkpoint(string ,uint32_t , Message, utime_t, unsigned): " << label << ", CEPH_MSG_OSD_OP " << off << "+" << len << dendl;
+      opclass = get_opclass(mm);
+      break;
+    }
+    case MSG_OSD_SUBOP: {
+      MOSDSubOp *mm = (MOSDSubOp *)m;
+      ObjectStore::Transaction ta;
+
+      if (mm->ops.size() == 0) {
+    	  bufferlist::iterator p = mm->get_data().begin();
+		  obj_name = mm->poid.oid.name;
+		  ::decode(ta, p);
+		  off = ta.get_largest_data_off();
+		  len = ta.get_data_length();
+		  // get_offset_and_len(mm->ops, &off, &len);
+		  dout(1) << "write_checkpoint(string ,uint32_t , Message, utime_t, unsigned): " << label << ", MSG_OSD_SUBOP " << obj_name << "+" <<  off << "+" << len << dendl;
+		  opclass = get_opclass(mm);
+      }
+      break;
+    }
+    default: {
+      obj_name = "unknown";
+      dout(1) << "write_checkpoint(string ,uint32_t , Message, utime_t, unsigned): " << label << ", unknown type: " << m->get_type() << dendl;
+      break;
+    }
+  }
+
+  if (obj_name.compare("unknown") != 0) {
+	checkpoint_key key(obj_name, off, len);
+	// id = create_id(obj_name, off, len);
+    // if (get_timestamp(obj_name, where, tmp) == false) {
+       dout(2) << "set timestamp for: " << key << " from " << itx_checkpoint_names[where] << dendl;
+      set_timestamp(key, where, stamp);
+    // }
+    if (data_len != 0) {
+      set_datalen(key, data_len);
+    }
+  }
+}
+
+void
+ITX::write_checkpoint(string label, uint32_t where, PG *pg, Message *m)
+{
+  string obj_name;
+  string id;
+  utime_t received;
+  utime_t tmp;
+  uint32_t  cpid;
+  uint32_t opclass = ITX_OPCLASS_UNKNOWN;
+  uint64_t off, len;
+
+  if (m == NULL) return;
+
+  dout(20) << "write_checkpoint(string, uint32_t, PG, Message): " << label << dendl;
+  received.tv.tv_sec = 0;
+  received.tv.tv_nsec = 0;
+
+  obj_name = "unknown";
+  cpid = where;
+  switch (m->get_type()) {
+    case CEPH_MSG_OSD_OP: {
+      MOSDOp *mm = (MOSDOp *)m;
+      obj_name = mm->get_oid().name;
+      if (where == ITX_DISPATCH_OP) {
+        cpid = ITX_DISPATCH_MSG_OSD_OP;
+        received = mm->get_recv_stamp();
+      }
+      get_offset_and_len(mm->ops, &off, &len);
+      opclass = get_opclass(mm);
+      break;
+    }
+    case CEPH_MSG_OSD_OPREPLY: {
+      MOSDOpReply *mm = (MOSDOpReply *)m;
+      obj_name = mm->get_oid().name;
+      if (where == ITX_DISPATCH_OP) cpid = ITX_DISPATCH_MSG_OSD_OPREPLY;
+      break;
+    }
+    case MSG_OSD_SUBOP: {
+      MOSDSubOp *mm = (MOSDSubOp *)m;
+      ObjectStore::Transaction ta;
+
+      if (where == ITX_DISPATCH_OP) cpid = ITX_DISPATCH_MSG_OSD_SUBOP;
+      if (mm->ops.size() == 0) {
+		bufferlist::iterator p = mm->get_data().begin();
+		obj_name = mm->poid.oid.name;
+		::decode(ta, p);
+		off = ta.get_largest_data_off();
+		len = ta.get_data_length();
+		opclass = get_opclass(mm);
+      }
+      break;
+    }
+    case MSG_OSD_SUBOPREPLY: {
+      MOSDSubOpReply *mm = (MOSDSubOpReply *)m;
+      obj_name = mm->poid.oid.name;
+      if (where == ITX_DISPATCH_OP) cpid = ITX_DISPATCH_MSG_OSD_SUBOPREPLY;
+      get_offset_and_len(mm->ops, &off, &len);
+      break;
+    }
+    default: {
+      break;
+    }
+  }
+
+  if (obj_name != "unknown") {
+	checkpoint_key key(obj_name, off, len);
+	// id = create_id(obj_name, off, len);
+    if (received.tv.tv_sec != 0) {
+      if (get_timestamp(key, ITX_RECEIVED, tmp) == false) {
+    	  dout(2) << "set timestamp for: " << key << " from " << itx_checkpoint_names[where] << dendl;
+    	  set_timestamp(key, ITX_RECEIVED, received, opclass);
+      }
+    }
+    dout(2) << "save timestamp for: " << key << " from " << itx_checkpoint_names[where] << dendl;
+    save_timestamp(key, cpid, opclass);
+  }
+}
+
+void
+ITX::write_checkpoint(string label, uint32_t where, list<ObjectStore::Transaction*>& tls)
+{
+  dout(20) << "write_checkpoint(string, uint32_t, list<Transaction>): " << label << dendl;
+  for (list<ObjectStore::Transaction*>::iterator p = tls.begin(); p != tls.end(); p++) {
+	write_checkpoint(label, where, **p);
+  }
+}
+
+list<checkpoint_key>
+ITX::write_checkpoint(string label, uint32_t where, ObjectStore::Transaction& t)
+{
+  string op_name = "unknown";
+  checkpoint_key *key = NULL;
+  hobject_t oid;
+  uint64_t off, len;
+  list<checkpoint_key> keys;
+  ObjectStore::Transaction::iterator i = t.begin();
+
+  dout(20) << "write_checkpoint(string, uint32_t, Transaction): " << label << dendl;
+  while (i.have_op()) {
+	off = 0;
+	len = 0;
+    int op = i.get_op();
+    switch (op) {
+    case ObjectStore::Transaction::OP_NOP:
+      op_name = "OP_NOP";
+      break;
+    case ObjectStore::Transaction::OP_TOUCH:
+      {
+        op_name = "OP_TOUCH";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_WRITE:
+      {
+        op_name = "OP_WRITE";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	off = (i.get_length());
+	len = (i.get_length());
+	bufferlist bl;
+	i.get_bl(bl);
+        key = new checkpoint_key(oid.oid.name, off, len);
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_ZERO:
+      {
+        op_name = "OP_ZERO";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	off = (i.get_length());
+	len = (i.get_length());
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_TRIMCACHE:
+      {
+        op_name = "OP_TRIMCACHE";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	off = (i.get_length());
+	len = (i.get_length());
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_TRUNCATE:
+      {
+        op_name = "OP_TRUNCATE";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_REMOVE:
+      {
+        op_name = "OP_REMOVE";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_SETATTR:
+      {
+        op_name = "OP_SETATTR";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	string name = i.get_attrname();
+	bufferlist bl;
+	i.get_bl(bl);
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_SETATTRS:
+      {
+        op_name = "OP_SETATTRS";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	map<string, bufferptr> aset;
+	i.get_attrset(aset);
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_RMATTR:
+      {
+        op_name = "OP_RMATTR";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	string name = i.get_attrname();
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_RMATTRS:
+      {
+        op_name = "OP_RMATTRS";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+      }
+      break;
+      
+    case ObjectStore::Transaction::OP_CLONE:
+      {
+        op_name = "OP_CLONE";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	hobject_t noid = i.get_oid();
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_CLONERANGE:
+      {
+        op_name = "OP_CLONERANGE";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	hobject_t noid = i.get_oid();
+ 	off = (i.get_length());
+	len = (i.get_length());
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_CLONERANGE2:
+      {
+        op_name = "OP_CLONERANGE2";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+	hobject_t noid = i.get_oid();
+ 	off = (i.get_length());
+	len = (i.get_length());
+ 	uint64_t dstoff = i.get_length();
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_MKCOLL:
+      {
+        op_name = "OP_MKCOLL";
+	coll_t cid = i.get_cid();
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_RMCOLL:
+      {
+        op_name = "OP_RKCOLL";
+	coll_t cid = i.get_cid();
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_COLL_ADD:
+      {
+        op_name = "OP_COLL_ADD";
+	coll_t ocid = i.get_cid();
+	coll_t ncid = i.get_cid();
+	oid = i.get_oid();
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_COLL_REMOVE:
+       {
+        op_name = "OP_COLL_REMOVE";
+	coll_t cid = i.get_cid();
+	oid = i.get_oid();
+       }
+      break;
+
+    case ObjectStore::Transaction::OP_COLL_SETATTR:
+      {
+        op_name = "OP_COLL_SETATTR";
+	coll_t cid = i.get_cid();
+	string name = i.get_attrname();
+	bufferlist bl;
+	i.get_bl(bl);
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_COLL_RMATTR:
+      {
+        op_name = "OP_COLL_RMATTR";
+	coll_t cid = i.get_cid();
+	string name = i.get_attrname();
+      }
+      break;
+
+    case ObjectStore::Transaction::OP_STARTSYNC:
+      op_name = "OP_STARTSYNC";
+      break;
+
+    case ObjectStore::Transaction::OP_COLL_RENAME:
+      {
+        op_name = "OP_COLL_RENAME";
+	coll_t cid(i.get_cid());
+	coll_t ncid(i.get_cid());
+      }
+      break;
+
+    default:
+      op_name = "op unkown";
+      break;
+    }
+
+    if ((key != NULL) && (key->oid.compare("unknown") != 0)) {
+       keys.push_back(*key);
+       dout(2) << "save timestamp for: " << op_name << " " << key << " from " << itx_checkpoint_names[where] << dendl;
+       save_timestamp(*key, where);
+    }
+  }
+
+  if (keys.empty() == false) {
+    keys.sort();
+    keys.unique();
+  }
+  return(keys);
+}
+
+void
+ITX::write_checkpoint(string label, uint32_t where, uint64_t tls_id, list<ObjectStore::Transaction*>& tls)
+{
+  list<checkpoint_key> keys;
+
+  dout(20) << "write_checkpoint(string, uint32_t, uint64_t, list<Transaction>): " << label << dendl;
+  label.append("-");
+  label.append(t_to_string(tls_id));
+  for (list<ObjectStore::Transaction*>::iterator p = tls.begin(); p != tls.end(); p++) {
+    if (*p != NULL) {
+      keys = write_checkpoint(label, where, **p);
+      save_tls_id(keys, tls_id);
+    }
+  }
+}
+
+void
+ITX::write_checkpoint(string label, uint32_t where, coll_t cid, const hobject_t &oid, uint64_t off, size_t len)
+{
+  dout(20) << "write_checkpoint(string, uint32_t, coll_t, hobject_t, uint64_t, size_t): " << label << dendl;
+  checkpoint_key *key;
+  uint64_t u64_len;
+  u64_len = len;
+  key = new checkpoint_key(oid.oid.name, off, len);
+  dout(2) << "save timestamp for: " << key << " from " << itx_checkpoint_names[where] << dendl;
+  save_timestamp(*key, where);
+}
+
+void
+ITX::write_checkpoint(string label, uint32_t where, uint64_t tls_id)
+{
+  list<checkpoint_key> keys;
+  list<checkpoint_key>::iterator i;
+  checkpoint_key *key;
+
+  dout(20) << "write_checkpoint(string label, uint32_t where, uint64_t tls_id): " << label << dendl;
+  tls_lk->Lock();
+  if (tls_ids.find(tls_id) != tls_ids.end()) {
+    keys = tls_ids[tls_id];
+    if (keys.empty() == false) {
+      for (i = keys.begin(); i != keys.end(); i++) {
+        key = &(*i);
+        dout(2) << "save timestamp for: " << *key << " from " << itx_checkpoint_names[where] << dendl;
+        save_timestamp(*key, where);
+      }
+    }
+    drop_tls_id(tls_id);
+  }
+  tls_lk->Unlock();
+}
+
+string
+ITX::create_id(string oid, uint64_t offset, uint64_t len)
+{
+  ostringstream os;
+  os << oid << "+" << offset << "+" << len;
+  return(os.str());
+}
+
+void ITX::get_offset_and_len(vector<OSDOp> ops, uint64_t *off, uint64_t *len)
+{
+  if ((ops.empty() == false) && (ceph_osd_op_type_data(ops[0].op.op))) {
+    *off = (ops[0].op.extent.offset);
+    *len = (ops[0].op.extent.length);
+  } else {
+	 *off = 0;
+	 *len = 0;
+  }
+}
+
+uint32_t
+ITX::get_opclass(const MOSDOp *mm)
+{
+	uint32_t opclass = ITX_OPCLASS_UNKNOWN;
+	__le16 op;
+
+	if (mm->ops.empty() == false) {
+	  op = mm->ops[0].op.op;
+	  switch (op) {
+	  case CEPH_OSD_OP_WRITE:
+	  case CEPH_OSD_OP_WRITEFULL:
+		opclass = ITX_OPCLASS_WRITE;
+		break;
+	  case CEPH_OSD_OP_READ:
+		opclass = ITX_OPCLASS_READ;
+		break;
+	  default:
+		opclass = ITX_OPCLASS_UNKNOWN;
+		break;
+	  }
+	}
+	return opclass;
+}
+
+uint32_t
+ITX::get_opclass(const MOSDSubOp *mm)
+{
+	uint32_t opclass = ITX_OPCLASS_UNKNOWN;
+	__le16 op;
+
+	if (mm->ops.empty() == false) {
+	  op = mm->ops[0].op.op;
+	  switch (op) {
+	  case CEPH_OSD_OP_WRITE:
+	  case CEPH_OSD_OP_WRITEFULL:
+		opclass = ITX_OPCLASS_SUBOP_WRITE;
+		break;
+	  case CEPH_OSD_OP_READ:
+		opclass = ITX_OPCLASS_SUBOP_READ;
+		break;
+	  case CEPH_OSD_OP_PUSH:
+		opclass = ITX_OPCLASS_PUSH;
+		break;
+	  case CEPH_OSD_OP_PULL:
+		opclass = ITX_OPCLASS_PULL;
+		break;
+	  default:
+		opclass = ITX_OPCLASS_UNKNOWN;
+		break;
+	  }
+	} else {
+	  opclass = ITX_OPCLASS_NOOPS;
+	}
+	return opclass;
+}
+
+void
+ITX::print_timestamp(int where, utime_t timestamps[], ostream &out)
+{
+	__u32 sec, nsec;
+    sec = timestamps[where].tv.tv_sec;
+    if (sec > 0) sec -= start_sec;
+    nsec = timestamps[where].tv.tv_nsec / 10000;
+	out << "     " << itx_checkpoint_names[where] << ": ";
+	out << sec << '.' << std::setw(5) << nsec;
+	out << std::endl;
+}
+
+void
+ITX::print_checkpoint(hash_map<const checkpoint_key, checkpoint *>::iterator p, ostream &out)
+{
+	checkpoint * cp;
+
+	out << " pending timestamps: key " << p->first << std::endl;
+	cp = p->second;
+	out << " opclass: " << cp->opclass << ", length: " << cp->data_len << std::endl;
+	for (int i = 0; i < ITX_MAX_CHECKPOINT; i++) {
+	  print_timestamp(i, cp->timestamps, out);
+	}
+	out << std::endl;
+}
+
+void
+ITX::print_checkpoint_list(hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl, ostream &out)
+{
+	list<checkpoint *>::iterator p;
+	checkpoint * cp;
+
+	out << " timestamps: key " << pl->first << ", " << pl->second.size() << " entries" << std::endl;
+	for (p = pl->second.begin(); p != pl->second.end(); p++) {
+	  cp = *p;
+	  out << " opclass: " << cp->opclass << ", length: " << cp->data_len << std::endl;
+	  for (int i = 0; i < ITX_MAX_CHECKPOINT; i++) {
+	    print_timestamp(i, cp->timestamps, out);
+	  }
+	  out << std::endl;
+	}
+}
+
+void
+ITX::print_primary_write_checkpoints(hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl, ostream &out)
+{
+	list<checkpoint *>::iterator p;
+	checkpoint * cp;
+	const checkpoint_key *key;
+	utime_t *tsp;
+
+	key = &(pl->first);
+	for (p = pl->second.begin(); p != pl->second.end(); p++) {
+	  cp = *p;
+	  if (cp->opclass == ITX_OPCLASS_WRITE) {
+/*
+	ITX_RECEIVED = 0,               SM: header received    : 109.13477
+	ITX_MSG_COMPLETE,               SM: message complete   : 109.13485
+	ITX_MSG_DECODED,                SM: message decoded    : 109.13486
+	ITX_DISPATCH_MSG_OSD_OP, SM: dispatch message MOSDOp   : 109.22271
+	ITX_OSD_ENQUEUE,                       OSD: enqueue    : 109.22377
+	ITX_OSD_DEQUEUE,                       OSD: dequeue    : 109.23192
+	ITX_PG_SEND_REPOP,     PG: send replication request    : 109.23206
+	ITX_QUEUE_TRANSACTION_  START, FS: start transactions  : 109.23219
+	ITX_JOURNAL_PROCESS_TRANSACTION_START,  Journal: start transactions (journal only): 109.23237
+	ITX_FS_QUEUE_OP,     FS: queue operation for execution : 109.23256
+	ITX_QUEUE_TRANSACTION_END,  FS: end transaction        : 109.23263
+	ITX_FS_PROCESS_TRANSACTION_START, FS: start transactions (FS only)  : 109.23275
+	ITX_FS_WRITE_DONE,         FS: write to FS finished    : 109.23306
+	ITX_FS_PROCESS_TRANSACTION_DONE,  FS: end transactions (FS only) : 109.23329
+	ITX_PG_OP_LOCAL_APPLIED,      PG: op locally applied   : 109.23381
+	ITX_PG_OP_LOCAL_COMMIT,       PG: op locally committed : 109.23288
+	ITX_OP_COMMIT,         PG: send write commit to client : 109.23881
+	ITX_OP_FINISHED,              operation finished       : 109.23883
+*/
+
+		tsp = cp->timestamps;
+		if ((tsp[ITX_RECEIVED].tv.tv_nsec != 0) &&
+			(tsp[ITX_MSG_COMPLETE].tv.tv_nsec != 0) &&
+			(tsp[ITX_MSG_DECODED].tv.tv_nsec != 0) &&
+			(tsp[ITX_DISPATCH_MSG_OSD_OP].tv.tv_nsec != 0) &&
+			(tsp[ITX_OSD_ENQUEUE].tv.tv_nsec != 0) &&
+			(tsp[ITX_OSD_DEQUEUE].tv.tv_nsec != 0) &&
+			(tsp[ITX_PG_SEND_REPOP].tv.tv_nsec != 0) &&
+			(tsp[ITX_QUEUE_TRANSACTION_START].tv.tv_nsec != 0) &&
+			(tsp[ITX_JOURNAL_PROCESS_TRANSACTION_START].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_QUEUE_OP].tv.tv_nsec != 0) &&
+			(tsp[ITX_QUEUE_TRANSACTION_END].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_PROCESS_TRANSACTION_START].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_WRITE_DONE].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_PROCESS_TRANSACTION_DONE].tv.tv_nsec != 0) &&
+			(tsp[ITX_PG_OP_LOCAL_APPLIED].tv.tv_nsec != 0) &&
+			(tsp[ITX_PG_OP_LOCAL_COMMIT].tv.tv_nsec != 0) &&
+			(tsp[ITX_OP_COMMIT].tv.tv_nsec != 0) &&
+			(tsp[ITX_OP_FINISHED].tv.tv_nsec != 0))
+		{
+			out << key->oid << " " << key->offset << " " << key->len << " ";
+			utime_t start = tsp[ITX_RECEIVED];
+			utime_t delta;
+		    __u32 s;
+		    if (start.tv.tv_sec > 0) s = start.tv.tv_sec - start_sec;
+			out << s << '.' << std::setw(5) << start.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_MSG_DECODED] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_MSG_SM_QUEUED] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_DISPATCH_MSG_OSD_OP] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH1] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_HANDLE_OP_CLEAR_START] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_HANDLE_OP_CLEAR_DONE] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH4] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH5] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH6] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_ENQUEUE] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DEQUEUE] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_PG_SEND_REPOP] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_JOURNAL_PROCESS_TRANSACTION_START] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_PG_OP_LOCAL_COMMIT] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OP_COMMIT] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OP_FINISHED] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << std::endl;
+		}
+	  }
+	}
+}
+
+void
+ITX::print_secondary_write_checkpoints(hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl, ostream &out)
+{
+	list<checkpoint *>::iterator p;
+	checkpoint * cp;
+	const checkpoint_key *key;
+	utime_t *tsp;
+
+	key = &(pl->first);
+	for (p = pl->second.begin(); p != pl->second.end(); p++) {
+	  cp = *p;
+	  if (cp->opclass == ITX_OPCLASS_NOOPS) {
+/*
+ *  opclass: 7, length: 127535
+     ITX_RECEIVED:                SM: header received                 : 10.10338
+     ITX_MSG_COMPLETE:            SM: message complete                : 10.10348
+     ITX_MSG_DECODED;             SM: message decoded                 : 10.10378
+     ITX_DISPATCH_MSG_OSD_SUBOP:  SM: dispatch message MOSDSubOp      : 10.10970
+     ITX_OSD_ENQUEUE:             OSD: enqueue                        : 10.11162
+     ITX_OSD_DEQUEUE:             OSD: dequeue                        : 10.11585
+     ITX_SUBOP_COMMIT:            PG: send subop commit to primary    : 10.11795
+     ITX_QUEUE_TRANSACTION_START: FS: start transactions              : 10.11608
+     ITX_JOURNAL_PROCESS_TRANSACTION_START:   Journal: start transactions (journal only): 10.11631
+     ITX_FS_QUEUE_OP:             FS: queue operation for execution   : 10.11656
+     ITX_QUEUE_TRANSACTION_END:   FS: end transaction                 : 10.11665
+     ITX_FS_PROCESS_TRANSACTION_START:  FS: start transactions (FS only): 10.11689
+     ITX_FS_WRITE_DONE:           FS: write to FS finished            : 10.11740
+     ITX_FS_PROCESS_TRANSACTION_DONE:  FS: end transactions (FS only) : 10.11804
+     ITX_OP_FINISHED:             operation finished                  : 10.11908
+*/
+
+		tsp = cp->timestamps;
+		if ((tsp[ITX_RECEIVED].tv.tv_nsec != 0) &&
+			(tsp[ITX_MSG_COMPLETE].tv.tv_nsec != 0) &&
+			(tsp[ITX_MSG_DECODED].tv.tv_nsec != 0) &&
+			(tsp[ITX_DISPATCH_MSG_OSD_SUBOP].tv.tv_nsec != 0) &&
+			(tsp[ITX_OSD_ENQUEUE].tv.tv_nsec != 0) &&
+			(tsp[ITX_OSD_DEQUEUE].tv.tv_nsec != 0) &&
+			(tsp[ITX_SUBOP_COMMIT].tv.tv_nsec != 0) &&
+			(tsp[ITX_QUEUE_TRANSACTION_START].tv.tv_nsec != 0) &&
+			(tsp[ITX_JOURNAL_PROCESS_TRANSACTION_START].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_QUEUE_OP].tv.tv_nsec != 0) &&
+			(tsp[ITX_QUEUE_TRANSACTION_END].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_PROCESS_TRANSACTION_START].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_WRITE_DONE].tv.tv_nsec != 0) &&
+			(tsp[ITX_FS_PROCESS_TRANSACTION_DONE].tv.tv_nsec != 0) &&
+			(tsp[ITX_OP_FINISHED].tv.tv_nsec != 0))
+		{
+			out << key->oid << " " << key->offset << " " << key->len << " ";
+			utime_t start = tsp[ITX_RECEIVED];
+			utime_t delta;
+		    __u32 s;
+		    if (start.tv.tv_sec > 0) s = start.tv.tv_sec - start_sec;
+			out << s << '.' << std::setw(5) << start.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_MSG_DECODED] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_MSG_SM_QUEUED] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_DISPATCH_MSG_OSD_SUBOP] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH1] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH4] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH5] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DISPATCH6] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_ENQUEUE] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OSD_DEQUEUE] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_FS_PROCESS_TRANSACTION_START] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_JOURNAL_PROCESS_TRANSACTION_START] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_SUBOP_COMMIT] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << " ";
+			delta = tsp[ITX_OP_FINISHED] - start;
+			out << delta.tv.tv_sec << '.' << std::setw(5) << delta.tv.tv_nsec / 10000 << std::endl;
+		}
+	  }
+	}
+}
+void
+ITX::handle_get_pending_timestamps(string key, ostream &out)
+{
+  hash_map<const checkpoint_key, checkpoint *>::iterator p;
+
+
+  lk->Lock();
+  out << std::endl;
+  if (key == "") {
+    out << setfill('0');
+    for (p = cps.begin(); p != cps.end(); p++) {
+      print_checkpoint(p, out);
+    }
+    out << setfill(' ');
+  } else {
+	checkpoint_key cp_key(key);
+    p = cps.find(cp_key);
+    out << setfill('0');
+    if (p != cps.end()) {
+      print_checkpoint(p, out);
+
+    } else {
+      int keylen = key.length();
+      out << " timestamps: pattern " << key << std::endl;
+      for (p = cps.begin(); p != cps.end(); p++) {
+        if (p->first.oid.compare(0, keylen, key) != 0) continue;
+        print_checkpoint(p, out);
+      }
+    }
+    out << setfill(' ');
+    out << std::endl;
+  }
+  lk->Unlock();
+}
+
+void
+ITX::handle_get_timestamps(string key, ostream &out)
+{
+  hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl;
+
+
+  lk->Lock();
+  out << std::endl;
+  if (key == "") {
+    out << setfill('0');
+    for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+      print_checkpoint_list(pl, out);
+    }
+    out << setfill(' ');
+  } else {
+	checkpoint_key cp_key(key);
+    pl = cphistory.find(cp_key);
+    out << setfill('0');
+    if (pl != cphistory.end()) {
+      print_checkpoint_list(pl, out);
+
+    } else {
+      int keylen = key.length();
+      out << " timestamps: pattern " << key << std::endl;
+      for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+        if (pl->first.oid.compare(0, keylen, key) != 0) continue;
+        print_checkpoint_list(pl, out);
+      }
+    }
+    out << setfill(' ');
+    out << std::endl;
+  }
+  lk->Unlock();
+}
+
+void
+ITX::handle_get_primary_writes(string key, ostream &out)
+{
+  hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl;
+
+
+  lk->Lock();
+  out << std::endl;
+  out << "#                3        4       5        6          7      8      9         10           11           12     13    " << std::endl;
+  out << "# oid offset len received decoded SMqueued SMdispatch OSDenq OSDdeq sendRepOp JournalStart local_commit commit finish" << std::endl;
+  if (key == "") {
+    out << setfill('0');
+    for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+      print_primary_write_checkpoints(pl, out);
+    }
+    out << setfill(' ');
+  } else {
+	checkpoint_key cp_key(key);
+    pl = cphistory.find(cp_key);
+    out << setfill('0');
+    if (pl != cphistory.end()) {
+    	print_primary_write_checkpoints(pl, out);
+
+    } else {
+      int keylen = key.length();
+      out << " timestamps: pattern " << key << std::endl;
+      for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+        if (pl->first.oid.compare(0, keylen, key) != 0) continue;
+        print_primary_write_checkpoints(pl, out);
+      }
+    }
+    out << setfill(' ');
+    out << std::endl;
+  }
+  lk->Unlock();
+}
+
+void
+ITX::handle_get_secondary_writes(string key, ostream &out)
+{
+  hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl;
+
+
+  lk->Lock();
+  out << std::endl;
+  out << "#                3        4       5        6          7      8      9       10           11           12    " << std::endl;
+  out << "# oid offset len received decoded SMqueued SMdispatch OSDenq OSDdeq FSstart JournalStart subop_commit finish" << std::endl;
+  if (key == "") {
+    out << setfill('0');
+    for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+      print_secondary_write_checkpoints(pl, out);
+    }
+    out << setfill(' ');
+  } else {
+	checkpoint_key cp_key(key);
+    pl = cphistory.find(cp_key);
+    out << setfill('0');
+    if (pl != cphistory.end()) {
+    	print_secondary_write_checkpoints(pl, out);
+
+    } else {
+      int keylen = key.length();
+      out << " timestamps: pattern " << key << std::endl;
+      for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+        if (pl->first.oid.compare(0, keylen, key) != 0) continue;
+        print_secondary_write_checkpoints(pl, out);
+      }
+    }
+    out << setfill(' ');
+    out << std::endl;
+  }
+  lk->Unlock();
+}
+
+void
+ITX::handle_get_info(ostream &out)
+{
+  out << setfill(' ');
+  
+  lk->Lock();
+  out << std::endl;
+  out << " number of pending operations:  " << cps.size() << std::endl;
+  out << " number of completed objects:  " << cphistory.size() << std::endl;
+  lk->Unlock();
+  // tls_lk->Lock();
+  // out << " number of tls_ids:  " << tls_ids.size() << std::endl;
+  // tls_lk->Unlock();
+  out << " object filter:  " << ITX::objectid_filter.str();
+
+  out << setfill(' ');
+  out << std::endl;
+}
+
+void
+ITX::handle_get_pending_oids(string key, ostream &out)
+{
+  hash_map<const checkpoint_key, checkpoint * >::iterator p;
+  lk->Lock();
+  out << std::endl;
+  if (key == "") {
+	out << " pending oids: " << std::endl;
+    for (p = cps.begin(); p != cps.end(); p++) {
+      out << "    " << p->first << std::endl;
+    }
+  } else {
+	checkpoint_key cp_key(key);
+    p = cps.find(cp_key);
+    if (p != cps.end()) {
+      out << " pending oid: " << p->first << " exists"<< std::endl;
+    } else {
+      int keylen = key.length();
+      out << " pending oids: pattern " << key << std::endl;
+      for (p = cps.begin(); p != cps.end(); p++) {
+        if (p->first.oid.compare(0, keylen, key) != 0) continue;
+        out << "    " << p->first << std::endl;
+      }
+    }
+  }
+  lk->Unlock();
+}
+
+void
+ITX::handle_get_oids(string key, ostream &out)
+{
+  hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl;
+  lk->Lock();
+  out << std::endl;
+  if (key == "") {
+	out << " completed oids: " << std::endl;
+    for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+      out << "    " << pl->first << std::endl;
+    }
+  } else {
+	checkpoint_key cp_key(key);
+    pl = cphistory.find(cp_key);
+    if (pl != cphistory.end()) {
+      out << " completed oid: " << pl->first << " exists"<< std::endl;
+    } else {
+      int keylen = key.length();
+      out << " completed oids: pattern " << key << std::endl;
+      for (pl = cphistory.begin(); pl != cphistory.end(); pl++) {
+        if (pl->first.oid.compare(0, keylen, key) != 0) continue;
+        out << "    " << pl->first << std::endl;
+      }
+    }
+  }
+  lk->Unlock();
+}
+void
+ITX::handle_clear(ostream &out)
+{
+  lk->Lock();
+  tls_lk->Lock();
+  cphistory.erase(cphistory.begin(), cphistory.end());
+  cps.erase(cps.begin(), cps.end());
+  tls_ids.erase(tls_ids.begin(), tls_ids.end());
+  ITX::objectid_filter.assign("__notdefined__", boost::regex_constants::basic);
+  tls_lk->Unlock();
+  lk->Unlock();
+  handle_get_info(out);
+}
+
+void
+ITX::cmd_handler(const std::vector<std::string>& cmd, ostream &out)
+{
+  string op = cmd[1];
+
+  if (op == "help") {
+	out << std::endl;
+	out << " code_profile operations:" << std::endl;
+	out << "    info:  get summary info" << std::endl;
+	out << "    setfilter <regex>: set filter for object IDs" << std::endl;
+	out << "    completed-oids: object IDS for which complete profiling data is available" << std::endl;
+	out << "    pending-oids: object IDS for which incomplete profiling data is available" << std::endl;
+	out << "    get-completed [prefix]:  get profiling data for completed objects" << std::endl;
+	out << "    get-primary-writes [prefix]:  get condensed profiling data for primary write operations" << std::endl;
+	out << "    get-secondary-writes [prefix]:  get condensed profiling data for replica write operations" << std::endl;
+	out << "    get-pending [prefix]:  get profiling data for pending operations" << std::endl;
+	out << "    clear: free storage of profiled data and clear the object ID filter" << std::endl;
+  }
+  else if (op == "get-completed") {
+    string key;
+    if (cmd.size() < 3) {
+      key = "";
+    } else {
+      key = cmd[2];
+    }
+    handle_get_timestamps(key, out);
+  }
+  else if (op == "get-primary-writes") {
+      string key;
+      if (cmd.size() < 3) {
+        key = "";
+      } else {
+        key = cmd[2];
+      }
+      handle_get_primary_writes(key, out);
+  }
+  else if (op == "get-secondary-writes") {
+	string key;
+	if (cmd.size() < 3) {
+	  key = "";
+	} else {
+	  key = cmd[2];
+	}
+	handle_get_secondary_writes(key, out);
+  }
+  else if (op == "get-pending") {
+	string key;
+	if (cmd.size() < 3) {
+	  key = "";
+	} else {
+	  key = cmd[2];
+	}
+	handle_get_pending_timestamps(key, out);
+  }
+  else if (op == "info") {
+    handle_get_info(out);
+  }
+  else if (op == "setfilter") {
+	string filter;
+	if (cmd.size() < 3) {
+	  out << " ERROR: no filter specified";
+	  out << setfill(' ');
+	  out << std::endl;
+	} else {
+	  handle_setfilter(cmd[2]);
+	}
+  }
+  else if (op == "completed-oids") {
+	string key;
+	if (cmd.size() < 3) {
+	  key = "";
+	} else {
+	  key = cmd[2];
+	}
+	handle_get_oids(key, out);
+  }
+  else if (op == "pending-oids") {
+	string key;
+	if (cmd.size() < 3) {
+	  key = "";
+	} else {
+	  key = cmd[2];
+	}
+	handle_get_pending_oids(key, out);
+  }
+  else if (op == "clear") {
+	handle_clear(out);
+  }
+}
--- rpmsrc.old/BUILD/ceph-0.48/./src/common/ITX.h	2012-08-17 08:23:23.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/common/ITX.h	2012-08-13 14:31:06.000000000 +0200
@@ -0,0 +1,423 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*- 
+#ifndef ITX_H
+#define ITX_H
+
+#include <string>
+
+#include <ext/hash_map>
+#include <ext/hash_set>
+#include <time.h>
+#include <boost/regex.hpp>
+
+#include "include/assert.h"
+#include "include/xlist.h"
+
+#include "common/ceph_context.h"
+#include "common/Mutex.h"
+#include "msg/Message.h"
+
+#include "messages/MOSDOp.h"
+#include "messages/MOSDOpReply.h"
+#include "messages/MOSDSubOp.h"
+#include "messages/MOSDSubOpReply.h"
+#include "osd/OSD.h"
+#include "osd/ReplicatedPG.h"
+#include "osd/OpRequest.h"
+#include "os/ObjectStore.h"
+
+
+
+
+// from where is the checkpoint called
+enum itx_checkpoint {
+    ITX_RECEIVED = 0,
+    ITX_MSG_COMPLETE,
+    ITX_MSG_DECODED,
+    ITX_MSG_SM_QUEUED,
+    ITX_DISPATCH_OP,
+    ITX_DISPATCH_MSG_OSD_OP,
+    ITX_DISPATCH_MSG_OSD_OPREPLY,
+    ITX_DISPATCH_MSG_OSD_SUBOP,
+    ITX_DISPATCH_MSG_OSD_SUBOPREPLY,
+    ITX_OSD_DISPATCH1,
+    ITX_OSD_DISPATCH2,
+    ITX_OSD_DISPATCH3,
+    ITX_OSD_DISPATCH4,
+    ITX_OSD_DISPATCH5,
+    ITX_OSD_DISPATCH6,
+    ITX_OSD_HANDLE_OP_CLEAR_START,
+    ITX_OSD_HANDLE_OP_CLEAR_DONE,
+    ITX_OSD_ENQUEUE,
+    ITX_OSD_DEQUEUE,
+    ITX_PG_SEND_REPOP,
+    ITX_SUBOP_ACK,
+    ITX_SUBOP_COMMIT,
+    ITX_QUEUE_TRANSACTION_START,
+    ITX_JOURNAL_PROCESS_TRANSACTION_START,
+    ITX_FS_QUEUE_OP,
+    ITX_QUEUE_TRANSACTION_END,
+    ITX_FS_PROCESS_TRANSACTION_START,
+    ITX_FS_WRITE_DONE,
+    ITX_FS_PROCESS_TRANSACTION_DONE,
+    ITX_PG_OP_LOCAL_APPLIED,
+    ITX_PG_OP_LOCAL_COMMIT,
+    ITX_PG_OP_COMMIT,
+    ITX_OP_COMMIT,
+    ITX_OP_READ_COMMIT,
+    ITX_OP_ACK,
+    ITX_OP_FINISHED,
+    ITX_MAX_CHECKPOINT
+};
+
+enum itx_opclass {
+	ITX_OPCLASS_UNKNOWN = 0,
+	ITX_OPCLASS_READ,
+	ITX_OPCLASS_WRITE,
+	ITX_OPCLASS_SUBOP_READ,
+	ITX_OPCLASS_SUBOP_WRITE,
+	ITX_OPCLASS_PULL,
+	ITX_OPCLASS_PUSH,
+	ITX_OPCLASS_NOOPS
+};
+
+static string itx_checkpoint_names[] = {
+    "SM: header received                       ",
+    "SM: message complete                      ",
+    "SM: message decoded                       ",
+    "SM: message queued for dispatching        ",
+    "SM: dispatch message                      ",
+    "SM: dispatch message MOSDOp               ",
+    "SM: dispatch message MOSDOpReply          ",
+    "SM: dispatch message MOSDSubOp            ",
+    "SM: dispatch message MOSDSubOpReply       ",
+    "OSD: ms dispatch 1                        ",
+    "OSD: ms dispatch 2                        ",
+    "OSD: ms dispatch 3                        ",
+    "OSD: ms dispatch 4                        ",
+    "OSD: ms dispatch 5                        ",
+    "OSD: ms dispatch 6                        ",
+    "OSD: ms handle_op clear start             ",
+    "OSD: ms handle_op clear done              ",
+    "OSD: enqueue                              ",
+    "OSD: dequeue                              ",
+    "PG: send replication request              ",
+    "PG: send subop ack to primary             ",
+    "PG: send subop commit to primary          ",
+    "FS: start transactions                    ",
+    "Journal: start transactions (journal only)",
+    "FS: queue operation for execution         ",
+    "FS: end transaction                       ",
+    "FS: start transactions (FS only)          ",
+    "FS: write to FS finished                  ",
+    "FS: end transactions (FS only)            ",
+    "PG: op locally applied                    ",
+    "PG: op locally committed                  ",
+    "PG: do_pg_op commit                       ",
+    "PG: send write commit to client           ",
+    "PG: send read commit to client            ",
+    "PG: send ack to client                    ",
+    "operation finished                        ",
+    "ITX_MAX_CHECKPOINT"
+  };
+
+class checkpoint_key {
+public:
+	  string	oid;
+	  unsigned	offset;
+	  unsigned	len;
+public:
+	  checkpoint_key(string s, unsigned off, unsigned len):
+		  oid(s),
+		  offset(off),
+		  len(len)
+	  { }
+	  checkpoint_key(string s):
+		  oid(s)
+	  {
+		  offset = 0;
+		  len = 0;
+	  }
+	  ~checkpoint_key() {};
+
+
+};
+
+namespace __gnu_cxx		// hash function is part of the same namespace as hash_map
+{
+    template<> struct hash< const checkpoint_key >
+    {
+        size_t operator()( const checkpoint_key& x ) const
+        {
+        	  ostringstream os;
+        	  os << x.oid << "+" << x.offset << "+" << x.len;
+        	  return hash< const char* >()( os.str().c_str());
+        }
+    };
+}
+
+inline bool operator==(const checkpoint_key &s1, const checkpoint_key &s2)
+{
+	return ((strcmp(s1.oid.c_str(), s2.oid.c_str()) == 0) &&
+			(s1.offset == s2.offset) &&
+			(s1.len == s2.len));
+}
+
+inline bool operator<(const checkpoint_key &s1, const checkpoint_key &s2)
+{
+	ostringstream os1, os2;
+	os1 << s1.oid << "+" << s1.offset << "+" << s1.len;
+	os2 << s2.oid << "+" << s2.offset << "+" << s2.len;
+	return ( os1.str().c_str() < os2.str().c_str());
+}
+
+namespace std		// hash_map uses std::equal_to; to override: std must be modified
+{
+	template<> struct equal_to< const checkpoint_key >
+    {
+        bool operator()(const checkpoint_key &s1, const checkpoint_key &s2) const
+        {
+            return s1 == s2;
+        }
+    };
+}
+
+class ITX {
+  __u32    start_sec;
+  Mutex *lk;
+  Mutex *tls_lk;
+  boost::regex objectid_filter;
+
+
+  class checkpoint {
+    public:
+      ITX *profile;
+      uint32_t opclass;
+      unsigned data_len;
+      utime_t timestamps[ITX_MAX_CHECKPOINT];
+
+    public:
+      checkpoint(ITX *p)
+      {
+        profile = p;
+        opclass = ITX_OPCLASS_UNKNOWN;
+        data_len = 0;
+        for (int i = 0; i < ITX_MAX_CHECKPOINT; i++) {
+          timestamps[i].tv.tv_sec  = 0;
+          timestamps[i].tv.tv_nsec = 0;
+          // = utime_t();
+        }
+      }
+      ~checkpoint() {};
+
+      void set_timestamp(itx_checkpoint where)
+      {
+	profile->lk->Lock();
+         timestamps[where] = ceph_clock_now(g_ceph_context);
+	profile->lk->Unlock();
+
+      }
+  };
+
+  hash_map<string, checkpoint *>cpsold;
+
+  hash_map<const checkpoint_key, checkpoint *>cps;
+
+  hash_map<uint64_t, list<checkpoint_key> >tls_ids;
+
+  hash_map<string, list<checkpoint *> >cphistoryold;
+
+  hash_map<const checkpoint_key, list<checkpoint *> >cphistory;
+
+public:
+  ITX()
+  {
+
+     struct timeval tv;
+     gettimeofday(&tv, NULL);
+     utime_t n(&tv);
+     start_sec = n.tv.tv_sec;
+     lk = new Mutex("ITX_profile");
+     tls_lk = new Mutex("ITX_profile_tls");
+
+     objectid_filter.assign("__notdefined__", boost::regex_constants::basic);
+  };
+  virtual ~ITX() {};
+
+  void write_checkpoint(string label, uint32_t where, Message *m, utime_t stamp, unsigned data_len);
+  void write_checkpoint(string label, uint32_t where, Message *m, utime_t stamp);
+  void write_checkpoint(string label, uint32_t where, PG *pg, Message *m);
+  void write_checkpoint(string label, uint32_t where, PG *pg, OpRequest *op) {
+    write_checkpoint(label, where, pg, op->request);
+  }
+  void write_checkpoint(string label, uint32_t where, Message *m)    {
+    write_checkpoint(label, where, NULL, m);
+  }
+  void write_checkpoint(string label, uint32_t where, OpRequest *op) {
+    write_checkpoint(label, where, NULL, op->request);
+  }
+  void write_checkpoint(string label, uint32_t where, list<ObjectStore::Transaction *>& tls);
+  void write_checkpoint(string label, uint32_t where, uint64_t op, list<ObjectStore::Transaction*>& tls);
+
+  list<checkpoint_key> write_checkpoint(string label, uint32_t where, ObjectStore::Transaction& t);
+  void write_checkpoint(string label, uint32_t where, coll_t cid, const hobject_t &oid, uint64_t off, size_t len);
+  void write_checkpoint(string label, uint32_t where, uint64_t op);
+
+  void cmd_handler(const std::vector<std::string>& cmd, ostream &out);
+  void handle_get_pending_timestamps(const string key, ostream &out);
+  void handle_get_timestamps(const string key, ostream &out);
+  void handle_get_primary_writes(const string key, ostream &out);
+  void handle_get_secondary_writes(const string key, ostream &out);
+  void handle_get_info(ostream &out);
+  void handle_setfilter(const string &filter) {
+    boost::regex_constants::syntax_option_type flags = boost::regex_constants::basic;
+    objectid_filter.assign(filter, flags);
+  }
+  void handle_get_pending_oids(const string key, ostream &out);
+  void handle_get_oids(const string key, ostream &out);
+  void handle_clear(ostream &out);
+
+private:
+
+
+  void save_timestamp(const checkpoint_key &key, uint32_t where, const uint32_t opclass)
+  {
+	checkpoint *p;
+
+    if (regex_match(key.oid, objectid_filter)) {
+      lk->Lock();
+      if (cps.find(key) == cps.end()) {
+        cps[key] = new checkpoint(this);
+      }
+      p = cps[key];
+      p->timestamps[where] = ceph_clock_now(g_ceph_context);
+      if (p->opclass == ITX_OPCLASS_UNKNOWN) {
+    	  p->opclass = opclass;
+      }
+      if (where == ITX_OP_FINISHED) {
+        if (cphistory.find(key) == cphistory.end()) {
+          cphistory[key] = list<checkpoint *>();
+        }
+        // DEBUG g_ceph_context->_dout << " ITX checkpoint: FINISH: " << where << ", " << oid << std::endl;
+        cphistory[key].push_back(p);
+        cps.erase(key);
+      }
+      lk->Unlock();
+    }
+  }
+
+  void save_timestamp(const checkpoint_key &key, uint32_t where)
+    {
+  	  save_timestamp(key, where, ITX_OPCLASS_UNKNOWN);
+    }
+
+  void set_timestamp(const checkpoint_key &key, uint32_t where, utime_t tstamp)
+  {
+	  set_timestamp(key, where, tstamp, ITX_OPCLASS_UNKNOWN);
+  }
+
+
+  void set_timestamp(const checkpoint_key &key, uint32_t where, utime_t tstamp, const uint32_t opclass)
+  {
+	checkpoint *p;
+    if (regex_match(key.oid, objectid_filter)) {
+      lk->Lock();
+      if (cps.find(key) == cps.end()) {
+        cps[key] = new checkpoint(this);
+      }
+      p = cps[key];
+      p->timestamps[where] = tstamp;
+      if (p->opclass == ITX_OPCLASS_UNKNOWN) {
+    	  p->opclass = opclass;
+      }
+      lk->Unlock();
+    }
+  }
+
+  void set_datalen(const checkpoint_key &key, unsigned data_len)
+  {
+	lk->Lock();
+	if ((data_len != 0) && (cps.find(key) != cps.end())) {
+	  cps[key]->data_len = data_len;
+	}
+	lk->Unlock();
+  }
+
+  bool get_timestamp(const checkpoint_key &key, uint32_t where, utime_t &tstamp)
+  {
+    bool retval = true;
+
+    lk->Lock();
+
+    if (cps.find(key) == cps.end()) {
+      retval = false;
+    }
+
+    if (retval == true) {
+      if (where >= ITX_MAX_CHECKPOINT) {
+        retval = false;
+      }
+    }
+
+    if (retval == true) {
+      tstamp.tv.tv_sec = cps[key]->timestamps[where].tv.tv_sec;
+      tstamp.tv.tv_nsec = cps[key]->timestamps[where].tv.tv_nsec;
+      if ((tstamp.tv.tv_sec == 0) && (tstamp.tv.tv_nsec == 0)) {
+        retval = false;
+      }
+    }
+
+    lk->Unlock();
+    return retval;
+  }
+
+  void save_tls_id(list<checkpoint_key> keys, uint64_t tls_id)
+  {
+    list<checkpoint_key> tmp;
+    hash_map<uint64_t, list<checkpoint_key> >::iterator i;
+
+    tls_lk->Lock();
+    i = tls_ids.find(tls_id);
+    if (i != tls_ids.end()) {
+      tmp = tls_ids[tls_id];
+      tmp.merge(keys);
+      tmp.sort();
+      tmp.unique();
+      tls_ids.erase(i);
+      tls_ids[tls_id] = tmp;
+    } else {
+      tls_ids[tls_id] = keys;
+    }
+    tls_lk->Unlock();
+  }
+
+  void drop_tls_id(uint64_t tls_id)
+  {
+    hash_map<uint64_t, list<checkpoint_key> >::iterator i;
+
+    i = tls_ids.find(tls_id);
+    if (i != tls_ids.end()) {
+      tls_ids.erase(i);
+    }
+  }
+
+  string create_id(string oid, uint64_t offset, uint64_t len);
+  void print_timestamp(int where, utime_t timestamps[], ostream &out);
+  void print_condensed_timestamp(int where, utime_t timestamps[], ostream &out);
+  void print_checkpoint(hash_map<const checkpoint_key, checkpoint *>::iterator p, ostream &out);
+  void print_checkpoint_list(hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl, ostream &out);
+  void print_primary_write_checkpoints(hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl, ostream &out);
+  void print_secondary_write_checkpoints(hash_map<const checkpoint_key, list<checkpoint *> >::iterator pl, ostream &out);
+
+  void get_offset_and_len(vector<OSDOp> ops, uint64_t *off, uint64_t *len);
+  uint32_t get_opclass(const MOSDOp *mm);
+  uint32_t get_opclass(const MOSDSubOp *mm);
+
+};
+
+inline ostream& operator<<(ostream& out, const checkpoint_key& cp_key) {
+  return out << '[' << cp_key.oid << ']' << '+' << cp_key.offset << '+' << cp_key.len;
+}
+
+extern ITX itx_profile;
+
+#endif	/* ITX_H */
--- rpmsrc.old/BUILD/ceph-0.48/./src/common/config_opts.h	2012-06-29 20:08:36.000000000 +0200
+++ rpmsrc/BUILD/ceph-0.48/./src/common/config_opts.h	2012-08-03 09:35:01.000000000 +0200
@@ -68,6 +68,7 @@
 SUBSYS(optracker, 0, 5)
 SUBSYS(objclass, 0, 5)
 SUBSYS(filestore, 1, 5)
+SUBSYS(ITX, 1, 5)
 SUBSYS(journal, 1, 5)
 SUBSYS(ms, 0, 5)
 SUBSYS(mon, 1, 5)

--MP_/eKGJTP+YMNPekxqevHgh26H--
