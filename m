From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: flush dcache after zeroing page data
Date: Thu, 23 May 2013 11:54:04 -0700
Message-ID: <519E65CC.3060208@inktank.com>
References: <519E0781.4000603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:43239 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758494Ab3EWSza (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 14:55:30 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so3257914pbc.32
        for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 11:55:29 -0700 (PDT)
In-Reply-To: <519E0781.4000603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/23/2013 05:11 AM, Alex Elder wrote:
> Neither zero_bio_chain() nor zero_pages() contains a call to flush
> caches after zeroing a portion of a page.  This can cause problems
> on architectures that have caches that allow virtual address
> aliasing.
>
> This resolves:
>      http://tracker.ceph.com/issues/4777
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6e377a0..f860dd6 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1124,6 +1124,7 @@ static void zero_bio_chain(struct bio *chain, int
> start_ofs)
>   				buf = bvec_kmap_irq(bv, &flags);
>   				memset(buf + remainder, 0,
>   				       bv->bv_len - remainder);
> +				flush_dcache_page(bv->bv_page);
>   				bvec_kunmap_irq(buf, &flags);
>   			}
>   			pos += bv->bv_len;
> @@ -1156,6 +1157,7 @@ static void zero_pages(struct page **pages, u64
> offset, u64 end)
>   		local_irq_save(flags);
>   		kaddr = kmap_atomic(*page);
>   		memset(kaddr + page_offset, 0, length);
> +		flush_dcache_page(*page);
>   		kunmap_atomic(kaddr);
>   		local_irq_restore(flags);
>

