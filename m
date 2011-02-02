From: Sage Weil <sage@newdream.net>
Subject: Re: Speling fixes
Date: Wed, 2 Feb 2011 09:15:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102020913270.18507@cobra.newdream.net>
References: <slrnikhrff.3cc.chris@chris.onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56692 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab1BBRO7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 12:14:59 -0500
In-Reply-To: <slrnikhrff.3cc.chris@chris.onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

Applied both of these, thanks!


On Wed, 2 Feb 2011, Chris Dunlop wrote:

> Trivial spelling fixes...
> 
> diff --git a/man/mount.ceph.8 b/man/mount.ceph.8
> index d5fe62a..cfcf8f8 100644
> --- a/man/mount.ceph.8
> +++ b/man/mount.ceph.8
> @@ -134,7 +134,7 @@ Report rbytes for st_size on directories.  Default: on
>  
>  norbytes
>  .IP
> -Do not report rbytse for st_size.
> +Do not report rbytes for st_size.
>  .PP
>  
>  nocrc
> diff --git a/src/mds/MDSMap.h b/src/mds/MDSMap.h
> index 7bcdd27..6e8a9fa 100644
> --- a/src/mds/MDSMap.h
> +++ b/src/mds/MDSMap.h
> @@ -59,7 +59,7 @@ extern CompatSet mdsmap_compat_base; // pre v0.20
>  #define MDS_FEATURE_INCOMPAT_BASE CompatSet::Feature(1, "base v0.20")
>  #define MDS_FEATURE_INCOMPAT_CLIENTRANGES CompatSet::Feature(2, "client writeable ranges")
>  #define MDS_FEATURE_INCOMPAT_FILELAYOUT CompatSet::Feature(3, "default file layouts on dirs")
> -#define MDS_FEATURE_INCOMPAT_DIRINODE CompatSet::Feature(4, "dir inode in separate objec")
> +#define MDS_FEATURE_INCOMPAT_DIRINODE CompatSet::Feature(4, "dir inode in separate object")
>  
>  class MDSMap {
>  public:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
