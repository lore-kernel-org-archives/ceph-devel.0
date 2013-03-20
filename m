From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 17/39] mds: send resolve acks after master updates are
 safely logged
Date: Wed, 20 Mar 2013 15:58:04 -0700
Message-ID: <CAPYLRziSrYd1zSk803x9UMKNmDGQ5YmfVpmH-CcLaVgfqU-dCw@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-18-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:54590 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3CTW6F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 18:58:05 -0400
Received: by mail-qe0-f53.google.com with SMTP id cz11so1445612qeb.40
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 15:58:04 -0700 (PDT)
In-Reply-To: <1363531902-24909-18-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 33 +++++++++++++++++++++++++++++----
>  src/mds/MDCache.h  |  7 ++++++-
>  src/mds/Server.cc  |  9 +++++++++
>  src/mds/journal.cc |  2 +-
>  4 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 6853bf1..9b37b1e 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -2177,6 +2177,17 @@ void MDCache::committed_master_slave(metareqid_t r, int from)
>      log_master_commit(r);
>  }
>
> +void MDCache::logged_master_update(metareqid_t reqid)
> +{
> +  dout(10) << "logged_master_update " << reqid << dendl;
> +  assert(uncommitted_masters.count(reqid));
> +  uncommitted_masters[reqid].safe = true;
> +  if (pending_masters.count(reqid)) {
> +    pending_masters.erase(reqid);
> +    if (pending_masters.empty())
> +      process_delayed_resolve();
> +  }
> +}
>
>  /*
>   * The mds could crash after receiving all slaves' commit acknowledgement,
> @@ -2764,8 +2775,23 @@ void MDCache::handle_resolve(MMDSResolve *m)
>      return;
>    }
>
> +  discard_delayed_resolve(from);
> +
>    // ambiguous slave requests?
>    if (!m->slave_requests.empty()) {
> +    for (vector<metareqid_t>::iterator p = m->slave_requests.begin();
> +        p != m->slave_requests.end();
> +        ++p) {
> +      if (uncommitted_masters.count(*p) && !uncommitted_masters[*p].safe)
> +       pending_masters.insert(*p);
> +    }
> +
> +    if (!pending_masters.empty()) {
> +      dout(10) << " still have pending updates, delay processing slave resolve" << dendl;
> +      delayed_resolve[from] = m;
> +      return;
> +    }
> +
>      MMDSResolveAck *ack = new MMDSResolveAck;
>      for (vector<metareqid_t>::iterator p = m->slave_requests.begin();
>          p != m->slave_requests.end();
> @@ -2788,7 +2814,6 @@ void MDCache::handle_resolve(MMDSResolve *m)
>
>    if (!resolve_ack_gather.empty() || !need_resolve_rollback.empty()) {
>      dout(10) << "delay processing subtree resolve" << dendl;
> -    discard_delayed_resolve(from);
>      delayed_resolve[from] = m;
>      return;
>    }
> @@ -2883,10 +2908,10 @@ void MDCache::handle_resolve(MMDSResolve *m)
>  void MDCache::process_delayed_resolve()
>  {
>    dout(10) << "process_delayed_resolve" << dendl;
> -  for (map<int, MMDSResolve *>::iterator p = delayed_resolve.begin();
> -       p != delayed_resolve.end(); ++p)
> +  map<int, MMDSResolve*> tmp;
> +  tmp.swap(delayed_resolve);
> +  for (map<int, MMDSResolve*>::iterator p = tmp.begin(); p != tmp.end(); ++p)
>      handle_resolve(p->second);
> -  delayed_resolve.clear();
>  }
>
>  void MDCache::discard_delayed_resolve(int who)
> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
> index 379f715..8f262b9 100644
> --- a/src/mds/MDCache.h
> +++ b/src/mds/MDCache.h
> @@ -281,14 +281,16 @@ public:
>                                 snapid_t follows=CEPH_NOSNAP);
>
>    // slaves
> -  void add_uncommitted_master(metareqid_t reqid, LogSegment *ls, set<int> &slaves) {
> +  void add_uncommitted_master(metareqid_t reqid, LogSegment *ls, set<int> &slaves, bool safe=false) {
>      uncommitted_masters[reqid].ls = ls;
>      uncommitted_masters[reqid].slaves = slaves;
> +    uncommitted_masters[reqid].safe = safe;
>    }
>    void wait_for_uncommitted_master(metareqid_t reqid, Context *c) {
>      uncommitted_masters[reqid].waiters.push_back(c);
>    }
>    void log_master_commit(metareqid_t reqid);
> +  void logged_master_update(metareqid_t reqid);
>    void _logged_master_commit(metareqid_t reqid, LogSegment *ls, list<Context*> &waiters);
>    void committed_master_slave(metareqid_t r, int from);
>    void finish_committed_masters();
> @@ -320,9 +322,12 @@ protected:
>      set<int> slaves;
>      LogSegment *ls;
>      list<Context*> waiters;
> +    bool safe;
>    };
>    map<metareqid_t, umaster>                 uncommitted_masters;         // master: req -> slave set
>
> +  set<metareqid_t>             pending_masters;
> +
>    //map<metareqid_t, bool>     ambiguous_slave_updates;         // for log trimming.
>    //map<metareqid_t, Context*> waiting_for_slave_update_commit;
>    friend class ESlaveUpdate;
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index 8e89e4c..1330f11 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -4463,6 +4463,9 @@ void Server::_link_remote_finish(MDRequest *mdr, bool inc,
>
>    assert(g_conf->mds_kill_link_at != 3);
>
> +  if (!mdr->more()->witnessed.empty())
> +    mdcache->logged_master_update(mdr->reqid);
> +
>    if (inc) {
>      // link the new dentry
>      dn->pop_projected_linkage();
> @@ -5073,6 +5076,9 @@ void Server::_unlink_local_finish(MDRequest *mdr,
>  {
>    dout(10) << "_unlink_local_finish " << *dn << dendl;
>
> +  if (!mdr->more()->witnessed.empty())
> +    mdcache->logged_master_update(mdr->reqid);
> +
>    // unlink main dentry
>    dn->get_dir()->unlink_inode(dn);
>    dn->pop_projected_linkage();
> @@ -5881,6 +5887,9 @@ void Server::_rename_finish(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDe
>  {
>    dout(10) << "_rename_finish " << *mdr << dendl;
>
> +  if (!mdr->more()->witnessed.empty())
> +    mdcache->logged_master_update(mdr->reqid);
> +
>    // apply
>    _rename_apply(mdr, srcdn, destdn, straydn);
>
> diff --git a/src/mds/journal.cc b/src/mds/journal.cc
> index 3375e40..6475eec 100644
> --- a/src/mds/journal.cc
> +++ b/src/mds/journal.cc
> @@ -1738,7 +1738,7 @@ void EUpdate::replay(MDS *mds)
>      dout(10) << "EUpdate.replay " << reqid << " had slaves, expecting a matching ECommitted" << dendl;
>      _segment->uncommitted_masters.insert(reqid);
>      set<int> slaves;
> -    mds->mdcache->add_uncommitted_master(reqid, _segment, slaves);
> +    mds->mdcache->add_uncommitted_master(reqid, _segment, slaves, true);
>    }
>
>    if (client_map.length()) {
> --
> 1.7.11.7
>
