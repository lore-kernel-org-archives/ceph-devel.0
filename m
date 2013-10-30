From: Sage Weil <sage@inktank.com>
Subject: Re: [RESEND PATCH] ceph: Fix memory leak in chain_listxattr
Date: Wed, 30 Oct 2013 09:03:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310300903250.23435@cobra.newdream.net>
References: <1383122349-18950-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44627 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3J3QDc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 12:03:32 -0400
In-Reply-To: <1383122349-18950-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org

Hi Li,

Applied both of these.  THanks!

sage

On Wed, 30 Oct 2013, Li Wang wrote:

> Free allocated memory before return
> 
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> ---
>  src/os/chain_xattr.cc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/os/chain_xattr.cc b/src/os/chain_xattr.cc
> index 62733e3..52ae8db 100644
> --- a/src/os/chain_xattr.cc
> +++ b/src/os/chain_xattr.cc
> @@ -355,7 +355,7 @@ int chain_listxattr(const char *fn, char *names, size_t len) {
>  
>    r = sys_listxattr(fn, full_buf, total_len);
>    if (r < 0)
> -    return r;
> +    goto done;
>  
>    char *p = full_buf;
>    const char *end = full_buf + r;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
