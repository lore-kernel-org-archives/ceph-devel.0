From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 19/39] mds: remove MDCache::rejoin_fetch_dirfrags()
Date: Wed, 20 Mar 2013 15:58:18 -0700
Message-ID: <CAPYLRziEZ4X6h2=q6XTE2WSgLOoF=Cdk7zCt16upCY+kt9vNqg@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-20-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:54163 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab3CTW6T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 18:58:19 -0400
Received: by mail-qa0-f42.google.com with SMTP id bv4so1006133qab.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 15:58:18 -0700 (PDT)
In-Reply-To: <1363531902-24909-20-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Nice.
Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> In commit 77946dcdae (mds: fetch missing inodes from disk), I introduced
> MDCache::rejoin_fetch_dirfrags(). But it basicly duplicates the function
> of MDCache::open_undef_dirfrags(), so just remove rejoin_fetch_dirfrags()
> and make open_undef_dirfrags() also handle undefined inodes.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CDir.cc    |  70 +++++++++++--------
>  src/mds/MDCache.cc | 193 +++++++++++++++++------------------------------------
>  src/mds/MDCache.h  |   5 +-
>  3 files changed, 107 insertions(+), 161 deletions(-)
>
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index 231630e..af0ae9c 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -1553,33 +1553,32 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
>        if (stale)
>         continue;
>
> +      bool undef_inode = false;
>        if (dn) {
> -        if (dn->get_linkage()->get_inode() == 0) {
> -          dout(12) << "_fetched  had NEG dentry " << *dn << dendl;
> -        } else {
> -          dout(12) << "_fetched  had dentry " << *dn << dendl;
> -        }
> -      } else {
> +       CInode *in = dn->get_linkage()->get_inode();
> +       if (in) {
> +         dout(12) << "_fetched  had dentry " << *dn << dendl;
> +         if (in->state_test(CInode::STATE_REJOINUNDEF)) {
> +           assert(cache->mds->is_rejoin());
> +           assert(in->vino() == vinodeno_t(inode.ino, last));
> +           in->state_clear(CInode::STATE_REJOINUNDEF);
> +           cache->opened_undef_inode(in);
> +           undef_inode = true;
> +         }
> +       } else
> +         dout(12) << "_fetched  had NEG dentry " << *dn << dendl;
> +      }
> +
> +      if (!dn || undef_inode) {
>         // add inode
>         CInode *in = cache->get_inode(inode.ino, last);
> -       if (in) {
> -         dout(0) << "_fetched  badness: got (but i already had) " << *in
> -                 << " mode " << in->inode.mode
> -                 << " mtime " << in->inode.mtime << dendl;
> -         string dirpath, inopath;
> -         this->inode->make_path_string(dirpath);
> -         in->make_path_string(inopath);
> -         clog.error() << "loaded dup inode " << inode.ino
> -           << " [" << first << "," << last << "] v" << inode.version
> -           << " at " << dirpath << "/" << dname
> -           << ", but inode " << in->vino() << " v" << in->inode.version
> -           << " already exists at " << inopath << "\n";
> -         continue;
> -       } else {
> -         // inode
> -         in = new CInode(cache, true, first, last);
> -         in->inode = inode;
> +       if (!in || undef_inode) {
> +         if (undef_inode)
> +           in->first = first;
> +         else
> +           in = new CInode(cache, true, first, last);
>
> +         in->inode = inode;
>           // symlink?
>           if (in->is_symlink())
>             in->symlink = symlink;
> @@ -1591,11 +1590,13 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
>           if (snaps)
>             in->purge_stale_snap_data(*snaps);
>
> -         // add
> -         cache->add_inode( in );
> -
> -         // link
> -         dn = add_primary_dentry(dname, in, first, last);
> +         if (undef_inode) {
> +           if (inode.anchored)
> +             dn->adjust_nested_anchors(1);
> +         } else {
> +           cache->add_inode( in ); // add
> +           dn = add_primary_dentry(dname, in, first, last); // link
> +         }
>           dout(12) << "_fetched  got " << *dn << " " << *in << dendl;
>
>           if (in->inode.is_dirty_rstat())
> @@ -1604,6 +1605,19 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
>           //in->hack_accessed = false;
>           //in->hack_load_stamp = ceph_clock_now(g_ceph_context);
>           //num_new_inodes_loaded++;
> +       } else {
> +         dout(0) << "_fetched  badness: got (but i already had) " << *in
> +                 << " mode " << in->inode.mode
> +                 << " mtime " << in->inode.mtime << dendl;
> +         string dirpath, inopath;
> +         this->inode->make_path_string(dirpath);
> +         in->make_path_string(inopath);
> +         clog.error() << "loaded dup inode " << inode.ino
> +           << " [" << first << "," << last << "] v" << inode.version
> +           << " at " << dirpath << "/" << dname
> +           << ", but inode " << in->vino() << " v" << in->inode.version
> +           << " already exists at " << inopath << "\n";
> +         continue;
>         }
>        }
>      } else {
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index d934020..008a8a2 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -4178,7 +4178,6 @@ void MDCache::rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack,
>
>  CInode *MDCache::rejoin_invent_inode(inodeno_t ino, snapid_t last)
>  {
> -  assert(0);
>    CInode *in = new CInode(this, true, 1, last);
>    in->inode.ino = ino;
>    in->state_set(CInode::STATE_REJOINUNDEF);
> @@ -4190,16 +4189,13 @@ CInode *MDCache::rejoin_invent_inode(inodeno_t ino, snapid_t last)
>
>  CDir *MDCache::rejoin_invent_dirfrag(dirfrag_t df)
>  {
> -  assert(0);
>    CInode *in = get_inode(df.ino);
> -  if (!in) {
> +  if (!in)
>      in = rejoin_invent_inode(df.ino, CEPH_NOSNAP);
> -    if (!in->is_dir()) {
> -      assert(in->state_test(CInode::STATE_REJOINUNDEF));
> -      in->inode.mode = S_IFDIR;
> -    }
> +  if (!in->is_dir()) {
> +    assert(in->state_test(CInode::STATE_REJOINUNDEF));
> +    in->inode.mode = S_IFDIR;
>    }
> -  assert(in->is_dir());
>    CDir *dir = in->get_or_open_dirfrag(this, df.frag);
>    dir->state_set(CDir::STATE_REJOINUNDEF);
>    rejoin_undef_dirfrags.insert(dir);
> @@ -4207,81 +4203,6 @@ CDir *MDCache::rejoin_invent_dirfrag(dirfrag_t df)
>    return dir;
>  }
>
> -bool MDCache::rejoin_fetch_dirfrags(MMDSCacheRejoin *strong)
> -{
> -  int skipped = 0;
> -  set<CDir*> fetch_queue;
> -  for (map<dirfrag_t, MMDSCacheRejoin::dirfrag_strong>::iterator p = strong->strong_dirfrags.begin();
> -       p != strong->strong_dirfrags.end();
> -       ++p) {
> -    CInode *diri = get_inode(p->first.ino);
> -    if (!diri) {
> -      skipped++;
> -      continue;
> -    }
> -    CDir *dir = diri->get_dirfrag(p->first.frag);
> -    if (dir && dir->is_complete())
> -      continue;
> -
> -    set<CDir*> frags;
> -    bool refragged = false;
> -    if (!dir) {
> -      if (diri->dirfragtree.is_leaf(p->first.frag))
> -       dir = diri->get_or_open_dirfrag(this, p->first.frag);
> -      else {
> -       list<frag_t> ls;
> -       diri->dirfragtree.get_leaves_under(p->first.frag, ls);
> -       if (ls.empty())
> -         ls.push_back(diri->dirfragtree[p->first.frag.value()]);
> -       for (list<frag_t>::iterator q = ls.begin(); q != ls.end(); ++q) {
> -         dir = diri->get_or_open_dirfrag(this, p->first.frag);
> -         frags.insert(dir);
> -       }
> -       refragged = true;
> -      }
> -    }
> -
> -    map<string_snap_t,MMDSCacheRejoin::dn_strong>& dmap = strong->strong_dentries[p->first];
> -    for (map<string_snap_t,MMDSCacheRejoin::dn_strong>::iterator q = dmap.begin();
> -       q != dmap.end();
> -       ++q) {
> -      if (!q->second.is_primary())
> -       continue;
> -      CDentry *dn;
> -      if (!refragged)
> -       dn = dir->lookup(q->first.name, q->first.snapid);
> -      else {
> -       frag_t fg = diri->pick_dirfrag(q->first.name);
> -       dir = diri->get_dirfrag(fg);
> -       assert(dir);
> -       dn = dir->lookup(q->first.name, q->first.snapid);
> -      }
> -      if (!dn) {
> -       fetch_queue.insert(dir);
> -       if (!refragged)
> -         break;
> -       frags.erase(dir);
> -       if (frags.empty())
> -         break;
> -      }
> -    }
> -  }
> -
> -  if (!fetch_queue.empty()) {
> -    dout(10) << "rejoin_fetch_dirfrags " << fetch_queue.size() << " dirfrags" << dendl;
> -    strong->get();
> -    C_GatherBuilder gather(g_ceph_context, new C_MDS_RetryMessage(mds, strong));
> -    for (set<CDir*>::iterator p = fetch_queue.begin(); p != fetch_queue.end(); ++p) {
> -      CDir *dir = *p;
> -      dir->fetch(gather.new_sub());
> -    }
> -    gather.activate();
> -    return true;
> -  }
> -  assert(!skipped);
> -  return false;
> -}
> -
>  /* This functions DOES NOT put the passed message before returning */
>  void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>  {
> @@ -4290,11 +4211,6 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>    // only a recovering node will get a strong rejoin.
>    assert(mds->is_rejoin());
>
> -  if (rejoin_fetch_dirfrags(strong))
> -    return;
> -
> -  MMDSCacheRejoin *missing = 0;  // if i'm missing something..
> -
>    // assimilate any potentially dirty scatterlock state
>    for (map<inodeno_t,MMDSCacheRejoin::lock_bls>::iterator p = strong->inode_scatterlocks.begin();
>         p != strong->inode_scatterlocks.end();
> @@ -4319,12 +4235,16 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>         p != strong->strong_dirfrags.end();
>         ++p) {
>      CInode *diri = get_inode(p->first.ino);
> +    if (!diri)
> +      diri = rejoin_invent_inode(p->first.ino, CEPH_NOSNAP);
>      CDir *dir = diri->get_dirfrag(p->first.frag);
>      bool refragged = false;
>      if (dir) {
>        dout(10) << " have " << *dir << dendl;
>      } else {
> -      if (diri->dirfragtree.is_leaf(p->first.frag))
> +      if (diri->state_test(CInode::STATE_REJOINUNDEF))
> +       dir = rejoin_invent_dirfrag(dirfrag_t(diri->ino(), frag_t()));
> +      else if (diri->dirfragtree.is_leaf(p->first.frag))
>         dir = rejoin_invent_dirfrag(p->first);
>      }
>      if (dir) {
> @@ -4369,15 +4289,9 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>         } else if (q->second.is_null()) {
>           dn = dir->add_null_dentry(q->first.name, q->second.first, q->first.snapid);
>         } else {
> -         assert(0);
>           CInode *in = get_inode(q->second.ino, q->first.snapid);
>           if (!in) in = rejoin_invent_inode(q->second.ino, q->first.snapid);
>           dn = dir->add_primary_dentry(q->first.name, in, q->second.first, q->first.snapid);
> -
> -         dout(10) << " missing " << q->second.ino << "." << q->first.snapid << dendl;
> -         if (!missing)
> -           missing = new MMDSCacheRejoin(MMDSCacheRejoin::OP_MISSING);
> -         missing->add_weak_inode(vinodeno_t(q->second.ino, q->first.snapid));  // we want it back!
>         }
>         dout(10) << " invented " << *dn << dendl;
>        }
> @@ -4513,19 +4427,15 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>      in->add_replica(from);
>    }
>
> -  // send missing?
> -  if (missing) {
> -    // we expect a FULL soon.
> -    mds->send_message(missing, strong->get_connection());
> +
> +
> +  // done?
> +  assert(rejoin_gather.count(from));
> +  rejoin_gather.erase(from);
> +  if (rejoin_gather.empty()) {
> +    rejoin_gather_finish();
>    } else {
> -    // done?
> -    assert(rejoin_gather.count(from));
> -    rejoin_gather.erase(from);
> -    if (rejoin_gather.empty()) {
> -      rejoin_gather_finish();
> -    } else {
> -      dout(7) << "still need rejoin from (" << rejoin_gather << ")" << dendl;
> -    }
> +    dout(7) << "still need rejoin from (" << rejoin_gather << ")" << dendl;
>    }
>  }
>
> @@ -4800,7 +4710,8 @@ void MDCache::rejoin_gather_finish()
>    dout(10) << "rejoin_gather_finish" << dendl;
>    assert(mds->is_rejoin());
>
> -  rejoin_trim_undef_inodes();
> +  if (open_undef_inodes_dirfrags())
> +    return;
>
>    // fetch paths?
>    //  do this before ack, since some inodes we may have already gotten
> @@ -5152,44 +5063,62 @@ void MDCache::open_snap_parents()
>      gather.set_finisher(new C_MDC_OpenSnapParents(this));
>      gather.activate();
>    } else {
> +    assert(rejoin_waiters.empty());
>      assert(missing_snap_parents.empty());
>      assert(reconnected_snaprealms.empty());
>      dout(10) << "open_snap_parents - all open" << dendl;
>      do_delayed_cap_imports();
>
> -    open_undef_dirfrags();
> +    start_files_to_recover(rejoin_recover_q, rejoin_check_q);
> +    mds->rejoin_done();
>    }
>  }
>
> -struct C_MDC_OpenUndefDirfragsFinish : public Context {
> -  MDCache *cache;
> -  C_MDC_OpenUndefDirfragsFinish(MDCache *c) : cache(c) {}
> -  void finish(int r) {
> -    cache->open_undef_dirfrags();
> +bool MDCache::open_undef_inodes_dirfrags()
> +{
> +  dout(10) << "open_undef_inodes_dirfrags "
> +          << rejoin_undef_inodes.size() << " inodes "
> +          << rejoin_undef_dirfrags.size() << " dirfrags" << dendl;
> +
> +  set<CDir*> fetch_queue = rejoin_undef_dirfrags;
> +
> +  for (set<CInode*>::iterator p = rejoin_undef_inodes.begin();
> +       p != rejoin_undef_inodes.end();
> +       ++p) {
> +    CInode *in = *p;
> +    assert(!in->is_base());
> +    fetch_queue.insert(in->get_parent_dir());
>    }
> -};
>
> -void MDCache::open_undef_dirfrags()
> -{
> -  dout(10) << "open_undef_dirfrags " << rejoin_undef_dirfrags.size() << " dirfrags" << dendl;
> -
> -  C_GatherBuilder gather(g_ceph_context);
> -  for (set<CDir*>::iterator p = rejoin_undef_dirfrags.begin();
> -       p != rejoin_undef_dirfrags.end();
> +  if (fetch_queue.empty())
> +    return false;
> +
> +  C_GatherBuilder gather(g_ceph_context, new C_MDC_RejoinGatherFinish(this));
> +  for (set<CDir*>::iterator p = fetch_queue.begin();
> +       p != fetch_queue.end();
>         ++p) {
>      CDir *dir = *p;
> +    CInode *diri = dir->get_inode();
> +    if (diri->state_test(CInode::STATE_REJOINUNDEF))
> +      continue;
> +    if (dir->state_test(CDir::STATE_REJOINUNDEF) && dir->get_frag() == frag_t()) {
> +      rejoin_undef_dirfrags.erase(dir);
> +      dir->state_clear(CDir::STATE_REJOINUNDEF);
> +      diri->force_dirfrags();
> +      list<CDir*> ls;
> +      diri->get_dirfrags(ls);
> +      for (list<CDir*>::iterator q = ls.begin(); q != ls.end(); ++q) {
> +       rejoin_undef_dirfrags.insert(*q);
> +       (*q)->state_set(CDir::STATE_REJOINUNDEF);
> +       (*q)->fetch(gather.new_sub());
> +      }
> +      continue;
> +    }
>      dir->fetch(gather.new_sub());
>    }
> -
> -  if (gather.has_subs()) {
> -    gather.set_finisher(new C_MDC_OpenUndefDirfragsFinish(this));
> -    gather.activate();
> -  }
> -  else {
> -    start_files_to_recover(rejoin_recover_q, rejoin_check_q);
> -    mds->queue_waiters(rejoin_waiters);
> -    mds->rejoin_done();
> -  }
> +  assert(gather.has_subs());
> +  gather.activate();
> +  return true;
>  }
>
>  void MDCache::finish_snaprealm_reconnect(client_t client, SnapRealm *realm, snapid_t seq)
> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
> index a05ced7..85f5d65 100644
> --- a/src/mds/MDCache.h
> +++ b/src/mds/MDCache.h
> @@ -496,10 +496,13 @@ public:
>    void check_realm_past_parents(SnapRealm *realm);
>    void open_snap_parents();
>
> -  void open_undef_dirfrags();
> +  bool open_undef_inodes_dirfrags();
>    void opened_undef_dirfrag(CDir *dir) {
>      rejoin_undef_dirfrags.erase(dir);
>    }
> +  void opened_undef_inode(CInode *in) {
> +    rejoin_undef_inodes.erase(in);
> +  }
>
>    void reissue_all_caps();
>
> --
> 1.7.11.7
>
