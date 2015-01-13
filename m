From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 13 Jan 2015 06:16:38 -0800
Message-ID: <54b528c6ad39f_1be3f3532c6341a@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:60243 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbbAMOQj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 09:16:39 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1262557:  Using invalid iterator  (INVALIDATE_ITERATOR)
/osd/ReplicatedPG.cc: 2071 in ReplicatedPG::cancel_proxy_read_ops(bool)()

** CID 1262558:  Uninitialized scalar field  (UNINIT_CTOR)
/osd/ReplicatedPG.h: 629 in ReplicatedPG::OpContext::OpContext(std::tr1::shared_ptr<OpRequest>, osd_reqid_t, std::vector<OSDOp, std::allocator<OSDOp>> &, ReplicatedPG*)()


________________________________________________________________________________________________________
*** CID 1262557:  Using invalid iterator  (INVALIDATE_ITERATOR)
/osd/ReplicatedPG.cc: 2071 in ReplicatedPG::cancel_proxy_read_ops(bool)()
2065       while (p != proxyread_ops.end()) {
2066         cancel_proxy_read((p++)->second);
2067       }
2068     
2069       if (requeue) {
2070         for (map<hobject_t, list<OpRequestRef> >::iterator p = in_progress_proxy_reads.begin();
>>>     CID 1262557:  Using invalid iterator  (INVALIDATE_ITERATOR)
>>>     Using invalid iterator "p".
2071     	p != in_progress_proxy_reads.end(); p++) {
2072           list<OpRequestRef>& ls = p->second;
2073           dout(10) << __func__ << " " << p->first << " requeuing " << ls.size() << " requests" << dendl;
2074           requeue_ops(ls);
2075           in_progress_proxy_reads.erase(p);
2076         }

________________________________________________________________________________________________________
*** CID 1262558:  Uninitialized scalar field  (UNINIT_CTOR)
/osd/ReplicatedPG.h: 629 in ReplicatedPG::OpContext::OpContext(std::tr1::shared_ptr<OpRequest>, osd_reqid_t, std::vector<OSDOp, std::allocator<OSDOp>> &, ReplicatedPG*)()
623           num_write(0),
624           copy_cb(NULL),
625           async_read_result(0),
626           inflightreads(0),
627           lock_to_release(NONE),
628           on_finish(NULL),
>>>     CID 1262558:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "ignore_cache" is not initialized in this constructor nor in any functions that it calls.
629           release_snapset_obc(false) { }
630         void reset_obs(ObjectContextRef obc) {
631           new_obs = ObjectState(obc->obs.oi, obc->obs.exists);
632           if (obc->ssc) {
633     	new_snapset = obc->ssc->snapset;
634     	snapset = &obc->ssc->snapset;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

