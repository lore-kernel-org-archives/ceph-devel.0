From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] libceph: set last_piece in ceph_msg_data_pages_cursor_init()
 correctly
Date: Fri, 08 Aug 2014 15:59:56 -0500
Message-ID: <53E53A4C.9000306@ieee.org>
References: <1407496707-11641-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61626 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528AbaHHU75 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 16:59:57 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so7013205iec.31
        for <ceph-devel@vger.kernel.org>; Fri, 08 Aug 2014 13:59:56 -0700 (PDT)
In-Reply-To: <1407496707-11641-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 08/08/2014 06:18 AM, Ilya Dryomov wrote:
> Determining ->last_piece based on the value of ->page_offset + length
> is incorrect because length here is the length of the entire message.
> ->last_piece set to false even if page array data item length is <=
> PAGE_SIZE, which results in invalid length passed to
> ceph_tcp_{send,recv}page() and causes various asserts to fire.

I glanced at this this morning and thought it might have
a problem.  Now that I've had the time to look at it a
little more closely I conclude it's fine.

I'm going to explain my reasoning, which just reaffirms what
you've explained. (Doing this helps me brush up on things,
I'm starting to get rusty...)

A message has a list of data items, and a data item is
broken into pieces, each of which (for a pages data item)
holds data from a single page.  A cursor keeps the data item
now being processed in cursor->data, and cursor->resid is the
number of un-consumed bytes in the current data item.  We want
to set cursor->last_piece when the next piece to process is
the last in the *data item*, not the last in the *message*,
so we need to compare against cursor->resid, not the message
length.

Before your change, any message with more than one data
item including a page array data item that was not last
in the list would have problems.

So in summary:  Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

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
> 

