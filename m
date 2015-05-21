From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 1/5] libceph: nuke time_sub()
Date: Thu, 21 May 2015 07:40:25 -0500
Message-ID: <555DD239.2010308@ieee.org>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com> <1432211706-10473-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35236 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbbEUMk0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 08:40:26 -0400
Received: by iesa3 with SMTP id a3so6995942ies.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 05:40:26 -0700 (PDT)
In-Reply-To: <1432211706-10473-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

On 05/21/2015 07:35 AM, Ilya Dryomov wrote:
> Unused since ceph got merged into mainline I guess.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  include/linux/ceph/libceph.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> index 30f92cefaa72..85ae9a889a3f 100644
> --- a/include/linux/ceph/libceph.h
> +++ b/include/linux/ceph/libceph.h
> @@ -93,15 +93,6 @@ enum {
>  	CEPH_MOUNT_SHUTDOWN,
>  };
>  
> -/*
> - * subtract jiffies
> - */
> -static inline unsigned long time_sub(unsigned long a, unsigned long b)
> -{
> -	BUG_ON(time_after(b, a));
> -	return (long)a - (long)b;
> -}
> -
>  struct ceph_mds_client;
>  
>  /*
> 

