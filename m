From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 22/39] mds: handle linkage mismatch during cache rejoin
Date: Fri, 29 Mar 2013 15:09:49 -0700
Message-ID: <CAPYLRzhG7yu1fATD013wh4t0Pzr8-8pHhCzRgGmmLYEOboMYNQ@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-23-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRzi5wRLUndEczMbrwjNBTwKwdOvFw=s5bhDNDcncWMxSuQ@mail.gmail.com>
	<51514C65.6010905@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:49969 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756907Ab3C2WJu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 18:09:50 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so736992wgh.25
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 15:09:49 -0700 (PDT)
In-Reply-To: <51514C65.6010905@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Updated version looks good.
Reviewed-by: Greg Farnum <greg@inktank.com>

On Tue, Mar 26, 2013 at 12:21 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> Updated update
>
> Thanks
> Yan, Zheng
> ------
> From c1d3576556f5ad2849d3079845dc26ef7612e8d3 Mon Sep 17 00:00:00 2001
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> Date: Thu, 14 Mar 2013 20:06:27 +0800
> Subject: [PATCH 22/39] mds: handle linkage mismatch during cache rejoin
>
> For MDS cluster, not all file system namespace operations that impact
> multiple MDS use two phase commit. Some operations use dentry link/unlink
> message to update replica dentry's linkage after they are committed by
> the master MDS. It's possible the master MDS crashes after journaling an
> operation, but before sending the dentry link/unlink messages. Later when
> the MDS recovers and receives cache rejoin messages from the surviving
> MDS, it will find linkage mismatch.
>
> The original cache rejoin code does not properly handle the case that
> dentry unlink messages were missing. Unlinked inodes were linked to stray
> dentries. So the cache rejoin ack message need push replicas of these
> stray dentries to the surviving MDS.
>
> This patch also adds code that handles cache expiration in the middle of
> cache rejoining.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 342 +++++++++++++++++++++++++++++++++++------------------
>  src/mds/MDCache.h  |   1 +
>  src/mds/mdstypes.h |   3 +
>  3 files changed, 229 insertions(+), 117 deletions(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 8edb11c..0d2cac1 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -3540,7 +3540,6 @@ void MDCache::rejoin_send_rejoins()
>      } else {
>        // strong
>        if (p->first == 0 && root) {
> -       p->second->add_weak_inode(root->vino());
>         p->second->add_strong_inode(root->vino(),
>                                     root->get_replica_nonce(),
>                                     root->get_caps_wanted(),
> @@ -3554,7 +3553,6 @@ void MDCache::rejoin_send_rejoins()
>        }
>
>        if (CInode *in = get_inode(MDS_INO_MDSDIR(p->first))) {
> -       p->second->add_weak_inode(in->vino());
>         p->second->add_strong_inode(in->vino(),
>                                     in->get_replica_nonce(),
>                                     in->get_caps_wanted(),
> @@ -3571,6 +3569,8 @@ void MDCache::rejoin_send_rejoins()
>      for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
>          p != active_requests.end();
>          ++p) {
> +      if ( p->second->is_slave())
> +       continue;
>        // auth pins
>        for (set<MDSCacheObject*>::iterator q = p->second->remote_auth_pins.begin();
>            q != p->second->remote_auth_pins.end();
> @@ -4230,6 +4230,8 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>      rejoin_potential_updated_scatterlocks.insert(in);
>    }
>
> +  rejoin_unlinked_inodes[from].clear();
> +
>    // surviving peer may send incorrect dirfrag here (maybe they didn't
>    // get the fragment notify, or maybe we rolled back?).  we need to
>    // infer the right frag and get them with the program.  somehow.
> @@ -4336,106 +4338,118 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>
>        dn->add_replica(from, q->second.nonce);
>        dout(10) << " have " << *dn << dendl;
> -
> -      // inode?
> -      if (dnl->is_primary()) {
> -       CInode *in = dnl->get_inode();
> -       assert(in);
> -
> -       if (strong->strong_inodes.count(in->vino())) {
> -         MMDSCacheRejoin::inode_strong &is = strong->strong_inodes[in->vino()];
>
> -         // caps_wanted
> -         if (is.caps_wanted) {
> -           in->mds_caps_wanted[from] = is.caps_wanted;
> -           dout(15) << " inode caps_wanted " << ccap_string(is.caps_wanted)
> -                    << " on " << *in << dendl;
> -         }
> -
> -         // scatterlocks?
> -         //  infer state from replica state:
> -         //   * go to MIX if they might have wrlocks
> -         //   * go to LOCK if they are LOCK (just bc identify_files_to_recover might start twiddling filelock)
> -         in->filelock.infer_state_from_strong_rejoin(is.filelock, true);  // maybe also go to LOCK
> -         in->nestlock.infer_state_from_strong_rejoin(is.nestlock, false);
> -         in->dirfragtreelock.infer_state_from_strong_rejoin(is.dftlock, false);
> -
> -         // auth pin?
> -         if (strong->authpinned_inodes.count(in->vino())) {
> -           MMDSCacheRejoin::slave_reqid r = strong->authpinned_inodes[in->vino()];
> -           dout(10) << " inode authpin by " << r << " on " << *in << dendl;
> -
> -           // get/create slave mdrequest
> -           MDRequest *mdr;
> -           if (have_request(r.reqid))
> -             mdr = request_get(r.reqid);
> -           else
> -             mdr = request_start_slave(r.reqid, r.attempt, from);
> -           if (strong->frozen_authpin_inodes.count(in->vino())) {
> -             assert(!in->get_num_auth_pins());
> -             mdr->freeze_auth_pin(in);
> -           } else {
> -             assert(!in->is_frozen_auth_pin());
> -           }
> -           mdr->auth_pin(in);
> -         }
> -         // xlock(s)?
> -         if (strong->xlocked_inodes.count(in->vino())) {
> -           for (map<int,MMDSCacheRejoin::slave_reqid>::iterator r = strong->xlocked_inodes[in->vino()].begin();
> -                r != strong->xlocked_inodes[in->vino()].end();
> -                ++r) {
> -             SimpleLock *lock = in->get_lock(r->first);
> -             dout(10) << " inode xlock by " << r->second << " on " << *lock << " on " << *in << dendl;
> -             MDRequest *mdr = request_get(r->second.reqid);  // should have this from auth_pin above.
> -             assert(mdr->is_auth_pinned(in));
> -             if (lock->is_stable())
> -               in->auth_pin(lock);
> -             lock->set_state(LOCK_XLOCK);
> -             if (lock == &in->filelock)
> -               in->loner_cap = -1;
> -             lock->get_xlock(mdr, mdr->get_client());
> -             mdr->xlocks.insert(lock);
> -             mdr->locks.insert(lock);
> -           }
> -         }
> -         // wrlock(s)?
> -         if (strong->wrlocked_inodes.count(in->vino())) {
> -           for (map<int,MMDSCacheRejoin::slave_reqid>::iterator r = strong->wrlocked_inodes[in->vino()].begin();
> -                r != strong->wrlocked_inodes[in->vino()].end();
> -                ++r) {
> -             SimpleLock *lock = in->get_lock(r->first);
> -             dout(10) << " inode wrlock by " << r->second << " on " << *lock << " on " << *in << dendl;
> -             MDRequest *mdr = request_get(r->second.reqid);  // should have this from auth_pin above.
> -             assert(mdr->is_auth_pinned(in));
> -             lock->set_state(LOCK_LOCK);
> -             if (lock == &in->filelock)
> -               in->loner_cap = -1;
> -             lock->get_wrlock(true);
> -             mdr->wrlocks.insert(lock);
> -             mdr->locks.insert(lock);
> -           }
> +      if (dnl->is_primary()) {
> +       if (q->second.is_primary()) {
> +         if (vinodeno_t(q->second.ino, q->first.snapid) != dnl->get_inode()->vino()) {
> +           // the survivor missed MDentryUnlink+MDentryLink messages ?
> +           assert(strong->strong_inodes.count(dnl->get_inode()->vino()) == 0);
> +           CInode *in = get_inode(q->second.ino, q->first.snapid);
> +           assert(in);
> +           assert(in->get_parent_dn());
> +           rejoin_unlinked_inodes[from].insert(in);
> +           dout(7) << " sender has primary dentry but wrong inode" << dendl;
>           }
>         } else {
> -         dout(10) << " sender has dentry but not inode, adding them as a replica" << dendl;
> +         // the survivor missed MDentryLink message ?
> +         assert(strong->strong_inodes.count(dnl->get_inode()->vino()) == 0);
> +         dout(7) << " sender doesn't have primay dentry" << dendl;
> +       }
> +      } else {
> +       if (q->second.is_primary()) {
> +         // the survivor missed MDentryUnlink message ?
> +         CInode *in = get_inode(q->second.ino, q->first.snapid);
> +         assert(in);
> +         assert(in->get_parent_dn());
> +         rejoin_unlinked_inodes[from].insert(in);
> +         dout(7) << " sender has primary dentry but we don't" << dendl;
>         }
> -
> -       in->add_replica(from, p->second.nonce);
> -       dout(10) << " have " << *in << dendl;
>        }
>      }
>    }
>
> -  // base inodes?  (root, stray, etc.)
> -  for (set<vinodeno_t>::iterator p = strong->weak_inodes.begin();
> -       p != strong->weak_inodes.end();
> +  for (map<vinodeno_t, MMDSCacheRejoin::inode_strong>::iterator p = strong->strong_inodes.begin();
> +       p != strong->strong_inodes.end();
>         ++p) {
> -    CInode *in = get_inode(*p);
> -    dout(10) << " have base " << *in << dendl;
> -    in->add_replica(from);
> +    CInode *in = get_inode(p->first);
> +    assert(in);
> +    in->add_replica(from, p->second.nonce);
> +    dout(10) << " have " << *in << dendl;
> +
> +    MMDSCacheRejoin::inode_strong &is = p->second;
> +
> +    // caps_wanted
> +    if (is.caps_wanted) {
> +      in->mds_caps_wanted[from] = is.caps_wanted;
> +      dout(15) << " inode caps_wanted " << ccap_string(is.caps_wanted)
> +              << " on " << *in << dendl;
> +    }
> +
> +    // scatterlocks?
> +    //  infer state from replica state:
> +    //   * go to MIX if they might have wrlocks
> +    //   * go to LOCK if they are LOCK (just bc identify_files_to_recover might start twiddling filelock)
> +    in->filelock.infer_state_from_strong_rejoin(is.filelock, true);  // maybe also go to LOCK
> +    in->nestlock.infer_state_from_strong_rejoin(is.nestlock, false);
> +    in->dirfragtreelock.infer_state_from_strong_rejoin(is.dftlock, false);
> +
> +    // auth pin?
> +    if (strong->authpinned_inodes.count(in->vino())) {
> +      MMDSCacheRejoin::slave_reqid r = strong->authpinned_inodes[in->vino()];
> +      dout(10) << " inode authpin by " << r << " on " << *in << dendl;
> +
> +      // get/create slave mdrequest
> +      MDRequest *mdr;
> +      if (have_request(r.reqid))
> +       mdr = request_get(r.reqid);
> +      else
> +       mdr = request_start_slave(r.reqid, r.attempt, from);
> +      if (strong->frozen_authpin_inodes.count(in->vino())) {
> +       assert(!in->get_num_auth_pins());
> +       mdr->freeze_auth_pin(in);
> +      } else {
> +       assert(!in->is_frozen_auth_pin());
> +      }
> +      mdr->auth_pin(in);
> +    }
> +    // xlock(s)?
> +    if (strong->xlocked_inodes.count(in->vino())) {
> +      for (map<int,MMDSCacheRejoin::slave_reqid>::iterator q = strong->xlocked_inodes[in->vino()].begin();
> +          q != strong->xlocked_inodes[in->vino()].end();
> +          ++q) {
> +       SimpleLock *lock = in->get_lock(q->first);
> +       dout(10) << " inode xlock by " << q->second << " on " << *lock << " on " << *in << dendl;
> +       MDRequest *mdr = request_get(q->second.reqid);  // should have this from auth_pin above.
> +       assert(mdr->is_auth_pinned(in));
> +       if (lock->is_stable())
> +         in->auth_pin(lock);
> +       lock->set_state(LOCK_XLOCK);
> +       if (lock == &in->filelock)
> +         in->loner_cap = -1;
> +       lock->get_xlock(mdr, mdr->get_client());
> +       mdr->xlocks.insert(lock);
> +       mdr->locks.insert(lock);
> +      }
> +    }
> +    // wrlock(s)?
> +    if (strong->wrlocked_inodes.count(in->vino())) {
> +      for (map<int,MMDSCacheRejoin::slave_reqid>::iterator q = strong->wrlocked_inodes[in->vino()].begin();
> +          q != strong->wrlocked_inodes[in->vino()].end();
> +          ++q) {
> +       SimpleLock *lock = in->get_lock(q->first);
> +       dout(10) << " inode wrlock by " << q->second << " on " << *lock << " on " << *in << dendl;
> +       MDRequest *mdr = request_get(q->second.reqid);  // should have this from auth_pin above.
> +       assert(mdr->is_auth_pinned(in));
> +       lock->set_state(LOCK_LOCK);
> +       if (lock == &in->filelock)
> +         in->loner_cap = -1;
> +       lock->get_wrlock(true);
> +       mdr->wrlocks.insert(lock);
> +       mdr->locks.insert(lock);
> +      }
> +    }
>    }
>
> -
> -
>    // done?
>    assert(rejoin_gather.count(from));
>    rejoin_gather.erase(from);
> @@ -4452,6 +4466,9 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
>    dout(7) << "handle_cache_rejoin_ack from " << ack->get_source() << dendl;
>    int from = ack->get_source().num();
>
> +  // for sending cache expire message
> +  list<CInode*> isolated_inodes;
> +
>    // dirs
>    for (map<dirfrag_t, MMDSCacheRejoin::dirfrag_strong>::iterator p = ack->strong_dirfrags.begin();
>         p != ack->strong_dirfrags.end();
> @@ -4459,7 +4476,29 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
>      // we may have had incorrect dir fragmentation; refragment based
>      // on what they auth tells us.
>      CDir *dir = get_force_dirfrag(p->first);
> -    assert(dir);
> +    if (!dir) {
> +      CInode *diri = get_inode(p->first.ino);
> +      if (!diri) {
> +       // barebones inode; the full inode loop below will clean up.
> +       diri = new CInode(this, false);
> +       diri->inode.ino = p->first.ino;
> +       diri->inode.mode = S_IFDIR;
> +       if (MDS_INO_MDSDIR(p->first.ino)) {
> +         diri->inode_auth = pair<int,int>(from, CDIR_AUTH_UNKNOWN);
> +         add_inode(diri);
> +         dout(10) << " add inode " << *diri << dendl;
> +       } else {
> +         diri->inode_auth = CDIR_AUTH_UNDEF;
> +         isolated_inodes.push_back(diri);
> +         dout(10) << " unconnected dirfrag " << p->first << dendl;
> +       }
> +      }
> +      // barebones dirfrag; the full dirfrag loop below will clean up.
> +      dir = diri->add_dirfrag(new CDir(diri, p->first.frag, this, false));
> +      if (dir->authority().first != from)
> +       adjust_subtree_auth(dir, from);
> +      dout(10) << " add dirfrag " << *dir << dendl;
> +    }
>
>      dir->set_replica_nonce(p->second.nonce);
>      dir->state_clear(CDir::STATE_REJOINING);
> @@ -4471,7 +4510,9 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
>          q != dmap.end();
>          ++q) {
>        CDentry *dn = dir->lookup(q->first.name, q->first.snapid);
> -      assert(dn);
> +      if(!dn)
> +       dn = dir->add_null_dentry(q->first.name, q->second.first, q->first.snapid);
> +
>        CDentry::linkage_t *dnl = dn->get_linkage();
>
>        assert(dn->last == q->first.snapid);
> @@ -4480,33 +4521,48 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
>         dn->first = q->second.first;
>        }
>
> +      // may have bad linkage if we missed dentry link/unlink messages
> +      if (dnl->is_primary()) {
> +       CInode *in = dnl->get_inode();
> +       if (!q->second.is_primary() ||
> +           vinodeno_t(q->second.ino, q->first.snapid) != in->vino()) {
> +         dout(10) << " had bad linkage for " << *dn << ", unlinking " << *in << dendl;
> +         dir->unlink_inode(dn);
> +       }
> +      } else if (dnl->is_remote()) {
> +       if (!q->second.is_remote() ||
> +           q->second.remote_ino != dnl->get_remote_ino() ||
> +           q->second.remote_d_type != dnl->get_remote_d_type()) {
> +         dout(10) << " had bad linkage for " << *dn <<  dendl;
> +         dir->unlink_inode(dn);
> +       }
> +      } else {
> +       if (!q->second.is_null())
> +         dout(10) << " had bad linkage for " << *dn <<  dendl;
> +      }
> +
>        // hmm, did we have the proper linkage here?
> -      if (dnl->is_null() &&
> -         !q->second.is_null()) {
> -       dout(10) << " had bad (missing) linkage for " << *dn << dendl;
> +      if (dnl->is_null() && !q->second.is_null()) {
>         if (q->second.is_remote()) {
>           dn->dir->link_remote_inode(dn, q->second.remote_ino, q->second.remote_d_type);
>         } else {
>           CInode *in = get_inode(q->second.ino, q->first.snapid);
> -         assert(in == 0);  // a rename would have been caught be the resolve stage.
> -         // barebones inode; the full inode loop below will clean up.
> -         in = new CInode(this, false, q->second.first, q->first.snapid);
> -         in->inode.ino = q->second.ino;
> -         add_inode(in);
> +         if (!in) {
> +           // barebones inode; assume it's dir, the full inode loop below will clean up.
> +           in = new CInode(this, false, q->second.first, q->first.snapid);
> +           in->inode.ino = q->second.ino;
> +           in->inode.mode = S_IFDIR;
> +           add_inode(in);
> +           dout(10) << " add inode " << *in << dendl;
> +         } else if (in->get_parent_dn()) {
> +           dout(10) << " had bad linkage for " << *(in->get_parent_dn())
> +                    << ", unlinking " << *in << dendl;
> +           in->get_parent_dir()->unlink_inode(in->get_parent_dn());
> +         }
>           dn->dir->link_primary_inode(dn, in);
>         }
>        }
> -      else if (!dnl->is_null() &&
> -              q->second.is_null()) {
> -       dout(0) << " had bad linkage for " << *dn << dendl;
> -       /*
> -        * this should happen:
> -        *  if we're a survivor, any unlink should commit or rollback during
> -        * the resolve stage.
> -        *  if we failed, we shouldn't have non-auth leaf dentries at all
> -        */
> -       assert(0);  // uh oh.
> -      }
> +
>        dn->set_replica_nonce(q->second.nonce);
>        dn->lock.set_state_rejoin(q->second.lock, rejoin_waiters);
>        dn->state_clear(CDentry::STATE_REJOINING);
> @@ -4565,6 +4621,21 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
>      dout(10) << " got inode locks " << *in << dendl;
>    }
>
> +  // trim unconnected subtree
> +  if (!isolated_inodes.empty()) {
> +    map<int, MCacheExpire*> expiremap;
> +    for (list<CInode*>::iterator p = isolated_inodes.begin();
> +        p != isolated_inodes.end();
> +        ++p) {
> +      list<CDir*> ls;
> +      (*p)->get_dirfrags(ls);
> +      trim_dirfrag(*ls.begin(), 0, expiremap);
> +      assert((*p)->get_num_ref() == 0);
> +      delete *p;
> +    }
> +    send_expire_messages(expiremap);
> +  }
> +
>    // done?
>    assert(rejoin_ack_gather.count(from));
>    rejoin_ack_gather.erase(from);
> @@ -5165,6 +5236,37 @@ void MDCache::finish_snaprealm_reconnect(client_t client, SnapRealm *realm, snap
>  void MDCache::rejoin_send_acks()
>  {
>    dout(7) << "rejoin_send_acks" << dendl;
> +
> +  // replicate stray
> +  for (map<int, set<CInode*> >::iterator p = rejoin_unlinked_inodes.begin();
> +       p != rejoin_unlinked_inodes.end();
> +       ++p) {
> +    for (set<CInode*>::iterator q = p->second.begin();
> +        q != p->second.end();
> +        ++q) {
> +      CInode *in = *q;
> +      dout(7) << " unlinked inode " << *in << dendl;
> +      // inode expired
> +      if (!in->is_replica(p->first))
> +       continue;
> +      while (1) {
> +       CDentry *dn = in->get_parent_dn();
> +       if (dn->is_replica(p->first))
> +         break;
> +       dn->add_replica(p->first);
> +       CDir *dir = dn->get_dir();
> +       if (dir->is_replica(p->first))
> +         break;
> +       dir->add_replica(p->first);
> +       in = dir->get_inode();
> +       if (in->is_replica(p->first))
> +         break;
> +       if (in->is_base())
> +         break;
> +      }
> +    }
> +  }
> +  rejoin_unlinked_inodes.clear();
>
>    // send acks to everyone in the recovery set
>    map<int,MMDSCacheRejoin*> ack;
> @@ -5204,23 +5306,29 @@ void MDCache::rejoin_send_acks()
>         CDentry *dn = q->second;
>         CDentry::linkage_t *dnl = dn->get_linkage();
>
> +       // inode
> +       CInode *in = NULL;
> +       if (dnl->is_primary())
> +         in = dnl->get_inode();
> +
>         // dentry
>         for (map<int,int>::iterator r = dn->replicas_begin();
>              r != dn->replicas_end();
> -            ++r)
> +            ++r) {
>           ack[r->first]->add_strong_dentry(dir->dirfrag(), dn->name, dn->first, dn->last,
>                                            dnl->is_primary() ? dnl->get_inode()->ino():inodeno_t(0),
>                                            dnl->is_remote() ? dnl->get_remote_ino():inodeno_t(0),
>                                            dnl->is_remote() ? dnl->get_remote_d_type():0,
>                                            ++r->second,
>                                            dn->lock.get_replica_state());
> +         // peer missed MDentrylink message ?
> +         if (in && !in->is_replica(r->first))
> +           in->add_replica(r->first);
> +       }
>
> -       if (!dnl->is_primary())
> +       if (!in)
>           continue;
>
> -       // inode
> -       CInode *in = dnl->get_inode();
> -
>         for (map<int,int>::iterator r = in->replicas_begin();
>              r != in->replicas_end();
>              ++r) {
> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
> index 2a65d0a..73780e2 100644
> --- a/src/mds/MDCache.h
> +++ b/src/mds/MDCache.h
> @@ -416,6 +416,7 @@ protected:
>    set<CInode*> rejoin_undef_inodes;
>    set<CInode*> rejoin_potential_updated_scatterlocks;
>    set<CDir*>   rejoin_undef_dirfrags;
> +  map<int, set<CInode*> > rejoin_unlinked_inodes;
>
>    vector<CInode*> rejoin_recover_q, rejoin_check_q;
>    list<Context*> rejoin_waiters;
> diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
> index cf5c1a7..aa9d165 100644
> --- a/src/mds/mdstypes.h
> +++ b/src/mds/mdstypes.h
> @@ -235,6 +235,9 @@ WRITE_CLASS_ENCODER(vinodeno_t)
>  inline bool operator==(const vinodeno_t &l, const vinodeno_t &r) {
>    return l.ino == r.ino && l.snapid == r.snapid;
>  }
> +inline bool operator!=(const vinodeno_t &l, const vinodeno_t &r) {
> +  return !(l == r);
> +}
>  inline bool operator<(const vinodeno_t &l, const vinodeno_t &r) {
>    return
>      l.ino < r.ino ||
> --
> 1.7.11.7
>
