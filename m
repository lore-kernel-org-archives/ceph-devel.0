From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 12/12] mds: Avoid creating unnecessary snaprealm
Date: Tue, 2 Oct 2012 11:31:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210021129220.19966@cobra.newdream.net>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com> <1349168152-13281-12-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54899 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab2JBSbc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 14:31:32 -0400
In-Reply-To: <1349168152-13281-12-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan,

This whole series looks great!  Sticking it in wip-mds and running it 
through the fs qa suite before merging it.

How are you testing these?  If you haven't seen it yet, there is an 'mds 
thrash exports' option that will make MDSs random migrate subtrees to each 
other that is great for shaking out bugs.  That and periodic daemon 
restarts (one of the first things we need to do on the clustered mds front 
is to get daemon restarting integrated into teuthology).

Thanks!
sage


On Tue, 2 Oct 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When moving directory between snaprealms, we can avoid creating snaprealm
> if the directory doesn't has its own snaprealm and directory was created
> after both realms' newest snapshot.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Server.cc | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index e16800e..b706b5a 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -4577,7 +4577,8 @@ void Server::_unlink_local(MDRequest *mdr, CDentry *dn, CDentry *straydn)
>      mdcache->predirty_journal_parents(mdr, &le->metablob, in, straydn->get_dir(), PREDIRTY_PRIMARY|PREDIRTY_DIR, 1);
>  
>      // project snaprealm, too
> -    in->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
> +    if (in->snaprealm || follows + 1 > dn->first)
> +      in->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
>  
>      le->metablob.add_primary_dentry(straydn, true, in);
>    } else {
> @@ -5247,11 +5248,16 @@ void Server::handle_client_rename(MDRequest *mdr)
>    }
>  
>    // moving between snaprealms?
> -  if (srcdnl->is_primary() && !srci->snaprealm &&
> -      srci->find_snaprealm() != destdn->get_dir()->inode->find_snaprealm()) {
> -    dout(10) << " renaming between snaprealms, creating snaprealm for " << *srci << dendl;
> -    mds->mdcache->snaprealm_create(mdr, srci);
> -    return;
> +  if (srcdnl->is_primary() && srci->is_multiversion() && !srci->snaprealm) {
> +    SnapRealm *srcrealm = srci->find_snaprealm();
> +    SnapRealm *destrealm = destdn->get_dir()->inode->find_snaprealm();
> +    if (srcrealm != destrealm &&
> +	(srcrealm->get_newest_seq() + 1 > srcdn->first ||
> +	 destrealm->get_newest_seq() + 1 > srcdn->first)) {
> +      dout(10) << " renaming between snaprealms, creating snaprealm for " << *srci << dendl;
> +      mds->mdcache->snaprealm_create(mdr, srci);
> +      return;
> +    }
>    }
>  
>    assert(g_conf->mds_kill_rename_at != 1);
> @@ -5650,6 +5656,7 @@ void Server::_rename_prepare(MDRequest *mdr,
>    if (destdn->is_auth())
>      mdcache->predirty_journal_parents(mdr, metablob, srci, destdn->get_dir(), flags, 1);
>  
> +  SnapRealm *src_realm = srci->find_snaprealm();
>    SnapRealm *dest_realm = destdn->get_dir()->inode->find_snaprealm();
>    snapid_t next_dest_snap = dest_realm->get_newest_seq() + 1;
>  
> @@ -5659,7 +5666,8 @@ void Server::_rename_prepare(MDRequest *mdr,
>      if (destdnl->is_primary()) {
>        if (destdn->is_auth()) {
>  	// project snaprealm, too
> -	oldin->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
> +	if (oldin->snaprealm || src_realm->get_newest_seq() + 1 > srcdn->first)
> +	  oldin->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
>  	straydn->first = MAX(oldin->first, next_dest_snap);
>  	metablob->add_primary_dentry(straydn, true, oldin);
>        }
> @@ -5703,7 +5711,8 @@ void Server::_rename_prepare(MDRequest *mdr,
>      }
>    } else if (srcdnl->is_primary()) {
>      // project snap parent update?
> -    if (destdn->is_auth() && srci->snaprealm)
> +    if (destdn->is_auth() &&
> +        (srci->snaprealm || src_realm->get_newest_seq() + 1 > srcdn->first))
>        srci->project_past_snaprealm_parent(dest_realm);
>      
>      if (destdn->is_auth() && !destdnl->is_null())
> -- 
> 1.7.11.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
