From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/9] libceph: report socket read/write error message
Date: Mon, 30 Jul 2012 13:37:39 -0500
Message-ID: <5016D473.8010808@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com> <1342831308-18815-4-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40974 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab2G3Shk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 14:37:40 -0400
Received: by gglu4 with SMTP id u4so5161888ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 11:37:40 -0700 (PDT)
In-Reply-To: <1342831308-18815-4-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/20/2012 07:41 PM, Sage Weil wrote:
> We need to set error_msg to something useful before calling ceph_fault();
> do so here for try_{read,write}().  This is more informative than
> 
> libceph: osd0 192.168.106.220:6801 (null)
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/messenger.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 12419a0..7105908 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2291,14 +2291,18 @@ restart:
>  	ret = try_read(con);
>  	if (ret == -EAGAIN)
>  		goto restart;
> -	if (ret < 0)
> +	if (ret < 0) {
> +		con->error_msg = "socket error on read";
>  		goto fault;
> +	}
>  
>  	ret = try_write(con);
>  	if (ret == -EAGAIN)
>  		goto restart;
> -	if (ret < 0)
> +	if (ret < 0) {
> +		con->error_msg = "socket error on write";
>  		goto fault;
> +	}
>  
>  done:
>  	mutex_unlock(&con->mutex);
> 

