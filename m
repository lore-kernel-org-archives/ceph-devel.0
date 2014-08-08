From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH] libceph: set last_piece in ceph_msg_data_pages_cursor_init()
 correctly
Date: Fri, 8 Aug 2014 10:46:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408081046220.15376@cobra.newdream.net>
References: <1407496707-11641-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55115 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaHHRqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 13:46:38 -0400
In-Reply-To: <1407496707-11641-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 8 Aug 2014, Ilya Dryomov wrote:
> Determining ->last_piece based on the value of ->page_offset + length
> is incorrect because length here is the length of the entire message.
> ->last_piece set to false even if page array data item length is <=
> PAGE_SIZE, which results in invalid length passed to
> ceph_tcp_{send,recv}page() and causes various asserts to fire.
> 
>     # cat pages-cursor-init.sh
>     #!/bin/bash
>     rbd create --size 10 --image-format 2 foo
>     FOO_DEV=$(rbd map foo)
>     dd if=/dev/urandom of=$FOO_DEV bs=1M &>/dev/null
>     rbd snap create foo@snap
>     rbd snap protect foo@snap
>     rbd clone foo@snap bar
>     # rbd_resize calls librbd rbd_resize(), size is in bytes
>     ./rbd_resize bar $(((4 << 20) + 512))
>     rbd resize --size 10 bar
>     BAR_DEV=$(rbd map bar)
>     # trigger a 512-byte copyup -- 512-byte page array data item
>     dd if=/dev/urandom of=$BAR_DEV bs=1M count=1 seek=5
> 
> The problem exists only in ceph_msg_data_pages_cursor_init(),
> ceph_msg_data_pages_advance() does the right thing.  The size_t cast is
> unnecessary.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Looks good!

Reviewed-by: Sage Weil <sage@redhat.com>

> ---
>  net/ceph/messenger.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index e51cad0db580..b2f571dd933d 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -901,7 +901,7 @@ static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
>  	BUG_ON(page_count > (int)USHRT_MAX);
>  	cursor->page_count = (unsigned short)page_count;
>  	BUG_ON(length > SIZE_MAX - cursor->page_offset);
> -	cursor->last_piece = (size_t)cursor->page_offset + length <= PAGE_SIZE;
> +	cursor->last_piece = cursor->page_offset + cursor->resid <= PAGE_SIZE;
>  }
>  
>  static struct page *
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
