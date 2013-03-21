From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 11/39] mds: don't delay processing replica buffer in
 slave request
Date: Wed, 20 Mar 2013 21:15:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303202112550.7109@cobra.newdream.net>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-12-git-send-email-zheng.z.yan@intel.com> <7248FC83D26D4AF695C4488C64C660F6@inktank.com> <514A72AD.8090500@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56781 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab3CUEPl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 00:15:41 -0400
In-Reply-To: <514A72AD.8090500@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Thu, 21 Mar 2013, Yan, Zheng wrote:
> On 03/21/2013 05:19 AM, Greg Farnum wrote:
> > On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:
> >> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>
> >> Replicated objects need to be added into the cache immediately
> >>
> >> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> > Why do we need to add them right away? Shouldn't we have a journaled replica if we need it?
> > -Greg
> 
> The issue I encountered is lock action message received, but replicated objects wasn't in the
> cache because slave request was delayed.

This makes sense to me; the add_replica_*() methods that create and push 
replicas of cache objects to other nodes need to always be applied 
immediately, or else the cache coherency falls apart.

There are similar games played between the client and mds with the caps 
protocol, although in that case IIRC there are certain limited 
circumstances where we can delay processing the message.  For mds->mds 
traffic, I don't think that's possible, unless *all* potentially dependent 
traffic is also delayed to preserve ordering and so forth.

[That said, I didn't review the actual patch :)]

sage

> 
> Thanks
> Yan, Zheng
> 
> 
> > 
> > Software Engineer #42 @ http://inktank.com | http://ceph.com
> >> ---
> >> src/mds/MDCache.cc | 12 ++++++++++++
> >> src/mds/MDCache.h | 2 +-
> >> src/mds/MDS.cc | 6 +++---
> >> src/mds/Server.cc | 55 +++++++++++++++++++++++++++++++++++++++---------------
> >> 4 files changed, 56 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> >> index 0f6b842..b668842 100644
> >> --- a/src/mds/MDCache.cc
> >> +++ b/src/mds/MDCache.cc
> >> @@ -7722,6 +7722,18 @@ void MDCache::_find_ino_dir(inodeno_t ino, Context *fin, bufferlist& bl, int r)
> >>
> >> /* ---------------------------- */
> >>
> >> +int MDCache::get_num_client_requests()
> >> +{
> >> + int count = 0;
> >> + for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
> >> + p != active_requests.end();
> >> + ++p) {
> >> + if (p->second->reqid.name.is_client() && !p->second->is_slave())
> >> + count++;
> >> + }
> >> + return count;
> >> +}
> >> +
> >> /* This function takes over the reference to the passed Message */
> >> MDRequest *MDCache::request_start(MClientRequest *req)
> >> {
> >> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
> >> index a9f05c6..4634121 100644
> >> --- a/src/mds/MDCache.h
> >> +++ b/src/mds/MDCache.h
> >> @@ -240,7 +240,7 @@ protected:
> >> hash_map<metareqid_t, MDRequest*> active_requests; 
> >>
> >> public:
> >> - int get_num_active_requests() { return active_requests.size(); }
> >> + int get_num_client_requests();
> >>
> >> MDRequest* request_start(MClientRequest *req);
> >> MDRequest* request_start_slave(metareqid_t rid, __u32 attempt, int by);
> >> diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
> >> index b91dcbd..e99eecc 100644
> >> --- a/src/mds/MDS.cc
> >> +++ b/src/mds/MDS.cc
> >> @@ -1900,9 +1900,9 @@ bool MDS::_dispatch(Message *m)
> >> mdcache->is_open() &&
> >> replay_queue.empty() &&
> >> want_state == MDSMap::STATE_CLIENTREPLAY) {
> >> - dout(10) << " still have " << mdcache->get_num_active_requests()
> >> - << " active replay requests" << dendl;
> >> - if (mdcache->get_num_active_requests() == 0)
> >> + int num_requests = mdcache->get_num_client_requests();
> >> + dout(10) << " still have " << num_requests << " active replay requests" << dendl;
> >> + if (num_requests == 0)
> >> clientreplay_done();
> >> }
> >>
> >> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> >> index 4c4c86b..8e89e4c 100644
> >> --- a/src/mds/Server.cc
> >> +++ b/src/mds/Server.cc
> >> @@ -107,10 +107,8 @@ void Server::dispatch(Message *m)
> >> (m->get_type() == CEPH_MSG_CLIENT_REQUEST &&
> >> (static_cast<MClientRequest*>(m))->is_replay()))) {
> >> // replaying!
> >> - } else if (mds->is_clientreplay() && m->get_type() == MSG_MDS_SLAVE_REQUEST &&
> >> - ((static_cast<MMDSSlaveRequest*>(m))->is_reply() ||
> >> - !mds->mdsmap->is_active(m->get_source().num()))) {
> >> - // slave reply or the master is also in the clientreplay stage
> >> + } else if (m->get_type() == MSG_MDS_SLAVE_REQUEST) {
> >> + // handle_slave_request() will wait if necessary
> >> } else {
> >> dout(3) << "not active yet, waiting" << dendl;
> >> mds->wait_for_active(new C_MDS_RetryMessage(mds, m));
> >> @@ -1291,6 +1289,13 @@ void Server::handle_slave_request(MMDSSlaveRequest *m)
> >> if (m->is_reply())
> >> return handle_slave_request_reply(m);
> >>
> >> + CDentry *straydn = NULL;
> >> + if (m->stray.length() > 0) {
> >> + straydn = mdcache->add_replica_stray(m->stray, from);
> >> + assert(straydn);
> >> + m->stray.clear();
> >> + }
> >> +
> >> // am i a new slave?
> >> MDRequest *mdr = NULL;
> >> if (mdcache->have_request(m->get_reqid())) {
> >> @@ -1326,9 +1331,26 @@ void Server::handle_slave_request(MMDSSlaveRequest *m)
> >> m->put();
> >> return;
> >> }
> >> - mdr = mdcache->request_start_slave(m->get_reqid(), m->get_attempt(), m->get_source().num());
> >> + mdr = mdcache->request_start_slave(m->get_reqid(), m->get_attempt(), from);
> >> }
> >> assert(mdr->slave_request == 0); // only one at a time, please! 
> >> +
> >> + if (straydn) {
> >> + mdr->pin(straydn);
> >> + mdr->straydn = straydn;
> >> + }
> >> +
> >> + if (!mds->is_clientreplay() && !mds->is_active() && !mds->is_stopping()) {
> >> + dout(3) << "not clientreplay|active yet, waiting" << dendl;
> >> + mds->wait_for_replay(new C_MDS_RetryMessage(mds, m));
> >> + return;
> >> + } else if (mds->is_clientreplay() && !mds->mdsmap->is_clientreplay(from) &&
> >> + mdr->locks.empty()) {
> >> + dout(3) << "not active yet, waiting" << dendl;
> >> + mds->wait_for_active(new C_MDS_RetryMessage(mds, m));
> >> + return;
> >> + }
> >> +
> >> mdr->slave_request = m;
> >>
> >> dispatch_slave_request(mdr);
> >> @@ -1339,6 +1361,12 @@ void Server::handle_slave_request_reply(MMDSSlaveRequest *m)
> >> {
> >> int from = m->get_source().num();
> >>
> >> + if (!mds->is_clientreplay() && !mds->is_active() && !mds->is_stopping()) {
> >> + dout(3) << "not clientreplay|active yet, waiting" << dendl;
> >> + mds->wait_for_replay(new C_MDS_RetryMessage(mds, m));
> >> + return;
> >> + }
> >> +
> >> if (m->get_op() == MMDSSlaveRequest::OP_COMMITTED) {
> >> metareqid_t r = m->get_reqid();
> >> mds->mdcache->committed_master_slave(r, from);
> >> @@ -5138,10 +5166,8 @@ void Server::handle_slave_rmdir_prep(MDRequest *mdr)
> >> dout(10) << " dn " << *dn << dendl;
> >> mdr->pin(dn);
> >>
> >> - assert(mdr->slave_request->stray.length() > 0);
> >> - CDentry *straydn = mdcache->add_replica_stray(mdr->slave_request->stray, mdr->slave_to_mds);
> >> - assert(straydn);
> >> - mdr->pin(straydn);
> >> + assert(mdr->straydn);
> >> + CDentry *straydn = mdr->straydn;
> >> dout(10) << " straydn " << *straydn << dendl;
> >>
> >> mdr->now = mdr->slave_request->now;
> >> @@ -5208,6 +5234,7 @@ void Server::_logged_slave_rmdir(MDRequest *mdr, CDentry *dn, CDentry *straydn)
> >> // done.
> >> mdr->slave_request->put();
> >> mdr->slave_request = 0;
> >> + mdr->straydn = 0;
> >> }
> >>
> >> void Server::handle_slave_rmdir_prep_ack(MDRequest *mdr, MMDSSlaveRequest *ack)
> >> @@ -6460,15 +6487,12 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
> >> // stray?
> >> bool linkmerge = (srcdnl->get_inode() == destdnl->get_inode() &&
> >> (srcdnl->is_primary() || destdnl->is_primary()));
> >> - CDentry *straydn = 0;
> >> - if (destdnl->is_primary() && !linkmerge) {
> >> - assert(mdr->slave_request->stray.length() > 0);
> >> - straydn = mdcache->add_replica_stray(mdr->slave_request->stray, mdr->slave_to_mds);
> >> + CDentry *straydn = mdr->straydn;
> >> + if (destdnl->is_primary() && !linkmerge)
> >> assert(straydn);
> >> - mdr->pin(straydn);
> >> - }
> >>
> >> mdr->now = mdr->slave_request->now;
> >> + mdr->more()->srcdn_auth_mds = srcdn->authority().first;
> >>
> >> // set up commit waiter (early, to clean up any freezing etc we do)
> >> if (!mdr->more()->slave_commit)
> >> @@ -6651,6 +6675,7 @@ void Server::_logged_slave_rename(MDRequest *mdr,
> >> // done.
> >> mdr->slave_request->put();
> >> mdr->slave_request = 0;
> >> + mdr->straydn = 0;
> >> }
> >>
> >> void Server::_commit_slave_rename(MDRequest *mdr, int r,
> >> -- 
> >> 1.7.11.7
> > 
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
