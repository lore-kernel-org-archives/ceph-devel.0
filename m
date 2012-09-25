From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v3] mds: Adjust mydir auth when starting MDS that was
 stopped cleanly
Date: Tue, 25 Sep 2012 08:15:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209250815060.16022@cobra.newdream.net>
References: <1348551966-14718-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48849 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2IYPPJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 11:15:09 -0400
In-Reply-To: <1348551966-14718-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

sage

On Tue, 25 Sep 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When starting a MDS that was stopped cleanly, we need manually
> adjust mydir's auth. This is because MDS log is empty in this case,
> mydir's auth can not be adjusted during log replay.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 1 +
>  src/mds/MDS.cc     | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index da3affb..3784b14 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -565,6 +565,7 @@ void MDCache::open_root()
>    }
>    CDir *mydir = myin->get_or_open_dirfrag(this, frag_t());
>    assert(mydir);
> +  adjust_subtree_auth(mydir, mds->whoami);
>  
>    populate_mydir();
>  }
> diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
> index d0aac30..8ad901a 100644
> --- a/src/mds/MDS.cc
> +++ b/src/mds/MDS.cc
> @@ -1229,10 +1229,10 @@ void MDS::starting_done()
>    assert(is_starting());
>    request_state(MDSMap::STATE_ACTIVE);
>  
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
