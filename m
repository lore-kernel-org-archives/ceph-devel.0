From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH V2 2/2] mds: Adjust mydir auth when starting MDS that
 was stopped cleanly
Date: Mon, 24 Sep 2012 09:40:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209240932350.8973@cobra.newdream.net>
References: <1348486029-1125-1-git-send-email-zheng.z.yan@intel.com> <1348486029-1125-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846Ab2IXQkI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 12:40:08 -0400
In-Reply-To: <1348486029-1125-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 24 Sep 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When starting a MDS that was stopped cleanly, we need manually
> adjust mydir's auth. This is because MDS log is empty in this case,
> mydir's auth can not be adjusted during log replay.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
> Changelog v1 -> v2:
> - call mdlog->start_new_segment() after adjusting mydir's auth.
> ---
>  src/mds/MDCache.cc | 7 +++++++
>  src/mds/MDCache.h  | 1 +
>  src/mds/MDS.cc     | 5 +++--
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index da3affb..1a0e399 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -531,6 +531,13 @@ void MDCache::open_mydir_inode(Context *c)
>    in->fetch(c);
>  }
>  
> +void MDCache::adjust_mydir_auth()
> +{
> +  CDir *mydir = myin->get_or_open_dirfrag(this, frag_t());
> +  assert(mydir);
> +  adjust_subtree_auth(mydir, mds->whoami);
> +}
> +

I think it would be simpler to just roll this into open_root(), 
right after

  CDir *mydir = myin->get_or_open_dirfrag(this, frag_t());
  assert(mydir);

It makes sense to me to get the auth right when it is populated in teh 
cache. Also, it looks liek that's what we're doing for the root directory 
a few lines up.

Thanks!
sage



>  void MDCache::open_root()
>  {
>    dout(10) << "open_root" << dendl;
> diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
> index 12bdb03..fffb083 100644
> --- a/src/mds/MDCache.h
> +++ b/src/mds/MDCache.h
> @@ -643,6 +643,7 @@ public:
>    void open_root_inode(Context *c);
>    void open_root();
>    void open_mydir_inode(Context *c);
> +  void adjust_mydir_auth();
>    void populate_mydir();
>  
>    void _create_system_file(CDir *dir, const char *name, CInode *in, Context *fin);
> diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
> index d0aac30..ed95832 100644
> --- a/src/mds/MDS.cc
> +++ b/src/mds/MDS.cc
> @@ -1229,10 +1229,11 @@ void MDS::starting_done()
>    assert(is_starting());
>    request_state(MDSMap::STATE_ACTIVE);
>  
> +  mdcache->adjust_mydir_auth();
> +  mdcache->open_root();
> +
>    // start new segment
>    mdlog->start_new_segment(0);
> -
> -  mdcache->open_root();
>  }
>  
>  
> -- 
> 1.7.11.4
> 
> 
