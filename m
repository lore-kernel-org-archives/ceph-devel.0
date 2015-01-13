From: Sage Weil <sage@newdream.net>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Tue, 13 Jan 2015 06:34:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501130631400.26676@cobra.newdream.net>
References: <54b528bef1f63_1b74f3532c63410@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56357 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbAMOed (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 09:34:33 -0500
In-Reply-To: <54b528bef1f63_1b74f3532c63410@scan.coverity.com.mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zhiqiang.wang@intel.com
Cc: ceph-devel@vger.kernel.org

Hi Zhiqiang,

On Tue, 13 Jan 2015, scan-admin@coverity.com wrote:
> ________________________________________________________________________________________________________
> *** CID 1262557:  Using invalid iterator  (INVALIDATE_ITERATOR)
> /osd/ReplicatedPG.cc: 2071 in ReplicatedPG::cancel_proxy_read_ops(bool)()
> 2065       while (p != proxyread_ops.end()) {
> 2066         cancel_proxy_read((p++)->second);
> 2067       }
> 2068     
> 2069       if (requeue) {
> 2070         for (map<hobject_t, list<OpRequestRef> >::iterator p = in_progress_proxy_reads.begin();
> >>>     CID 1262557:  Using invalid iterator  (INVALIDATE_ITERATOR)
> >>>     Using invalid iterator "p".
> 2071     	p != in_progress_proxy_reads.end(); p++) {
> 2072           list<OpRequestRef>& ls = p->second;
> 2073           dout(10) << __func__ << " " << p->first << " requeuing " << ls.size() << " requests" << dendl;
> 2074           requeue_ops(ls);
> 2075           in_progress_proxy_reads.erase(p);
> 2076         }
> 
> ________________________________________________________________________________________________________
> *** CID 1262558:  Uninitialized scalar field  (UNINIT_CTOR)
> /osd/ReplicatedPG.h: 629 in ReplicatedPG::OpContext::OpContext(std::tr1::shared_ptr<OpRequest>, osd_reqid_t, std::vector<OSDOp, std::allocator<OSDOp>> &, ReplicatedPG*)()
> 623           num_write(0),
> 624           copy_cb(NULL),
> 625           async_read_result(0),
> 626           inflightreads(0),
> 627           lock_to_release(NONE),
> 628           on_finish(NULL),
> >>>     CID 1262558:  Uninitialized scalar field  (UNINIT_CTOR)
> >>>     Non-static class member "ignore_cache" is not initialized in this constructor nor in any functions that it calls.
> 629           release_snapset_obc(false) { }
> 630         void reset_obs(ObjectContextRef obc) {
> 631           new_obs = ObjectState(obc->obs.oi, obc->obs.exists);
> 632           if (obc->ssc) {
> 633     	new_snapset = obc->ssc->snapset;
> 634     	snapset = &obc->ssc->snapset;
> 

Can you review my fix for these?

https://github.com/ceph/ceph/pull/3363

Thanks!
sage
