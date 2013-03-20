From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 14/39] mds: set resolve/rejoin gather MDS set in advance
Date: Wed, 20 Mar 2013 15:09:56 -0700
Message-ID: <CAPYLRzg=Da5TwdMWtwB1pB9+nRMnQOO_4T=bVuoBd3w=S3SfdQ@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-15-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:61168 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3CTWJ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 18:09:59 -0400
Received: by mail-qa0-f45.google.com with SMTP id g10so3418567qah.18
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 15:09:58 -0700 (PDT)
In-Reply-To: <1363531902-24909-15-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> For active MDS, it may receive resolve/resolve message before receiving

resolve/rejoin, maybe?
Other than that,
Reviewed-by: Greg Farnum <greg@inktank.com>

> the mdsmap message that claims the MDS cluster is in resolving/rejoning
> state. So instead of set the gather MDS set when receiving the mdsmap.
> set them in advance when detecting MDS' failure.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 41 +++++++++++++++++++----------------------
>  src/mds/MDCache.h  |  5 ++---
>  2 files changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 73c1d59..69db1dd 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -2432,18 +2432,17 @@ void MDCache::resolve_start()
>      if (rootdir)
>        adjust_subtree_auth(rootdir, CDIR_AUTH_UNKNOWN);
>    }
> +  resolve_gather = recovery_set;
> +  resolve_gather.erase(mds->get_nodeid());
> +  rejoin_gather = resolve_gather;
>  }
>
>  void MDCache::send_resolves()
>  {
> -  // reset resolve state
> -  got_resolve.clear();
> -  other_ambiguous_imports.clear();
> -
>    send_slave_resolves();
>    if (!resolve_ack_gather.empty()) {
>      dout(10) << "send_resolves still waiting for resolve ack from ("
> -             << need_resolve_ack << ")" << dendl;
> +            << resolve_ack_gather << ")" << dendl;
>      return;
>    }
>    if (!need_resolve_rollback.empty()) {
> @@ -2495,7 +2494,7 @@ void MDCache::send_slave_resolves()
>         ++p) {
>      dout(10) << "sending slave resolve to mds." << p->first << dendl;
>      mds->send_message_mds(p->second, p->first);
> -    need_resolve_ack.insert(p->first);
> +    resolve_ack_gather.insert(p->first);
>    }
>  }
>
> @@ -2598,16 +2597,15 @@ void MDCache::handle_mds_failure(int who)
>    recovery_set.erase(mds->get_nodeid());
>    dout(1) << "handle_mds_failure mds." << who << " : recovery peers are " << recovery_set << dendl;
>
> -  // adjust my recovery lists
> -  wants_resolve.erase(who);   // MDS will ask again
> -  got_resolve.erase(who);     // i'll get another.
> +  resolve_gather.insert(who);
>    discard_delayed_resolve(who);
>
> +  rejoin_gather.insert(who);
>    rejoin_sent.erase(who);        // i need to send another
>    rejoin_ack_gather.erase(who);  // i'll need/get another.
>
> -  dout(10) << " wants_resolve " << wants_resolve << dendl;
> -  dout(10) << " got_resolve " << got_resolve << dendl;
> +  dout(10) << " resolve_gather " << resolve_gather << dendl;
> +  dout(10) << " resolve_ack_gather " << resolve_ack_gather << dendl;
>    dout(10) << " rejoin_sent " << rejoin_sent << dendl;
>    dout(10) << " rejoin_gather " << rejoin_gather << dendl;
>    dout(10) << " rejoin_ack_gather " << rejoin_ack_gather << dendl;
> @@ -2788,7 +2786,7 @@ void MDCache::handle_resolve(MMDSResolve *m)
>      return;
>    }
>
> -  if (!need_resolve_ack.empty() || !need_resolve_rollback.empty()) {
> +  if (!resolve_ack_gather.empty() || !need_resolve_rollback.empty()) {
>      dout(10) << "delay processing subtree resolve" << dendl;
>      discard_delayed_resolve(from);
>      delayed_resolve[from] = m;
> @@ -2875,7 +2873,7 @@ void MDCache::handle_resolve(MMDSResolve *m)
>    }
>
>    // did i get them all?
> -  got_resolve.insert(from);
> +  resolve_gather.erase(from);
>
>    maybe_resolve_finish();
>
> @@ -2901,12 +2899,12 @@ void MDCache::discard_delayed_resolve(int who)
>
>  void MDCache::maybe_resolve_finish()
>  {
> -  assert(need_resolve_ack.empty());
> +  assert(resolve_ack_gather.empty());
>    assert(need_resolve_rollback.empty());
>
> -  if (got_resolve != recovery_set) {
> -    dout(10) << "maybe_resolve_finish still waiting for more resolves, got ("
> -            << got_resolve << "), need (" << recovery_set << ")" << dendl;
> +  if (!resolve_gather.empty()) {
> +    dout(10) << "maybe_resolve_finish still waiting for resolves ("
> +            << resolve_gather << ")" << dendl;
>      return;
>    } else {
>      dout(10) << "maybe_resolve_finish got all resolves+resolve_acks, done." << dendl;
> @@ -2926,7 +2924,7 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
>    dout(10) << "handle_resolve_ack " << *ack << " from " << ack->get_source() << dendl;
>    int from = ack->get_source().num();
>
> -  if (!need_resolve_ack.count(from)) {
> +  if (!resolve_ack_gather.count(from)) {
>      ack->put();
>      return;
>    }
> @@ -3001,8 +2999,8 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
>        assert(p->second->slave_to_mds != from);
>    }
>
> -  need_resolve_ack.erase(from);
> -  if (need_resolve_ack.empty() && need_resolve_rollback.empty()) {
> +  resolve_ack_gather.erase(from);
> +  if (resolve_ack_gather.empty() && need_resolve_rollback.empty()) {
>      send_subtree_resolves();
>      process_delayed_resolve();
>    }
> @@ -3069,7 +3067,7 @@ void MDCache::finish_rollback(metareqid_t reqid) {
>    if (mds->is_resolve())
>      finish_uncommitted_slave_update(reqid, need_resolve_rollback[reqid]);
>    need_resolve_rollback.erase(reqid);
> -  if (need_resolve_ack.empty() && need_resolve_rollback.empty()) {
> +  if (resolve_ack_gather.empty() && need_resolve_rollback.empty()) {
>      send_subtree_resolves();
>      process_delayed_resolve();
>    }
> @@ -3417,7 +3415,6 @@ void MDCache::rejoin_send_rejoins()
>      if (*p == mds->get_nodeid())  continue;  // nothing to myself!
>      if (rejoin_sent.count(*p)) continue;     // already sent a rejoin to this node!
>      if (mds->is_rejoin()) {
> -      rejoin_gather.insert(*p);
>        rejoins[*p] = new MMDSCacheRejoin(MMDSCacheRejoin::OP_WEAK);
>        rejoins[*p]->copy_cap_exports(cap_export_bl);
>      } else if (mds->mdsmap->is_rejoin(*p))
> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
> index 10e3dd7..278debf 100644
> --- a/src/mds/MDCache.h
> +++ b/src/mds/MDCache.h
> @@ -329,9 +329,8 @@ protected:
>    friend class ECommitted;
>
>    bool resolves_pending;
> -  set<int> wants_resolve;   // nodes i need to send my resolve to
> -  set<int> got_resolve;     // nodes i got resolves from
> -  set<int> need_resolve_ack;   // nodes i need a resolve_ack from
> +  set<int> resolve_gather;     // nodes i need resolves from
> +  set<int> resolve_ack_gather; // nodes i need a resolve_ack from
>    map<metareqid_t, int> need_resolve_rollback;  // rollbacks i'm writing to the journal
>    map<int, MMDSResolve*> delayed_resolve;
>
> --
> 1.7.11.7
>
