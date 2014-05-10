From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Sat, 10 May 2014 09:03:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405100903510.23460@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1952814067-1399737834=:23460"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43860 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaEJQD4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 May 2014 12:03:56 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 309DE80466
	for <ceph-devel@vger.kernel.org>; Sat, 10 May 2014 09:03:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 00E1680466
	for <ceph-devel@vger.kernel.org>; Sat, 10 May 2014 09:03:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1952814067-1399737834=:23460
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-1952814067-1399737834=:23460
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1405100903511.23460@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 16C6080466
	for <sage@cobra.newdream.net>; Sat, 10 May 2014 02:35:27 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 13FA212097D; Sat, 10 May 2014 02:35:27 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from diehard.dreamhost.com (caiajhbdcbfh.dreamhost.com
	[208.97.132.157])
	by destro.newdream.net (Postfix) with ESMTP id 1281412097C
	for <sage@newdream.net>; Sat, 10 May 2014 02:35:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by diehard.dreamhost.com (Postfix) with ESMTP id 0CD1617BD5D4
	for <sage@newdream.net>; Sat, 10 May 2014 02:35:27 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at diehard.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from connor.dreamhost.com ([208.97.132.17])
	by localhost (diehard.dreamhost.com [208.97.132.157]) (amavisd-new,
	port 10024) with ESMTP id oUice6qz0mNh for <sage@newdream.net>;
	Sat, 10 May 2014 02:35:26 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by connor.dreamhost.com (Postfix) with ESMTP id BE31A2CA8029
	for <sage@newdream.net>; Sat, 10 May 2014 02:35:26 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Sat, 10 May 2014 02:36:46 -0700
Date: Sat, 10 May 2014 02:35:26 -0700
From: scan-admin@coverity.com
Message-ID: <536df2de21f2b_137ae8a06c2933@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 May 2014 09:36:46.0143 (UTC)
	FILETIME=[5C1ADCF0:01CF6C33]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 8 of 8 defect(s)


** CID 717008:  Dereference null return value  (NULL_RETURNS)


** CID 1128417:  Dereference null return value  (NULL_RETURNS)
/mds/MDCache.cc: 9986 in MDCache::handle_discover_reply(MDiscoverReply *)()

** CID 1213580:  Dereference null return value  (NULL_RETURNS)
/osd/OSD.cc: 5150 in OSD::dispatch_op_fast(std::tr1::shared_ptr<OpRequest>, std::tr1::shared_ptr<const OSDMap>)()

** CID 1213581:  Dereference null return value  (NULL_RETURNS)
/osd/OSD.cc: 4944 in OSD::ms_fast_preprocess(Message *)()

** CID 1213582:  Dereference null return value  (NULL_RETURNS)
/osd/Watch.cc: 359 in Watch::discard_state()()

** CID 1213583:  Dereference null return value  (NULL_RETURNS)
/osd/Watch.cc: 321 in Watch::connect(boost::intrusive_ptr<Connection>)()

** CID 1213584:  Thread deadlock  (ORDER_REVERSAL)


** CID 1213585:  Thread deadlock  (ORDER_REVERSAL)



________________________________________________________________________________________________________
*** CID 717008:  Dereference null return value  (NULL_RETURNS)
/osd/ReplicatedPG.cc: 4962 in ReplicatedPG::do_osd_op_effects(ReplicatedPG::OpContext *)()
4956     
4957     void ReplicatedPG::do_osd_op_effects(OpContext *ctx)
4958     {
4959       ConnectionRef conn(ctx->op->get_req()->get_connection());
4960       boost::intrusive_ptr<OSD::Session> session(
4961         (OSD::Session *)conn->get_priv());
>>>     CID 717008:  Dereference null return value  (NULL_RETURNS)
>>>     Dereferencing a pointer that might be null "session" when calling "RefCountedObject::put()".
4962       session->put();  // get_priv() takes a ref, and so does the intrusive_ptr
4963       entity_name_t entity = ctx->reqid.name;
4964     
4965       dout(15) << "do_osd_op_effects on session " << session.get() << dendl;
4966     
4967       for (list<watch_info_t>::iterator i = ctx->watch_connects.begin();

________________________________________________________________________________________________________
*** CID 1128417:  Dereference null return value  (NULL_RETURNS)
/mds/MDCache.cc: 9986 in MDCache::handle_discover_reply(MDiscoverReply *)()
9980         } else {
9981           // note: this can only happen our first way around this loop.
9982           if (p.end() && m->is_flag_error_dn()) {
9983     	fg = cur->pick_dirfrag(m->get_error_dentry());
9984     	curdir = cur->get_dirfrag(fg);
9985           } else
>>>     CID 1128417:  Dereference null return value  (NULL_RETURNS)
>>>     Assigning: "curdir" = null return value from "CInode::get_dirfrag(frag_t)".
9986     	curdir = cur->get_dirfrag(m->get_base_dir_frag());
9987         }
9988     
9989         if (p.end())
9990           break;
9991         

________________________________________________________________________________________________________
*** CID 1213580:  Dereference null return value  (NULL_RETURNS)
/osd/OSD.cc: 5150 in OSD::dispatch_op_fast(std::tr1::shared_ptr<OpRequest>, std::tr1::shared_ptr<const OSDMap>)()
5144         // we're shutting down, so drop the op
5145         return true;
5146       }
5147     
5148       epoch_t msg_epoch(op_required_epoch(op));
5149       if (msg_epoch > osdmap->get_epoch()) {
>>>     CID 1213580:  Dereference null return value  (NULL_RETURNS)
>>>     Assigning: "s" = null return value from "Connection::get_priv()".
5150         Session *s = static_cast<Session*>(op->get_req()->
5151     				       get_connection()->get_priv());
5152         s->received_map_lock.Lock();
5153         epoch_t received_epoch = s->received_map_epoch;
5154         s->received_map_lock.Unlock();
5155         if (received_epoch < msg_epoch) {

________________________________________________________________________________________________________
*** CID 1213581:  Dereference null return value  (NULL_RETURNS)
/osd/OSD.cc: 4944 in OSD::ms_fast_preprocess(Message *)()
4938     
4939     void OSD::ms_fast_preprocess(Message *m)
4940     {
4941       if (m->get_connection()->get_peer_type() == CEPH_ENTITY_TYPE_OSD) {
4942         if (m->get_type() == CEPH_MSG_OSD_MAP) {
4943           MOSDMap *mm = static_cast<MOSDMap*>(m);
>>>     CID 1213581:  Dereference null return value  (NULL_RETURNS)
>>>     Assigning: "s" = null return value from "Connection::get_priv()".
4944           Session *s = static_cast<Session*>(m->get_connection()->get_priv());
4945           s->received_map_lock.Lock();
4946           s->received_map_epoch = mm->get_last();
4947           s->received_map_lock.Unlock();
4948           s->put();
4949         }

________________________________________________________________________________________________________
*** CID 1213582:  Dereference null return value  (NULL_RETURNS)
/osd/Watch.cc: 359 in Watch::discard_state()()
353       assert(!discarded);
354       assert(obc);
355       in_progress_notifies.clear();
356       unregister_cb();
357       discarded = true;
358       if (conn) {
>>>     CID 1213582:  Dereference null return value  (NULL_RETURNS)
>>>     Assigning: "sessionref" = null return value from "Connection::get_priv()".
359         OSD::Session* sessionref(static_cast<OSD::Session*>(conn->get_priv()));
360         sessionref->wstate.removeWatch(self.lock());
361         sessionref->put();
362         conn = ConnectionRef();
363       }
364       obc = ObjectContextRef();

________________________________________________________________________________________________________
*** CID 1213583:  Dereference null return value  (NULL_RETURNS)
/osd/Watch.cc: 321 in Watch::connect(boost::intrusive_ptr<Connection>)()
315     }
316     
317     void Watch::connect(ConnectionRef con)
318     {
319       dout(10) << "connecting" << dendl;
320       conn = con;
>>>     CID 1213583:  Dereference null return value  (NULL_RETURNS)
>>>     Assigning: "sessionref" = null return value from "Connection::get_priv()".
321       OSD::Session* sessionref(static_cast<OSD::Session*>(con->get_priv()));
322       sessionref->wstate.addWatch(self.lock());
323       sessionref->put();
324       for (map<uint64_t, NotifyRef>::iterator i = in_progress_notifies.begin();
325            i != in_progress_notifies.end();
326            ++i) {

________________________________________________________________________________________________________
*** CID 1213584:  Thread deadlock  (ORDER_REVERSAL)
/osd/OSD.cc: 8089 in C_CompleteSplits::finish(int)()
8083         PG::RecoveryCtx rctx = osd->create_context();
8084         set<spg_t> to_complete;
8085         for (set<boost::intrusive_ptr<PG> >::iterator i = pgs.begin();
8086     	 i != pgs.end();
8087     	 ++i) {
8088           osd->pg_map_lock.get_write();
>>>     CID 1213584:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "PG::lock(bool)" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 13).
8089           (*i)->lock();
8090           osd->add_newly_split_pg(&**i, &rctx);
8091           if (!((*i)->deleting)) {
8092             to_complete.insert((*i)->info.pgid);
8093             osd->service.complete_split(to_complete);
8094           }

________________________________________________________________________________________________________
*** CID 1213585:  Thread deadlock  (ORDER_REVERSAL)
/osd/OSD.cc: 7447 in OSD::check_replay_queue()()
7441       replay_queue_lock.Unlock();
7442     
7443       for (list< pair<spg_t,utime_t> >::iterator p = pgids.begin(); p != pgids.end(); ++p) {
7444         spg_t pgid = p->first;
7445         pg_map_lock.get_read();
7446         if (pg_map.count(pgid)) {
>>>     CID 1213585:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "OSD::_lookup_lock_pg_with_map_lock_held(spg_t)" acquires lock "Mutex._m" while holding lock "RWLock.L" (count: 5 / 13).
7447           PG *pg = _lookup_lock_pg_with_map_lock_held(pgid);
7448           pg_map_lock.unlock();
7449           dout(10) << "check_replay_queue " << *pg << dendl;
7450           if (pg->is_active() &&
7451               pg->is_replay() &&
7452               pg->is_primary() &&


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=Overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-1952814067-1399737834=:23460--
