From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] radosgw: Remove PHP setting from VirtualHost documentation
Date: Thu, 7 Apr 2011 14:36:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104071436070.18507@cobra.newdream.net>
References: <1302171814-7959-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47994 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab1DGVcy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 17:32:54 -0400
In-Reply-To: <1302171814-7959-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

sage

On Thu, 7 Apr 2011, Wido den Hollander wrote:

> 
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
>  man/radosgw.8 |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/man/radosgw.8 b/man/radosgw.8
> index 3eab509..316f5f2 100644
> --- a/man/radosgw.8
> +++ b/man/radosgw.8
> @@ -33,7 +33,6 @@ An apache example configuration for using the RADOS gateway:
>  
>    <IfModule mod_fcgid.c>
>      SuexecUserGroup web1 web1
> -    PHP_Fix_Pathinfo_Enable 1
>      <Directory /var/www/web1/web/>
>        Options +ExecCGI
>        AllowOverride All
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
