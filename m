From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: convert to use le32_add_cpu()
Date: Fri, 28 Sep 2012 08:12:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209280812400.10331@cobra.newdream.net>
References: <CAPgLHd8VSUZnVac+QT5Uvu2STd9KsMCy-G5C5LX6ZpcwO7Lzgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49830 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386Ab2I1PNF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 11:13:05 -0400
In-Reply-To: <CAPgLHd8VSUZnVac+QT5Uvu2STd9KsMCy-G5C5LX6ZpcwO7Lzgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, ceph-devel@vger.kernel.org

Applied, thanks!

On Fri, 28 Sep 2012, Wei Yongjun wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Convert cpu_to_le32(le32_to_cpu(E1) + E2) to use le32_add_cpu().
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  fs/ceph/caps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 620daad..3251e9c 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1005,7 +1005,7 @@ static void __queue_cap_release(struct ceph_mds_session *session,
>  
>  	BUG_ON(msg->front.iov_len + sizeof(*item) > PAGE_CACHE_SIZE);
>  	head = msg->front.iov_base;
> -	head->num = cpu_to_le32(le32_to_cpu(head->num) + 1);
> +	le32_add_cpu(&head->num, 1);
>  	item = msg->front.iov_base + msg->front.iov_len;
>  	item->ino = cpu_to_le64(ino);
>  	item->cap_id = cpu_to_le64(cap_id);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
