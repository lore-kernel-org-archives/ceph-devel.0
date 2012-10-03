From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] mds: Use stray dir as base inode for stray
 reintegration
Date: Wed, 3 Oct 2012 08:17:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210030811350.21194@cobra.newdream.net>
References: <1349264412-31444-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34041 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314Ab2JCPRF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 11:17:05 -0400
In-Reply-To: <1349264412-31444-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 3 Oct 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Server::handle_client_rename() only skips common ancestor check
> if source path's base inode is stray directory, but source path's
> base inode is mdsdir in the stray reintegration case.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

Hmm, I think this is a problem because path_traverse() does not know how 
to get started with a stray dir it doesn't already have.  It might make 
more sense to use the full path here, and make the handle_client_rename() 
check smarter.

I'm testing this:

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index b706b5a..0c3ff96 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5066,7 +5066,8 @@ void Server::handle_client_rename(MDRequest *mdr)
 
   // src+dest traces _must_ share a common ancestor for locking to prevent orphans
   if (destpath.get_ino() != srcpath.get_ino() &&
-      !MDS_INO_IS_STRAY(srcpath.get_ino())) {  // <-- mds 'rename' out of stray dir is ok!
+      !(req->get_source()->is_mds() &&
+       MDS_INO_IS_MDSDIR(srcpath.get_ino()))) {  // <-- mds 'rename' out of stray dir is ok!
     // do traces share a dentry?
     CDentry *common = 0;
     for (unsigned i=0; i < srctrace.size(); i++) {


Thanks!
sage


> ---
>  src/mds/MDCache.cc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 8b02b8b..32c9e36 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -8288,8 +8288,7 @@ void MDCache::reintegrate_stray(CDentry *straydn, CDentry *rdn)
>    dout(10) << "reintegrate_stray " << *straydn << " into " << *rdn << dendl;
>    
>    // rename it to another mds.
> -  filepath src;
> -  straydn->make_path(src);
> +  filepath src(straydn->get_name(), straydn->get_dir()->get_inode()->ino());
>    filepath dst;
>    rdn->make_path(dst);
>  
> -- 
> 1.7.11.4
> 
> 
