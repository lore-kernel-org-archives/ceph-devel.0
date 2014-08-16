From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sat, 16 Aug 2014 14:31:11 -0700
Message-ID: <53efcd9fe3234_6122cbf31865e@209.249.196.67.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41841 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934484AbbI1RUZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 13:20:25 -0400
Received: from dc8secmta2.synopsys.com (dc8secmta2.synopsys.com [10.13.218.202])
	by smtprelay.synopsys.com (Postfix) with ESMTP id 10E0610C1580
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:25 -0700 (PDT)
Received: from dc8secmta2.internal.synopsys.com (dc8secmta2.internal.synopsys.com [127.0.0.1])
	by dc8secmta2.internal.synopsys.com (Service) with ESMTP id 04B88A4112
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:25 -0700 (PDT)
Received: from mailhost.synopsys.com (unknown [10.13.184.66])
	by dc8secmta2.internal.synopsys.com (Service) with ESMTP id CECC2A4122
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
	by mailhost.synopsys.com (Postfix) with ESMTP id BF268530
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.internal.synopsys.com [10.0.8.65])
	by mailhost.synopsys.com (Postfix) with ESMTP id B6F5D52F
	for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 10:20:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>


Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 6 of 6 defect(s)


** CID 1019567:  Thread deadlock  (ORDER_REVERSAL)


** CID 1231681:  Thread deadlock  (ORDER_REVERSAL)


** CID 1231682:  Thread deadlock  (ORDER_REVERSAL)


** CID 1231683:  Thread deadlock  (ORDER_REVERSAL)


** CID 1231684:  Thread deadlock  (ORDER_REVERSAL)



** CID 1231685:  Use after free  (USE_AFTER_FREE)



________________________________________________________________________________________________________
*** CID 1019567:  Thread deadlock  (ORDER_REVERSAL)
/osd/OSD.cc: 3689 in OSD::handle_osd_ping(MOSDPing *)()
3683     		  << ", " << debug_heartbeat_drops_remaining[from]
3684     		  << " remaining to drop" << dendl;
3685     	  break;
3686     	}
3687           }
3688     
>>>     CID 1019567:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "is_healthy" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 7 / 14).
3689           if (!cct->get_heartbeat_map()->is_healthy()) {
3690     	dout(10) << "internal heartbeat not healthy, dropping ping request" << dendl;
3691     	break;
3692           }
3693     
3694           Message *r = new MOSDPing(monc->get_fsid(),

________________________________________________________________________________________________________
*** CID 1231681:  Thread deadlock  (ORDER_REVERSAL)
/librados/RadosClient.cc: 111 in librados::RadosClient::lookup_pool(const char *)()
105       int r = wait_for_osdmap();
106       if (r < 0) {
107         lock.Unlock();
108         return r;
109       }
110       int64_t ret = osdmap.lookup_pg_pool_name(name);
>>>     CID 1231681:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "get_write" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 7 / 14).
111       pool_cache_rwl.get_write();
112       lock.Unlock();
113       if (ret < 0) {
114         pool_cache_rwl.unlock();
115         return -ENOENT;
116       }

________________________________________________________________________________________________________
*** CID 1231682:  Thread deadlock  (ORDER_REVERSAL)
/osd/OSD.cc: 2369 in OSD::shutdown()()
2363       service.start_shutdown();
2364     
2365       clear_waiting_sessions();
2366     
2367       // Shutdown PGs
2368       {
>>>     CID 1231682:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "RLocker" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 7 / 14).
2369         RWLock::RLocker l(pg_map_lock);
2370         for (ceph::unordered_map<spg_t, PG*>::iterator p = pg_map.begin();
2371             p != pg_map.end();
2372             ++p) {
2373           dout(20) << " kicking pg " << p->first << dendl;
2374           p->second->lock();

________________________________________________________________________________________________________
*** CID 1231683:  Thread deadlock  (ORDER_REVERSAL)
/client/Client.cc: 372 in Client::init()()
366       client_lock.Unlock();
367       objecter->init_unlocked();
368       client_lock.Lock();
369     
370       objecter->init_locked();
371     
>>>     CID 1231683:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "set_want_keys" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 7 / 14).
372       monclient->set_want_keys(CEPH_ENTITY_TYPE_MDS | CEPH_ENTITY_TYPE_OSD);
373       monclient->sub_want("mdsmap", 0, 0);
374       monclient->sub_want("osdmap", 0, CEPH_SUBSCRIBE_ONETIME);
375       monclient->renew_subs();
376     
377       // logger

________________________________________________________________________________________________________
*** CID 1231684:  Thread deadlock  (ORDER_REVERSAL)
/osd/OSD.h: 2237 in OSD::RepScrubWQ::_process(MOSDRepScrub *, ThreadPool::TPHandle &)()
2231           ThreadPool::TPHandle &handle) {
2232           osd->osd_lock.Lock();
2233           if (osd->is_stopping()) {
2234     	osd->osd_lock.Unlock();
2235     	return;
2236           }
>>>     CID 1231684:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "_have_pg" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 7 / 14).
2237           if (osd->_have_pg(msg->pgid)) {
2238     	PG *pg = osd->_lookup_lock_pg(msg->pgid);
2239     	osd->osd_lock.Unlock();
2240     	pg->replica_scrub(msg, handle);
2241     	msg->put();
2242     	pg->unlock();
/osd/OSD.h: 2238 in OSD::RepScrubWQ::_process(MOSDRepScrub *, ThreadPool::TPHandle &)()
2232           osd->osd_lock.Lock();
2233           if (osd->is_stopping()) {
2234     	osd->osd_lock.Unlock();
2235     	return;
2236           }
2237           if (osd->_have_pg(msg->pgid)) {
>>>     CID 1231684:  Thread deadlock  (ORDER_REVERSAL)
>>>     Calling "_lookup_lock_pg" acquires lock "RWLock.L" while holding lock "Mutex._m" (count: 7 / 14).
2238     	PG *pg = osd->_lookup_lock_pg(msg->pgid);
2239     	osd->osd_lock.Unlock();
2240     	pg->replica_scrub(msg, handle);
2241     	msg->put();
2242     	pg->unlock();
2243           } else {

________________________________________________________________________________________________________
*** CID 1231685:  Use after free  (USE_AFTER_FREE)
/osd/OSD.cc: 6223 in OSD::handle_osd_map(MOSDMap *)()
6217     
6218           if (o->test_flag(CEPH_OSDMAP_FULL))
6219     	last_marked_full = e;
6220           pinned_maps.push_back(add_map(o));
6221     
6222           bufferlist fbl;
>>>     CID 1231685:  Use after free  (USE_AFTER_FREE)
>>>     Calling "encode" dereferences freed pointer "o".
6223           o->encode(fbl);
6224     
6225           hobject_t fulloid = get_osdmap_pobject_name(e);
6226           t.write(coll_t::META_COLL, fulloid, 0, fbl.length(), fbl);
6227           pin_map_bl(e, fbl);
6228           continue;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



