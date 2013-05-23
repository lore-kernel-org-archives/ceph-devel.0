From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 07/30] mds: fix straydn race
Date: Thu, 23 May 2013 09:44:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305230943310.32642@cobra.newdream.net>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-8-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40901 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758976Ab3EWQos (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 12:44:48 -0400
In-Reply-To: <1369296418-14871-8-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On Thu, 23 May 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> For unlink/rename request, the target dentry's linkage may change
> before all locks are acquired. So we need check if the existing stray
> dentry is valid.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Mutation.cc |  7 +++++++
>  src/mds/Mutation.h  |  1 +
>  src/mds/Server.cc   | 49 ++++++++++++++++++++++++++++++-------------------
>  src/mds/Server.h    |  1 +
>  4 files changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/src/mds/Mutation.cc b/src/mds/Mutation.cc
> index 4e4f69c..3916b2a 100644
> --- a/src/mds/Mutation.cc
> +++ b/src/mds/Mutation.cc
> @@ -30,6 +30,13 @@ void Mutation::pin(MDSCacheObject *o)
>    }      
>  }
>  
> +void Mutation::unpin(MDSCacheObject *o)
> +{
> +  assert(pins.count(o));
> +  o->put(MDSCacheObject::PIN_REQUEST);
> +  pins.erase(o);
> +}
> +
>  void Mutation::set_stickydirs(CInode *in)
>  {
>    if (stickydirs.count(in) == 0) {
> diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
> index de122a5..c0bea19 100644
> --- a/src/mds/Mutation.h
> +++ b/src/mds/Mutation.h
> @@ -113,6 +113,7 @@ struct Mutation {
>  
>    // pin items in cache
>    void pin(MDSCacheObject *o);
> +  void unpin(MDSCacheObject *o);
>    void set_stickydirs(CInode *in);
>    void drop_pins();
>  
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index 63401e8..fac7a56 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -1797,6 +1797,24 @@ CDentry* Server::prepare_null_dentry(MDRequest *mdr, CDir *dir, const string& dn
>    return dn;
>  }
>  
> +CDentry* Server::prepare_stray_dentry(MDRequest *mdr, CInode *in)
> +{
> +  CDentry *straydn = mdr->straydn;
> +  if (straydn) {
> +    string name;
> +    in->name_stray_dentry(name);
> +    if (straydn->get_name() == name)
> +      return straydn;
> +
> +    mdr->unpin(straydn);
> +    mdr->done_locking = false;

IIRC we should never go from done_locking = true -> false.  In this case, 
once everything is locked, the straydn shouldn't change, right?  This 
could be an assert(mdr->done_locking == false).

Also, FWIW, the unpin() isn't strictly necessary; we are pretty lazy about 
dropping pins all over the place.  But it doesn't hurt!

sage

> +  }
> +
> +  straydn = mdcache->get_or_create_stray_dentry(in);
> +  mdr->straydn = straydn;
> +  mdr->pin(straydn);
> +  return straydn;
> +}
>  
>  /** prepare_new_inode
>   *
> @@ -4899,18 +4917,14 @@ void Server::handle_client_unlink(MDRequest *mdr)
>    }
>  
>    // -- create stray dentry? --
> -  CDentry *straydn = mdr->straydn;
> +  CDentry *straydn = NULL;
>    if (dnl->is_primary()) {
> -    if (!straydn) {
> -      straydn = mdcache->get_or_create_stray_dentry(dnl->get_inode());
> -      mdr->pin(straydn);
> -      mdr->straydn = straydn;
> -    }
> -  } else if (straydn)
> -    straydn = NULL;
> -  if (straydn)
> +    straydn = prepare_stray_dentry(mdr, dnl->get_inode());
>      dout(10) << " straydn is " << *straydn << dendl;
> -
> +  } else if (mdr->straydn) {
> +    mdr->unpin(mdr->straydn);
> +    mdr->straydn = NULL;
> +  }
>  
>    // lock
>    set<SimpleLock*> rdlocks, wrlocks, xlocks;
> @@ -5650,17 +5664,14 @@ void Server::handle_client_rename(MDRequest *mdr)
>      dout(10) << " this is a link merge" << dendl;
>  
>    // -- create stray dentry? --
> -  CDentry *straydn = mdr->straydn;
> +  CDentry *straydn = NULL;
>    if (destdnl->is_primary() && !linkmerge) {
> -    if (!straydn) {
> -      straydn = mdcache->get_or_create_stray_dentry(destdnl->get_inode());
> -      mdr->pin(straydn);
> -      mdr->straydn = straydn;
> -    }
> -  } else if (straydn)
> -    straydn = NULL;
> -  if (straydn)
> +    straydn = prepare_stray_dentry(mdr, destdnl->get_inode());
>      dout(10) << " straydn is " << *straydn << dendl;
> +  } else if (mdr->straydn) {
> +    mdr->unpin(mdr->straydn);
> +    mdr->straydn = NULL;
> +  }
>  
>    // -- prepare witness list --
>    /*
> diff --git a/src/mds/Server.h b/src/mds/Server.h
> index 15c8077..ffe9256 100644
> --- a/src/mds/Server.h
> +++ b/src/mds/Server.h
> @@ -120,6 +120,7 @@ public:
>    CDir *validate_dentry_dir(MDRequest *mdr, CInode *diri, const string& dname);
>    CDir *traverse_to_auth_dir(MDRequest *mdr, vector<CDentry*> &trace, filepath refpath);
>    CDentry *prepare_null_dentry(MDRequest *mdr, CDir *dir, const string& dname, bool okexist=false);
> +  CDentry *prepare_stray_dentry(MDRequest *mdr, CInode *in);
>    CInode* prepare_new_inode(MDRequest *mdr, CDir *dir, inodeno_t useino, unsigned mode,
>  			    ceph_file_layout *layout=NULL);
>    void journal_allocated_inos(MDRequest *mdr, EMetaBlob *blob);
> -- 
> 1.8.1.4
> 
> 
