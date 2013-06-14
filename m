From: Sergey Fionov <fionov@gmail.com>
Subject: PG recovery throttling and queue processing optimizations
Date: Fri, 14 Jun 2013 18:08:23 +0400
Message-ID: <1371218903-8556-1-git-send-email-fionov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:38900 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab3FNOIs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 10:08:48 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so632959lbh.9
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 07:08:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sergey Fionov <fionov@gmail.com>, igor@lukyanov.org, andrey@xdel.ru

Hello!

I would like to present our optimizations for Ceph, such as priority-based
recovery throttling and OSD op queue processing optimizations.

I would also like to see your comments on this patch.
Ideas from this patch may be useful for real optimizations.
The patch is for latest cuttlefish.

This patch includes two things:

1. Recovery throttling and reordering based on OSD load.
2. Optimization of OpWQ processing.


First of all variables are calculated: PG cost, OSD average load and
"prioritized recovery" flag for PG.
OSD average load is calculated as geometric mean of PG costs.
PG cost and PG prioritized recovery flag is set calculate_pg_cost() function.
Client and high priority ops increases PG cost and trigger setting of
priority flag while backfills decreases.

1. Recovery throttling and reordering based on OSD load.
We insert pauses after every recovery operation. From 0.1 to 5.3 seconds,
depending on PG load and the fact if current recovering PG is have high
priority.
The formula is:
throttle = pg_recovery_prio ? 0.1 : 0.3 + osd_average_load * throttle_coef

At first PGs with recovery priority flag set are recovered and then
another PGs.

2. Optimization of OpWQ processing.
While using "bobtail" release we noticed that ceph spends many time on
waiting for pg.lock(). So we modified OpWQ dequeuing and processing code to
try to handle ops for another PGs if current pg is already locked.

To achieve this goal we move all incoming ops to "pg_for_processing" map,
and process PGs not in incoming order but in descendent order of PG costs,
skipping locked PGs.

So op threads will never wait for pg to be unlocked if there are another PGs to
process.


With part 1 recovery process does not affect most client operations anymore.
Part 2 increased efficiency of op queue processing that affected disk I/O
utilization. It gave a great effect on the "bobtail" release, and a small
improvement on the "cuttlefish".

Any comments are welcome.


Thanks,
Sergey.

---

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index d7684a4..d87b6ed 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -390,6 +390,9 @@ OPTION(osd_op_pq_min_cost, OPT_U64, 65536)
 OPTION(osd_disk_threads, OPT_INT, 1)
 OPTION(osd_recovery_threads, OPT_INT, 1)
 OPTION(osd_recover_clone_overlap, OPT_BOOL, true)   // preserve clone_overlap during recovery/migration
+OPTION(osd_recovery_throttle, OPT_FLOAT, 0.3)
+OPTION(osd_recovery_throttle_active, OPT_FLOAT, 0.1)
+OPTION(osd_recovery_throttle_coef, OPT_FLOAT, 0.08)
 OPTION(osd_backfill_scan_min, OPT_INT, 64)
 OPTION(osd_backfill_scan_max, OPT_INT, 512)
 OPTION(osd_op_thread_timeout, OPT_INT, 15)
diff --git a/src/include/xlist.h b/src/include/xlist.h
index 5384561..50de9b1 100644
--- a/src/include/xlist.h
+++ b/src/include/xlist.h
@@ -150,6 +150,7 @@ public:
   public:
     iterator(item *i = 0) : cur(i) {}
     T operator*() { return static_cast<T>(cur->_item); }
+    item *get_cur() { return cur; }
     iterator& operator++() {
       assert(cur);
       assert(cur->_list);
@@ -161,6 +162,9 @@ public:
 
   iterator begin() { return iterator(_front); }
   iterator end() { return iterator(NULL); }
+  void remove(iterator i) {
+      remove(i.get_cur());
+  }
 };
 
 
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 91c214d..bbd8dd7 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -870,6 +870,10 @@ OSD::OSD(int id, Messenger *internal_messenger, Messenger *external_messenger,
 	 Messenger *hbclientm, Messenger *hbserverm, MonClient *mc,
 	 const std::string &dev, const std::string &jdev) :
   Dispatcher(external_messenger->cct),
+  pg_load(0.0),
+  m_osd_recovery_throttle(g_conf->osd_recovery_throttle),
+  m_osd_recovery_throttle_active(g_conf->osd_recovery_throttle_active),
+  m_osd_recovery_throttle_coef(g_conf->osd_recovery_throttle_coef),
   osd_lock("OSD::osd_lock"),
   tick_timer(external_messenger->cct, osd_lock),
   authorize_handler_cluster_registry(new AuthAuthorizeHandlerRegistry(external_messenger->cct,
@@ -6421,6 +6425,62 @@ void OSD::enqueue_op(PG *pg, OpRequestRef op)
   op_wq.queue(make_pair(PGRef(pg), op));
 }
 
+void OSD::OpWQ::_calculate_pg_cost(PGRef pg) {
+    assert(qlock.is_locked());
+    int cost = 0;
+    if (pg == NULL) return;
+    pg->recovery_prio = false;
+    if (pg_for_processing.count(&*pg)) {
+        for (list<OpRequestRef>::iterator i = pg_for_processing[&*pg].begin(); i != pg_for_processing[&*pg].end(); i++) {
+            OpRequestRef op = *i;
+            if (op->request->get_type() == CEPH_MSG_OSD_OP ||
+                    op->request->get_type() == CEPH_MSG_OSD_OPREPLY ||
+                    op->request->get_type() == MSG_OSD_SUBOP ||
+                    op->request->get_type() == MSG_OSD_SUBOPREPLY) {
+                pg->recovery_prio = true;
+            }
+        }
+        for (list<OpRequestRef>::iterator i = pg_for_processing[&*pg].begin(); i != pg_for_processing[&*pg].end(); i++) {
+            OpRequestRef op = *i;
+            if (op->request->get_type() == MSG_OSD_PG_BACKFILL ||
+                    op->request->get_type() == MSG_OSD_PG_SCAN
+                    /* || op->request->op == MOSDPGBackfill::OP_BACKFILL_PROGRESS
+                    || op->request->op == MOSDPGBackfill::OP_BACKFILL_FINISH */) {
+                if (pg->recovery_prio) {
+                    cost += 1000;
+                } else {
+                    cost += 1;
+                }
+            } else {
+                cost += 10 * (op->request->get_priority() - 1) + 1;
+            }
+        }
+    }
+    pg_for_processing_costs[&*pg] = cost;
+}
+
+double OSD::OpWQ::_get_pg_cost(PG* pg) {
+    assert(qlock.is_locked());
+    int sum = pg_for_processing_costs[pg];
+    if (sum > 0 && pg_for_processing.count(pg)) {
+        return (double)pg_for_processing_costs[pg] / pg_for_processing[pg].size();
+    }
+    return 0.0;
+}
+
+double OSD::pg_cost(PG *pg)
+{
+    Mutex::Locker l(op_wq.qlock);
+    return op_wq._get_pg_cost(pg);
+}
+
+void OSD::OpWQ::_push_pg(PGRef pg) {
+    assert(qlock.is_locked());
+    assert(pg.get() != NULL);
+    _calculate_pg_cost(pg);
+    pg_for_processing_queue.push(&*pg);
+}
+
 void OSD::OpWQ::_enqueue(pair<PGRef, OpRequestRef> item)
 {
   unsigned priority = item.second->request->get_priority();
@@ -6432,6 +6492,11 @@ void OSD::OpWQ::_enqueue(pair<PGRef, OpRequestRef> item)
   else
     pqueue.enqueue(item.second->request->get_source_inst(),
       priority, cost, item);
+  {
+      Mutex::Locker l(qlock);
+      _calculate_pg_cost(&*(item.first));
+      _push_pg(item.first);
+  }
   osd->logger->set(l_osd_opq, pqueue.length());
 }
 
@@ -6454,41 +6519,144 @@ void OSD::OpWQ::_enqueue_front(pair<PGRef, OpRequestRef> item)
   else
     pqueue.enqueue_front(item.second->request->get_source_inst(),
       priority, cost, item);
+  {
+      Mutex::Locker l(qlock);
+      _calculate_pg_cost(&*(item.first));
+      _push_pg(item.first);
+  }
   osd->logger->set(l_osd_opq, pqueue.length());
 }
 
 PGRef OSD::OpWQ::_dequeue()
 {
-  assert(!pqueue.empty());
+  static unsigned int order = 0;
+  ++order;
+  //assert(!_empty());
   PGRef pg;
+  unsigned int sum = 0;
   {
     Mutex::Locker l(qlock);
-    pair<PGRef, OpRequestRef> ret = pqueue.dequeue();
-    pg = ret.first;
-    pg_for_processing[&*pg].push_back(ret.second);
+#undef dout_prefix
+#define dout_prefix *_dout
+    dout(10) << "MAP_SIZE: pg_for_processing=" << pg_for_processing.size() << "; pfp_queue=" << pg_for_processing_queue.size() << "; pqueue=" << pqueue.length() << dendl;
+    if (!pg_for_processing_queue.empty()) {
+        while (pg.get() == NULL && !pg_for_processing_queue.empty()) {
+            PG* top = pg_for_processing_queue.top();
+            pg_for_processing_queue.pop();
+            if (top != NULL) {
+                // check if usable
+                if (pg_for_processing.count(top)) {
+                    if (!top->is_locked()) {
+                        pg = top;
+                    } else {
+                        pg_for_processing_postponed.insert(top);
+                    }
+                }
+            }
+        }
+    } else if (pqueue.empty() && pg_for_processing.size()) {
+        unsigned int j = 0;
+        for (map<PG*, list<OpRequestRef> >::iterator i = pg_for_processing.begin(); i != pg_for_processing.end(); i++, j++) {
+            if (j == order % pg_for_processing.size()) {
+                if (!i->first->is_locked()) {
+                    pg = i->first;
+                }
+                break;
+            }
+        }
+    }
+    else {
+        // do nothing
+    }
+
+    while (!pqueue.empty()) {
+        pair<PGRef, OpRequestRef> ret = pqueue.dequeue();
+        pg_for_processing[&*(ret.first)].push_back(ret.second);
+        if (pg.get() == NULL) {
+            pg = ret.first;
+        } else {
+            if (pg_for_processing_postponed.find(ret.first) == pg_for_processing_postponed.end()) {
+                _push_pg(ret.first);
+            }
+        }
+    }
+
+    double geom = 1.0;
+    for (map<PG*, list<OpRequestRef> >::iterator i = pg_for_processing.begin(); i != pg_for_processing.end(); i++) {
+        sum += i->second.size();
+        geom *= i->second.size();
+    }
+    osd->pg_load = ::pow(geom, 1.0 / (pg_for_processing.size() + 1.0)) * pg_for_processing.size();
   }
   osd->logger->set(l_osd_opq, pqueue.length());
+  dout(10) << "pg is " << pg.get() << dendl;
+#undef dout_prefix
+#define dout_prefix _prefix(_dout, whoami, get_osdmap())
+  if (pg.get() == NULL) {
+      Cond cond;
+      Mutex mutex("OSD::OpWQ::_process_throttle");
+      mutex.Lock();
+      cond.WaitInterval(g_ceph_context, mutex, utime_t(0, 5000ul));
+      mutex.Unlock();
+  }
   return pg;
 }
 
 void OSD::OpWQ::_process(PGRef pg)
 {
-  pg->lock();
-  OpRequestRef op;
-  {
-    Mutex::Locker l(qlock);
-    if (!pg_for_processing.count(&*pg)) {
+#undef dout_prefix
+#define dout_prefix *_dout
+  utime_t start = ceph_clock_now(g_ceph_context);
+  dout(10) << "start dequeue op from pg " << pg << "; pqueue len=" << osd->logger->get(l_osd_opq) << dendl;
+  bool locked = false;
+  if (pg.get() != NULL) {
+      locked = pg->try_lock();
+  }
+  if (locked) {
+      OpRequestRef op;
+      {
+        Mutex::Locker l(qlock);
+        if (!pg_for_processing.count(&*pg)) {
+          pg->unlock();
+          return;
+        }
+        assert(pg_for_processing[&*pg].size());
+        op = pg_for_processing[&*pg].front();
+        pg_for_processing[&*pg].pop_front();
+        if (!(pg_for_processing[&*pg].size())) {
+          pg_for_processing.erase(&*pg);
+          pg->recovery_prio_lock.Lock();
+          pg->recovery_prio = false;
+          pg->recovery_prio_lock.Unlock();
+        } else
+          pg_for_processing_postponed.insert(pg);
+      }
+      osd->dequeue_op(pg, op);
+      {
+          Mutex::Locker l(qlock);
+          if (pg_for_processing_postponed.find(pg) != pg_for_processing_postponed.end()) {
+              _push_pg(pg);
+              /*if (find(pg_for_processing_list.begin(), pg_for_processing_list.end(), pg) != pg_for_processing_list.end())
+                pg_for_processing_list.push_back(pg); */
+              pg_for_processing_postponed.erase(pg);
+          }
+      }
       pg->unlock();
-      return;
-    }
-    assert(pg_for_processing[&*pg].size());
-    op = pg_for_processing[&*pg].front();
-    pg_for_processing[&*pg].pop_front();
-    if (!(pg_for_processing[&*pg].size()))
-      pg_for_processing.erase(&*pg);
+  } else {
+      {
+        Mutex::Locker l(qlock);
+        if (pg.get() != NULL) {
+/*            list<PGRef>::iterator pgpos = find(pg_for_processing_list.begin(), pg_for_processing_list.end(), pg);
+            if (pgpos != pg_for_processing_list.end())
+              pg_for_processing_list.erase(pgpos); */
+            pg_for_processing_postponed.insert(pg);
+        }
+      }
   }
-  osd->dequeue_op(pg, op);
-  pg->unlock();
+  utime_t stop = ceph_clock_now(g_ceph_context);
+  dout(10) << "stop dequeue op from pg " << pg << ". operation took " << (stop-start) << " seconds" << dendl;
+#undef dout_prefix
+#define dout_prefix _prefix(_dout, whoami, get_osdmap())
 }
 
 
@@ -6556,6 +6724,8 @@ void OSD::process_peering_events(
   ThreadPool::TPHandle &handle
   )
 {
+  dout(10) << "process_peering_events start size=" << pgs.size() << dendl;
+  utime_t start = ceph_clock_now(g_ceph_context);
   bool need_up_thru = false;
   epoch_t same_interval_since = 0;
   OSDMapRef curmap = service.get_osdmap();
@@ -6566,6 +6736,8 @@ void OSD::process_peering_events(
     set<boost::intrusive_ptr<PG> > split_pgs;
     PG *pg = *i;
     pg->lock();
+    utime_t start_pg = ceph_clock_now(g_ceph_context);
+    dout(10) << "process_peering_events pg=" << pg->get_pgid() << " start" << dendl;
     curmap = service.get_osdmap();
     if (pg->deleting) {
       pg->unlock();
@@ -6591,6 +6763,7 @@ void OSD::process_peering_events(
     } else {
       dispatch_context_transaction(rctx, pg);
     }
+    dout(10) << "process_peering_events pg=" << pg->get_pgid() << " took " << (double)(ceph_clock_now(g_ceph_context) - start_pg) << dendl;
     pg->unlock();
     handle.reset_tp_timeout();
   }
@@ -6599,6 +6772,7 @@ void OSD::process_peering_events(
   dispatch_context(rctx, 0, curmap);
 
   service.send_pg_temp();
+  dout(10) << "process_peering_events " << pgs.size() << " took " << (double)(ceph_clock_now(g_ceph_context) - start) << dendl;
 }
 
 // --------------------------------
@@ -6607,6 +6781,9 @@ const char** OSD::get_tracked_conf_keys() const
 {
   static const char* KEYS[] = {
     "osd_max_backfills",
+    "osd_recovery_throttle",
+    "osd_recovery_throttle_active",
+    "osd_recovery_throttle_coef",
     NULL
   };
   return KEYS;
@@ -6619,6 +6796,13 @@ void OSD::handle_conf_change(const struct md_config_t *conf,
     service.local_reserver.set_max(g_conf->osd_max_backfills);
     service.remote_reserver.set_max(g_conf->osd_max_backfills);
   }
+  if (changed.count("osd_recovery_throttle") ||
+      changed.count("osd_recovery_throttle_active") ||
+      changed.count("osd_recovery_throttle_coef")) {
+    m_osd_recovery_throttle = conf->osd_recovery_throttle;
+    m_osd_recovery_throttle_active = conf->osd_recovery_throttle_active;
+    m_osd_recovery_throttle_coef = conf->osd_recovery_throttle_coef;
+  }
 }
 
 // --------------------------------
@@ -6694,3 +6878,59 @@ int OSD::init_op_flags(OpRequestRef op)
 
   return 0;
 }
+
+/*---------------------------------------------------*/
+#undef dout_prefix
+#define dout_prefix (*_dout << " recovery_wq ")
+PG* OSD::RecoveryWQ::_dequeue() {
+    if (osd->recovery_queue.empty())
+        return NULL;
+
+    if (!osd->_recover_now())
+        return NULL;
+
+    PG *pg = NULL;
+    for (xlist<PG*>::iterator i = osd->recovery_queue.begin(); !i.end(); ++i) {
+        if ((*i)->recovery_prio) {
+            pg = *i;
+            osd->recovery_queue.remove(i); // invalidates i !
+            break;
+        }
+    }
+    if (pg == NULL) {
+        pg = osd->recovery_queue.front();
+        osd->recovery_queue.pop_front();
+    }
+    return pg;
+}
+
+void OSD::RecoveryWQ::_process(PG *pg, ThreadPool::TPHandle &handle) {
+  dout(10) << "STARTREC " << pg << " recovery_wq=" << osd->recovery_queue.size() << "; pg_load=" << osd->pg_load << dendl;
+
+  double loadd = 0;
+  double cur_load = osd->pg_load;
+  if (cur_load >= 1.0) cur_load -= 1.0;
+  double throttle_coef = osd->m_osd_recovery_throttle_coef;
+  double loadfrac = modf(cur_load * throttle_coef, &loadd);
+  int load = (int)loadd;
+  if (load < 0) load = 0;
+  if (load > 5) load = 5;
+
+  osd->do_recovery(pg);
+  pg->put("RecoveryWQ");
+  dout(10) << "ENDREC " << pg << dendl;
+  Mutex lock("RecWQ::process");
+  Cond cond;
+  lock.Lock();
+  unsigned long wait_time = 1.0e9 * osd->m_osd_recovery_throttle;
+  if (pg->recovery_prio) {
+      wait_time = 1.0e9 * osd->m_osd_recovery_throttle_active;
+  }
+  wait_time += 1.0e9 * loadfrac;
+
+  handle.reset_tp_timeout();
+  dout(10) << "WAITREC " << load << "," << wait_time << dendl;
+  cond.WaitInterval(g_ceph_context, lock, utime_t(load, wait_time));
+  lock.Unlock();
+  handle.reset_tp_timeout();
+}
diff --git a/src/osd/OSD.h b/src/osd/OSD.h
index ac2c634..a557558 100644
--- a/src/osd/OSD.h
+++ b/src/osd/OSD.h
@@ -15,6 +15,10 @@
 #ifndef CEPH_OSD_H
 #define CEPH_OSD_H
 
+#include "boost/heap/priority_queue.hpp"
+#undef _ASSERT_H
+#define _ASSERT_H _dout_cct
+
 #include "boost/tuple/tuple.hpp"
 
 #include "PG.h"
@@ -482,6 +486,11 @@ public:
   virtual const char** get_tracked_conf_keys() const;
   virtual void handle_conf_change(const struct md_config_t *conf,
 				  const std::set <std::string> &changed);
+  double pg_cost(PG* pg);
+  double pg_load;
+  double m_osd_recovery_throttle;
+  double m_osd_recovery_throttle_active;
+  double m_osd_recovery_throttle_coef;
 
 protected:
   Mutex osd_lock;			// global lock
@@ -735,12 +744,23 @@ private:
 					       PGRef > {
     Mutex qlock;
     map<PG*, list<OpRequestRef> > pg_for_processing;
+    map<PG*, double> pg_for_processing_costs;
+    struct compare_costs {
+        OpWQ *parent;
+        compare_costs(OpWQ *wq) : parent(wq) {}
+        bool operator()(PG* const a, PG* const b) const {
+            return parent->pg_for_processing_costs[&*a] < parent->pg_for_processing_costs[&*b];
+        }
+    };
+    boost::heap::priority_queue<PG*, boost::heap::compare<compare_costs> > pg_for_processing_queue;
+    set<PGRef> pg_for_processing_postponed;
     OSD *osd;
     PrioritizedQueue<pair<PGRef, OpRequestRef>, entity_inst_t > pqueue;
     OpWQ(OSD *o, time_t ti, ThreadPool *tp)
       : ThreadPool::WorkQueueVal<pair<PGRef, OpRequestRef>, PGRef >(
 	"OSD::OpWQ", ti, ti*10, tp),
 	qlock("OpWQ::qlock"),
+    pg_for_processing_queue(compare_costs(this)),
 	osd(o),
 	pqueue(o->cct->_conf->osd_op_pq_max_tokens_per_priority,
 	       o->cct->_conf->osd_op_pq_min_cost)
@@ -751,6 +771,9 @@ private:
       pqueue.dump(f);
     }
 
+    void _calculate_pg_cost(PGRef pg);
+    double _get_pg_cost(PG* pg);
+    void _push_pg(PGRef pg);
     void _enqueue_front(pair<PGRef, OpRequestRef> item);
     void _enqueue(pair<PGRef, OpRequestRef> item);
     PGRef _dequeue();
@@ -785,6 +808,8 @@ private:
       unlock();
     }
     bool _empty() {
+      Mutex::Locker l(qlock);
+      if (pg_for_processing.size()) return false;
       return pqueue.empty();
     }
     void _process(PGRef pg);
@@ -1222,27 +1247,14 @@ protected:
       if (pg->recovery_item.remove_myself())
 	pg->put("RecoveryWQ");
     }
-    PG *_dequeue() {
-      if (osd->recovery_queue.empty())
-	return NULL;
-      
-      if (!osd->_recover_now())
-	return NULL;
-
-      PG *pg = osd->recovery_queue.front();
-      osd->recovery_queue.pop_front();
-      return pg;
-    }
+    PG *_dequeue();
     void _queue_front(PG *pg) {
       if (!pg->recovery_item.is_on_list()) {
 	pg->get("RecoveryWQ");
 	osd->recovery_queue.push_front(&pg->recovery_item);
       }
     }
-    void _process(PG *pg) {
-      osd->do_recovery(pg);
-      pg->put("RecoveryWQ");
-    }
+    void _process(PG *pg, ThreadPool::TPHandle &handle);
     void _clear() {
       while (!osd->recovery_queue.empty()) {
 	PG *pg = osd->recovery_queue.front();
diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index d356597..d8f8cae 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -145,7 +145,7 @@ PG::PG(OSDService *o, OSDMapRef curmap,
   #ifdef PG_DEBUG_REFS
   _ref_id_lock("PG::_ref_id_lock"), _ref_id(0),
   #endif
-  deleting(false), dirty_info(false), dirty_big_info(false), dirty_log(false),
+  deleting(false), recovery_prio(false), recovery_prio_lock("PG::recovery_prio_lock"), dirty_info(false), dirty_big_info(false), dirty_log(false),
   info(p),
   info_struct_v(0),
   coll(p), log_oid(loid), biginfo_oid(ioid),
@@ -194,6 +194,19 @@ void PG::lock(bool no_lockdep)
   dout(30) << "lock" << dendl;
 }
 
+bool PG::try_lock() {
+    if (!_lock.TryLock()) {
+        dout(10) << "pg_try_lock_fail " << this << dendl;
+        return false;
+    } else {
+        assert(!dirty_info);
+        assert(!dirty_log);
+
+        dout(10) << "pg_try_lock " << this << dendl;
+        return true;
+    }
+}
+
 void PG::lock_with_map_lock_held(bool no_lockdep)
 {
   _lock.Lock(no_lockdep);
diff --git a/src/osd/PG.h b/src/osd/PG.h
index 9446334..f833790 100644
--- a/src/osd/PG.h
+++ b/src/osd/PG.h
@@ -413,8 +413,11 @@ protected:
 
 public:
   bool deleting;  // true while in removing or OSD is shutting down
+  bool recovery_prio;
+  Mutex recovery_prio_lock;
 
   void lock(bool no_lockdep = false);
+  bool try_lock();
   void unlock() {
     //generic_dout(0) << this << " " << info.pgid << " unlock" << dendl;
     assert(!dirty_info);
-- 
1.7.10.4

