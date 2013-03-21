From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 27/39] mds: send lock action message when auth MDS is in
 proper state.
Date: Wed, 20 Mar 2013 20:12:03 -0700
Message-ID: <CAPYLRzhj8tQT=VuunAjYWEq0-_Pb9xoLDyVzgNCkN6kKTdChXg@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-28-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:41634 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab3CUDMF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:12:05 -0400
Received: by mail-we0-f180.google.com with SMTP id k14so1936940wer.11
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:12:03 -0700 (PDT)
In-Reply-To: <1363531902-24909-28-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> For rejoining object, don't send lock ACK message because lock states
> are still uncertain. The lock ACK may confuse object's auth MDS and
> trigger assertion.
>
> If object's auth MDS is not active, just skip sending NUDGE, REQRDLOCK
> and REQSCATTER messages. MDCache::handle_mds_recovery() will take care
> of them.
>
> Also defer caps release message until clientreplay or active
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Locker.cc  | 46 ++++++++++++++++++++++++++++++----------------
>  src/mds/MDCache.cc | 13 +++++++++++--
>  2 files changed, 41 insertions(+), 18 deletions(-)
>
> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
> index 28920d4..ece39e3 100644
> --- a/src/mds/Locker.cc
> +++ b/src/mds/Locker.cc
> @@ -658,6 +658,13 @@ void Locker::eval_gather(SimpleLock *lock, bool first, bool *pneed_issue, list<C
>        // replica: tell auth
>        int auth = lock->get_parent()->authority().first;
>
> +      if (lock->get_parent()->is_rejoining() &&
> +         mds->mdsmap->get_state(auth) == MDSMap::STATE_REJOIN) {
> +       dout(7) << "eval_gather finished gather, but still rejoining "
> +               << *lock->get_parent() << dendl;
> +       return;
> +      }
> +
>        if (mds->mdsmap->get_state(auth) >= MDSMap::STATE_REJOIN) {
>         switch (lock->get_state()) {
>         case LOCK_SYNC_LOCK:
> @@ -1050,9 +1057,11 @@ bool Locker::_rdlock_kick(SimpleLock *lock, bool as_anon)
>      } else {
>        // request rdlock state change from auth
>        int auth = lock->get_parent()->authority().first;
> -      dout(10) << "requesting rdlock from auth on "
> -              << *lock << " on " << *lock->get_parent() << dendl;
> -      mds->send_message_mds(new MLock(lock, LOCK_AC_REQRDLOCK, mds->get_nodeid()), auth);
> +      if (mds->mdsmap->is_clientreplay_or_active_or_stopping(auth)) {
> +       dout(10) << "requesting rdlock from auth on "
> +                << *lock << " on " << *lock->get_parent() << dendl;
> +       mds->send_message_mds(new MLock(lock, LOCK_AC_REQRDLOCK, mds->get_nodeid()), auth);
> +      }
>        return false;
>      }
>    }
> @@ -1272,9 +1281,11 @@ bool Locker::wrlock_start(SimpleLock *lock, MDRequest *mut, bool nowait)
>        // replica.
>        // auth should be auth_pinned (see acquire_locks wrlock weird mustpin case).
>        int auth = lock->get_parent()->authority().first;
> -      dout(10) << "requesting scatter from auth on "
> -              << *lock << " on " << *lock->get_parent() << dendl;
> -      mds->send_message_mds(new MLock(lock, LOCK_AC_REQSCATTER, mds->get_nodeid()), auth);
> +      if (mds->mdsmap->is_clientreplay_or_active_or_stopping(auth)) {
> +       dout(10) << "requesting scatter from auth on "
> +                << *lock << " on " << *lock->get_parent() << dendl;
> +       mds->send_message_mds(new MLock(lock, LOCK_AC_REQSCATTER, mds->get_nodeid()), auth);
> +      }
>        break;
>      }
>    }
> @@ -1899,13 +1910,19 @@ void Locker::request_inode_file_caps(CInode *in)
>      }
>
>      int auth = in->authority().first;
> +    if (in->is_rejoining() &&
> +       mds->mdsmap->get_state(auth) == MDSMap::STATE_REJOIN) {
> +      mds->wait_for_active_peer(auth, new C_MDL_RequestInodeFileCaps(this, in));
> +      return;
> +    }
> +
>      dout(7) << "request_inode_file_caps " << ccap_string(wanted)
>              << " was " << ccap_string(in->replica_caps_wanted)
>              << " on " << *in << " to mds." << auth << dendl;
>
>      in->replica_caps_wanted = wanted;
>
> -    if (mds->mdsmap->get_state(auth) >= MDSMap::STATE_REJOIN)
> +    if (mds->mdsmap->is_clientreplay_or_active_or_stopping(auth))
>        mds->send_message_mds(new MInodeFileCaps(in->ino(), in->replica_caps_wanted),
>                             auth);
>    }
> @@ -1924,14 +1941,6 @@ void Locker::handle_inode_file_caps(MInodeFileCaps *m)
>    assert(in);
>    assert(in->is_auth());
>
> -  if (mds->is_rejoin() &&
> -      in->is_rejoining()) {
> -    dout(7) << "handle_inode_file_caps still rejoining " << *in << ", dropping " << *m << dendl;
> -    m->put();
> -    return;
> -  }

This is okay since we catch it in the follow-on functions (I assume
that's why you removed it, to avoid checks at more levels than
necessary), but if you could note that's why in the commit message
it'll prevent anyone else from needing to go check like I did. :)

The code looks good.
Reviewed-by: Greg Farnum <greg@inktank.com>

> -
> -
>    dout(7) << "handle_inode_file_caps replica mds." << from << " wants caps " << ccap_string(m->get_caps()) << " on " << *in << dendl;
>
>    if (m->get_caps())
> @@ -2850,6 +2859,11 @@ void Locker::handle_client_cap_release(MClientCapRelease *m)
>    client_t client = m->get_source().num();
>    dout(10) << "handle_client_cap_release " << *m << dendl;
>
> +  if (!mds->is_clientreplay() && !mds->is_active() && !mds->is_stopping()) {
> +    mds->wait_for_replay(new C_MDS_RetryMessage(mds, m));
> +    return;
> +  }
> +
>    for (vector<ceph_mds_cap_item>::iterator p = m->caps.begin(); p != m->caps.end(); ++p) {
>      inodeno_t ino((uint64_t)p->ino);
>      CInode *in = mdcache->get_inode(ino);
> @@ -3859,7 +3873,7 @@ void Locker::scatter_nudge(ScatterLock *lock, Context *c, bool forcelockchange)
>              << *lock << " on " << *p << dendl;
>      // request unscatter?
>      int auth = lock->get_parent()->authority().first;
> -    if (mds->mdsmap->get_state(auth) >= MDSMap::STATE_ACTIVE)
> +    if (mds->mdsmap->is_clientreplay_or_active_or_stopping(auth))
>        mds->send_message_mds(new MLock(lock, LOCK_AC_NUDGE, mds->get_nodeid()), auth);
>
>      // wait...
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 459b400..973a4d0 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -3321,8 +3321,10 @@ void MDCache::recalc_auth_bits()
>
>    if (root) {
>      root->inode_auth.first = mds->mdsmap->get_root();
> -    if (mds->whoami != root->inode_auth.first)
> +    if (mds->whoami != root->inode_auth.first) {
>        root->state_clear(CInode::STATE_AUTH);
> +      root->state_set(CInode::STATE_REJOINING);
> +    }
>    }
>
>    set<CInode*> subtree_inodes;
> @@ -3336,8 +3338,10 @@ void MDCache::recalc_auth_bits()
>         ++p) {
>
>      CInode *inode = p->first->get_inode();
> -    if (inode->is_mdsdir() && inode->ino() != MDS_INO_MDSDIR(mds->get_nodeid()))
> +    if (inode->is_mdsdir() && inode->ino() != MDS_INO_MDSDIR(mds->get_nodeid())) {
>        inode->state_clear(CInode::STATE_AUTH);
> +      inode->state_set(CInode::STATE_REJOINING);
> +    }
>
>      list<CDir*> dfq;  // dirfrag queue
>      dfq.push_back(p->first);
> @@ -3542,6 +3546,7 @@ void MDCache::rejoin_send_rejoins()
>                                     root->filelock.get_state(),
>                                     root->nestlock.get_state(),
>                                     root->dirfragtreelock.get_state());
> +       root->state_set(CInode::STATE_REJOINING);
>         if (root->is_dirty_scattered()) {
>           dout(10) << " sending scatterlock state on root " << *root << dendl;
>           p->second->add_scatterlock_state(root);
> @@ -3555,6 +3560,7 @@ void MDCache::rejoin_send_rejoins()
>                                     in->filelock.get_state(),
>                                     in->nestlock.get_state(),
>                                     in->dirfragtreelock.get_state());
> +       in->state_set(CInode::STATE_REJOINING);
>        }
>      }
>    }
> @@ -3694,6 +3700,7 @@ void MDCache::rejoin_walk(CDir *dir, MMDSCacheRejoin *rejoin)
>      // STRONG
>      dout(15) << " add_strong_dirfrag " << *dir << dendl;
>      rejoin->add_strong_dirfrag(dir->dirfrag(), dir->get_replica_nonce(), dir->get_dir_rep());
> +    dir->state_set(CDir::STATE_REJOINING);
>
>      for (CDir::map_t::iterator p = dir->items.begin();
>          p != dir->items.end();
> @@ -3707,6 +3714,7 @@ void MDCache::rejoin_walk(CDir *dir, MMDSCacheRejoin *rejoin)
>                                 dnl->is_remote() ? dnl->get_remote_d_type():0,
>                                 dn->get_replica_nonce(),
>                                 dn->lock.get_state());
> +      dn->state_set(CDentry::STATE_REJOINING);
>        if (dnl->is_primary()) {
>         CInode *in = dnl->get_inode();
>         dout(15) << " add_strong_inode " << *in << dendl;
> @@ -3716,6 +3724,7 @@ void MDCache::rejoin_walk(CDir *dir, MMDSCacheRejoin *rejoin)
>                                  in->filelock.get_state(),
>                                  in->nestlock.get_state(),
>                                  in->dirfragtreelock.get_state());
> +       in->state_set(CInode::STATE_REJOINING);
>         in->get_nested_dirfrags(nested);
>         if (in->is_dirty_scattered()) {
>           dout(10) << " sending scatterlock state on " << *in << dendl;
> --
> 1.7.11.7
>
