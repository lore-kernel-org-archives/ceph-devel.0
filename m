From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/2] mds: use "open-by-ino" helper to handle LOOKUPINO
 request
Date: Fri, 21 Jun 2013 17:38:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306211737590.18500@cobra.newdream.net>
References: <1371796767-16205-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161521Ab3FVAir (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 20:38:47 -0400
In-Reply-To: <1371796767-16205-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com

Applied both of these, and merged in your wip-mds branch.

This is great!  NFS reexport from a kernel cephfs mount should now be 
reliable (no more ESTALE errors).

sage

On Fri, 21 Jun 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Fixes #3541
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Server.cc | 38 ++++++++------------------------------
>  src/mds/Server.h  |  1 -
>  2 files changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index 1d16d04..e84626b 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -2483,41 +2483,19 @@ void Server::handle_client_lookup_ino(MDRequest *mdr)
>  void Server::_lookup_ino(MDRequest *mdr)
>  {
>    inodeno_t ino = mdr->client_request->get_filepath().get_ino();
> -  dout(10) << "_lookup_ino " << mdr << " checking peers for ino " << ino << dendl;
> -  mdcache->find_ino_peers(ino,
> -			  new C_MDS_LookupIno2(this, mdr), -1);
> +  dout(10) << "_lookup_ino " << mdr << " opening ino " << ino << dendl;
> +  mdcache->open_ino(ino, (int64_t)-1, new C_MDS_LookupIno2(this, mdr), false);
>  }
>  
> -struct C_MDS_LookupIno3 : public Context {
> -  Server *server;
> -  MDRequest *mdr;
> -  C_MDS_LookupIno3(Server *s, MDRequest *r) : server(s), mdr(r) {}
> -  void finish(int r) {
> -    server->_lookup_ino_3(mdr, r);
> -  }
> -};
> -
>  void Server::_lookup_ino_2(MDRequest *mdr, int r)
>  {
>    inodeno_t ino = mdr->client_request->get_filepath().get_ino();
> -  dout(10) << "_lookup_ino_2 " << mdr << " checked peers for ino " << ino
> -	   << " and got r=" << r << dendl;
> -  if (r == 0) {
> -    dispatch_client_request(mdr);
> -    return;
> -  }
> -
> -  // okay fine, maybe it's a directory though...
> -  mdcache->find_ino_dir(ino, new C_MDS_LookupIno3(this, mdr));
> -}
> -
> -void Server::_lookup_ino_3(MDRequest *mdr, int r)
> -{
> -  inodeno_t ino = mdr->client_request->get_filepath().get_ino();
> -  dout(10) << "_lookup_ino_3 " << mdr << " checked dir obj for ino " << ino
> -	   << " and got r=" << r << dendl;
> -  if (r == 0) {
> -    dispatch_client_request(mdr);
> +  dout(10) << "_lookup_ino_2 " << mdr << " ino " << ino << " r=" << r << dendl;
> +  if (r >= 0) {
> +    if (r == mds->get_nodeid())
> +      dispatch_client_request(mdr);
> +    else
> +      mdcache->request_forward(mdr, r);
>      return;
>    }
>  
> diff --git a/src/mds/Server.h b/src/mds/Server.h
> index 269b286..2da4055 100644
> --- a/src/mds/Server.h
> +++ b/src/mds/Server.h
> @@ -146,7 +146,6 @@ public:
>    void handle_client_lookup_ino(MDRequest *mdr);
>    void _lookup_ino(MDRequest *mdr);
>    void _lookup_ino_2(MDRequest *mdr, int r);
> -  void _lookup_ino_3(MDRequest *mdr, int r);
>    void handle_client_readdir(MDRequest *mdr);
>    void handle_client_file_setlock(MDRequest *mdr);
>    void handle_client_file_readlock(MDRequest *mdr);
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
