From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 09/39] mds: defer eval gather locks when removing
 replica
Date: Wed, 20 Mar 2013 12:36:44 -0700
Message-ID: <706819819FC545BA9301A427164F5983@inktank.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1363531902-24909-10-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:47336 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab3CTTgs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 15:36:48 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so1186417dak.16
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 12:36:48 -0700 (PDT)
In-Reply-To: <1363531902-24909-10-git-send-email-zheng.z.yan@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Locks' states should not change between composing the cache rejoin ack
> messages and sending the message. If Locker::eval_gather() is called
> in MDCache::{inode,dentry}_remove_replica(), it may wake requests and
> change locks' states.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> ---
> src/mds/MDCache.cc (http://MDCache.cc) | 51 ++++++++++++++++++++++++++++++---------------------
> src/mds/MDCache.h | 8 +++++---
> 2 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/src/mds/MDCache.cc (http://MDCache.cc) b/src/mds/MDCache.cc (http://MDCache.cc)
> index 19dc60b..0f6b842 100644
> --- a/src/mds/MDCache.cc (http://MDCache.cc)
> +++ b/src/mds/MDCache.cc (http://MDCache.cc)
> @@ -3729,6 +3729,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
> // possible response(s)
> MMDSCacheRejoin *ack = 0; // if survivor
> set<vinodeno_t> acked_inodes; // if survivor
> + set<SimpleLock *> gather_locks; // if survivor
> bool survivor = false; // am i a survivor?
> 
> if (mds->is_clientreplay() || mds->is_active() || mds->is_stopping()) {
> @@ -3851,7 +3852,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
> assert(dnl->is_primary());
> 
> if (survivor && dn->is_replica(from)) 
> - dentry_remove_replica(dn, from); // this induces a lock gather completion
> + dentry_remove_replica(dn, from, gather_locks); // this induces a lock gather completion

This comment is no longer accurate :) 
> int dnonce = dn->add_replica(from);
> dout(10) << " have " << *dn << dendl;
> if (ack) 
> @@ -3864,7 +3865,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
> assert(in);
> 
> if (survivor && in->is_replica(from)) 
> - inode_remove_replica(in, from);
> + inode_remove_replica(in, from, gather_locks);
> int inonce = in->add_replica(from);
> dout(10) << " have " << *in << dendl;
> 
> @@ -3887,7 +3888,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
> CInode *in = get_inode(*p);
> assert(in); // hmm fixme wrt stray?
> if (survivor && in->is_replica(from)) 
> - inode_remove_replica(in, from); // this induces a lock gather completion
> + inode_remove_replica(in, from, gather_locks); // this induces a lock gather completion

Same here. 

Other than those, looks good.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


> int inonce = in->add_replica(from);
> dout(10) << " have base " << *in << dendl;
> 
> @@ -3909,8 +3910,11 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
> ack->add_inode_base(in);
> }
> 
> - rejoin_scour_survivor_replicas(from, ack, acked_inodes);
> + rejoin_scour_survivor_replicas(from, ack, gather_locks, acked_inodes);
> mds->send_message(ack, weak->get_connection());
> +
> + for (set<SimpleLock*>::iterator p = gather_locks.begin(); p != gather_locks.end(); ++p)
> + mds->locker->eval_gather(*p);
> } else {
> // done?
> assert(rejoin_gather.count(from));
> @@ -4055,7 +4059,9 @@ bool MDCache::parallel_fetch_traverse_dir(inodeno_t ino, filepath& path,
> * all validated replicas are acked with a strong nonce, etc. if that isn't in the
> * ack, the replica dne, and we can remove it from our replica maps.
> */
> -void MDCache::rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack, set<vinodeno_t>& acked_inodes)
> +void MDCache::rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack,
> + set<SimpleLock *>& gather_locks,
> + set<vinodeno_t>& acked_inodes)
> {
> dout(10) << "rejoin_scour_survivor_replicas from mds." << from << dendl;
> 
> @@ -4070,7 +4076,7 @@ void MDCache::rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack, set
> if (in->is_auth() &&
> in->is_replica(from) &&
> acked_inodes.count(p->second->vino()) == 0) {
> - inode_remove_replica(in, from);
> + inode_remove_replica(in, from, gather_locks);
> dout(10) << " rem " << *in << dendl;
> }
> 
> @@ -4099,7 +4105,7 @@ void MDCache::rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack, set
> if (dn->is_replica(from) &&
> (ack->strong_dentries.count(dir->dirfrag()) == 0 ||
> ack->strong_dentries[dir->dirfrag()].count(string_snap_t(dn->name, dn->last)) == 0)) {
> - dentry_remove_replica(dn, from);
> + dentry_remove_replica(dn, from, gather_locks);
> dout(10) << " rem " << *dn << dendl;
> }
> }
> @@ -6189,6 +6195,7 @@ void MDCache::handle_cache_expire(MCacheExpire *m)
> return;
> }
> 
> + set<SimpleLock *> gather_locks;
> // loop over realms
> for (map<dirfrag_t,MCacheExpire::realm>::iterator p = m->realms.begin();
> p != m->realms.end();
> @@ -6255,7 +6262,7 @@ void MDCache::handle_cache_expire(MCacheExpire *m)
> // remove from our cached_by
> dout(7) << " inode expire on " << *in << " from mds." << from 
> << " cached_by was " << in->get_replicas() << dendl;
> - inode_remove_replica(in, from);
> + inode_remove_replica(in, from, gather_locks);
> } 
> else {
> // this is an old nonce, ignore expire.
> @@ -6332,7 +6339,7 @@ void MDCache::handle_cache_expire(MCacheExpire *m)
> 
> if (nonce == dn->get_replica_nonce(from)) {
> dout(7) << " dentry_expire on " << *dn << " from mds." << from << dendl;
> - dentry_remove_replica(dn, from);
> + dentry_remove_replica(dn, from, gather_locks);
> } 
> else {
> dout(7) << " dentry_expire on " << *dn << " from mds." << from
> @@ -6343,6 +6350,8 @@ void MDCache::handle_cache_expire(MCacheExpire *m)
> }
> }
> 
> + for (set<SimpleLock*>::iterator p = gather_locks.begin(); p != gather_locks.end(); ++p)
> + mds->locker->eval_gather(*p);
> 
> // done
> m->put();
> @@ -6368,35 +6377,35 @@ void MDCache::discard_delayed_expire(CDir *dir)
> delayed_expire.erase(dir); 
> }
> 
> -void MDCache::inode_remove_replica(CInode *in, int from)
> +void MDCache::inode_remove_replica(CInode *in, int from, set<SimpleLock *>& gather_locks)
> {
> in->remove_replica(from);
> in->mds_caps_wanted.erase(from);
> 
> // note: this code calls _eval more often than it needs to!
> // fix lock
> - if (in->authlock.remove_replica(from)) mds->locker->eval_gather(&in->authlock);
> - if (in->linklock.remove_replica(from)) mds->locker->eval_gather(&in->linklock);
> - if (in->dirfragtreelock.remove_replica(from)) mds->locker->eval_gather(&in->dirfragtreelock);
> - if (in->filelock.remove_replica(from)) mds->locker->eval_gather(&in->filelock);
> - if (in->snaplock.remove_replica(from)) mds->locker->eval_gather(&in->snaplock);
> - if (in->xattrlock.remove_replica(from)) mds->locker->eval_gather(&in->xattrlock);
> + if (in->authlock.remove_replica(from)) gather_locks.insert(&in->authlock);
> + if (in->linklock.remove_replica(from)) gather_locks.insert(&in->linklock);
> + if (in->dirfragtreelock.remove_replica(from)) gather_locks.insert(&in->dirfragtreelock);
> + if (in->filelock.remove_replica(from)) gather_locks.insert(&in->filelock);
> + if (in->snaplock.remove_replica(from)) gather_locks.insert(&in->snaplock);
> + if (in->xattrlock.remove_replica(from)) gather_locks.insert(&in->xattrlock);
> 
> - if (in->nestlock.remove_replica(from)) mds->locker->eval_gather(&in->nestlock);
> - if (in->flocklock.remove_replica(from)) mds->locker->eval_gather(&in->flocklock);
> - if (in->policylock.remove_replica(from)) mds->locker->eval_gather(&in->policylock);
> + if (in->nestlock.remove_replica(from)) gather_locks.insert(&in->nestlock);
> + if (in->flocklock.remove_replica(from)) gather_locks.insert(&in->flocklock);
> + if (in->policylock.remove_replica(from)) gather_locks.insert(&in->policylock);
> 
> // trim?
> maybe_eval_stray(in);
> }
> 
> -void MDCache::dentry_remove_replica(CDentry *dn, int from)
> +void MDCache::dentry_remove_replica(CDentry *dn, int from, set<SimpleLock *>& gather_locks)
> {
> dn->remove_replica(from);
> 
> // fix lock
> if (dn->lock.remove_replica(from))
> - mds->locker->eval_gather(&dn->lock);
> + gather_locks.insert(&dn->lock);
> 
> CDentry::linkage_t *dnl = dn->get_projected_linkage();
> if (dnl->is_primary())
> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
> index f07ea74..a9f05c6 100644
> --- a/src/mds/MDCache.h
> +++ b/src/mds/MDCache.h
> @@ -406,7 +406,9 @@ protected:
> CDir* rejoin_invent_dirfrag(dirfrag_t df);
> bool rejoin_fetch_dirfrags(MMDSCacheRejoin *m);
> void handle_cache_rejoin_strong(MMDSCacheRejoin *m);
> - void rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack, set<vinodeno_t>& acked_inodes);
> + void rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack,
> + set<SimpleLock *>& gather_locks,
> + set<vinodeno_t>& acked_inodes);
> void handle_cache_rejoin_ack(MMDSCacheRejoin *m);
> void handle_cache_rejoin_purge(MMDSCacheRejoin *m);
> void handle_cache_rejoin_missing(MMDSCacheRejoin *m);
> @@ -607,8 +609,8 @@ public:
> }
> protected:
> 
> - void inode_remove_replica(CInode *in, int rep);
> - void dentry_remove_replica(CDentry *dn, int rep);
> + void inode_remove_replica(CInode *in, int rep, set<SimpleLock *>& gather_locks);
> + void dentry_remove_replica(CDentry *dn, int rep, set<SimpleLock *>& gather_locks);
> 
> void rename_file(CDentry *srcdn, CDentry *destdn);
> 
> -- 
> 1.7.11.7


