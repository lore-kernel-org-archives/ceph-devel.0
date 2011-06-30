From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] obsync: Depend on python-lxml on Debian derived platforms
Date: Thu, 30 Jun 2011 10:03:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106301002590.8563@cobra.newdream.net>
References: <1309432032-12859-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53915 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab1F3RAP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 13:00:15 -0400
In-Reply-To: <1309432032-12859-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Thanks, applied!

On Thu, 30 Jun 2011, Wido den Hollander wrote:

> 
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
>  debian/control |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/debian/control b/debian/control
> index aba948c..612870b 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -289,7 +289,7 @@ Description: debugging symbols for radosgw
>  
>  Package: obsync
>  Architecture: linux-any
> -Depends: ${misc:Depends}, python, python-boto, python-ceph, python-xattr
> +Depends: ${misc:Depends}, python, python-boto, python-ceph, python-xattr, python-lxml
>  Description: synchronize data between cloud object storage providers or a local directory
>   obsync is a tool to synchronize objects between cloud object
>   storage providers, such as Amazon S3 (or compatible services), a
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
