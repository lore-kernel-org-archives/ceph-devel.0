From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 01/39] mds: preserve subtree bounds until slave
 commit
Date: Wed, 20 Mar 2013 11:33:20 -0700
Message-ID: <724AC8B885B840DA8569FC8AD604B765@inktank.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1363531902-24909-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:49813 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3CTSdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 14:33:24 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so1127679dae.23
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 11:33:23 -0700 (PDT)
In-Reply-To: <1363531902-24909-2-git-send-email-zheng.z.yan@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

Reviewed-by: Greg Farnum <greg@inktank.com> 

Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> 
> When replaying an operation that rename a directory inode to non-auth subtree,
> if the inode has subtree bounds, we should prevent them from being trimmed
> until slave commit.
> 
> This patch also fixes a bug in ESlaveUpdate::replay(). EMetaBlob::replay()
> should be called before MDCache::finish_uncommitted_slave_update().
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> ---
> src/mds/MDCache.cc (http://MDCache.cc) | 21 +++++++++++----------
> src/mds/Mutation.h | 5 ++---
> src/mds/journal.cc (http://journal.cc) | 13 +++++++++----
> 3 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/src/mds/MDCache.cc (http://MDCache.cc) b/src/mds/MDCache.cc (http://MDCache.cc)
> index fddcfc6..684e70b 100644
> --- a/src/mds/MDCache.cc (http://MDCache.cc)
> +++ b/src/mds/MDCache.cc (http://MDCache.cc)
> @@ -3016,10 +3016,10 @@ void MDCache::add_uncommitted_slave_update(metareqid_t reqid, int master, MDSlav
> {
> assert(uncommitted_slave_updates[master].count(reqid) == 0);
> uncommitted_slave_updates[master][reqid] = su;
> - if (su->rename_olddir)
> - uncommitted_slave_rename_olddir[su->rename_olddir]++;
> + for(set<CDir*>::iterator p = su->olddirs.begin(); p != su->olddirs.end(); ++p)
> + uncommitted_slave_rename_olddir[*p]++;
> for(set<CInode*>::iterator p = su->unlinked.begin(); p != su->unlinked.end(); ++p)
> - uncommitted_slave_unlink[*p]++;
> + uncommitted_slave_unlink[*p]++;
> }
> 
> void MDCache::finish_uncommitted_slave_update(metareqid_t reqid, int master)
> @@ -3031,11 +3031,12 @@ void MDCache::finish_uncommitted_slave_update(metareqid_t reqid, int master)
> if (uncommitted_slave_updates[master].empty())
> uncommitted_slave_updates.erase(master);
> // discard the non-auth subtree we renamed out of
> - if (su->rename_olddir) {
> - uncommitted_slave_rename_olddir[su->rename_olddir]--;
> - if (uncommitted_slave_rename_olddir[su->rename_olddir] == 0) {
> - uncommitted_slave_rename_olddir.erase(su->rename_olddir);
> - CDir *root = get_subtree_root(su->rename_olddir);
> + for(set<CDir*>::iterator p = su->olddirs.begin(); p != su->olddirs.end(); ++p) {
> + CDir *dir = *p;
> + uncommitted_slave_rename_olddir[dir]--;
> + if (uncommitted_slave_rename_olddir[dir] == 0) {
> + uncommitted_slave_rename_olddir.erase(dir);
> + CDir *root = get_subtree_root(dir);
> if (root->get_dir_auth() == CDIR_AUTH_UNDEF)
> try_trim_non_auth_subtree(root);
> }
> @@ -6052,8 +6053,8 @@ bool MDCache::trim_non_auth_subtree(CDir *dir)
> {
> dout(10) << "trim_non_auth_subtree(" << dir << ") " << *dir << dendl;
> 
> - // preserve the dir for rollback
> - if (uncommitted_slave_rename_olddir.count(dir))
> + if (uncommitted_slave_rename_olddir.count(dir) || // preserve the dir for rollback
> + my_ambiguous_imports.count(dir->dirfrag()))
> return true;
> 
> bool keep_dir = false;
> diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
> index 55b84eb..5013f04 100644
> --- a/src/mds/Mutation.h
> +++ b/src/mds/Mutation.h
> @@ -315,13 +315,12 @@ struct MDSlaveUpdate {
> bufferlist rollback;
> elist<MDSlaveUpdate*>::item item;
> Context *waiter;
> - CDir* rename_olddir;
> + set<CDir*> olddirs;
> set<CInode*> unlinked;
> MDSlaveUpdate(int oo, bufferlist &rbl, elist<MDSlaveUpdate*> &list) :
> origop(oo),
> item(this),
> - waiter(0),
> - rename_olddir(0) {
> + waiter(0) {
> rollback.claim(rbl);
> list.push_back(&item);
> }
> diff --git a/src/mds/journal.cc (http://journal.cc) b/src/mds/journal.cc (http://journal.cc)
> index 5b3bd71..3375e40 100644
> --- a/src/mds/journal.cc (http://journal.cc)
> +++ b/src/mds/journal.cc (http://journal.cc)
> @@ -1131,10 +1131,15 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg, MDSlaveUpdate *slaveup)
> if (olddir) {
> if (olddir->authority() != CDIR_AUTH_UNDEF &&
> renamed_diri->authority() == CDIR_AUTH_UNDEF) {
> + assert(slaveup); // auth to non-auth, must be slave prepare
> list<frag_t> leaves;
> renamed_diri->dirfragtree.get_leaves(leaves);
> - for (list<frag_t>::iterator p = leaves.begin(); p != leaves.end(); ++p)
> - renamed_diri->get_or_open_dirfrag(mds->mdcache, *p);
> + for (list<frag_t>::iterator p = leaves.begin(); p != leaves.end(); ++p) {
> + CDir *dir = renamed_diri->get_or_open_dirfrag(mds->mdcache, *p);
> + // preserve subtree bound until slave commit
> + if (dir->authority() == CDIR_AUTH_UNDEF)
> + slaveup->olddirs.insert(dir);
> + }
> }
> 
> mds->mdcache->adjust_subtree_after_rename(renamed_diri, olddir, false);
> @@ -1143,7 +1148,7 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg, MDSlaveUpdate *slaveup)
> CDir *root = mds->mdcache->get_subtree_root(olddir);
> if (root->get_dir_auth() == CDIR_AUTH_UNDEF) {
> if (slaveup) // preserve the old dir until slave commit
> - slaveup->rename_olddir = olddir;
> + slaveup->olddirs.insert(olddir);
> else
> mds->mdcache->try_trim_non_auth_subtree(root);
> }
> @@ -2122,10 +2127,10 @@ void ESlaveUpdate::replay(MDS *mds)
> case ESlaveUpdate::OP_ROLLBACK:
> dout(10) << "ESlaveUpdate.replay abort " << reqid << " for mds." << master
> << ": applying rollback commit blob" << dendl;
> + commit.replay(mds, _segment);
> su = mds->mdcache->get_uncommitted_slave_update(reqid, master);
> if (su)
> mds->mdcache->finish_uncommitted_slave_update(reqid, master);
> - commit.replay(mds, _segment);
> break;
> 
> default:
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



