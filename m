From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] libceph: fix oops in ceph_msg_data_pagelist_advance()
Date: Sat, 22 Mar 2014 18:10:30 -0500
Message-ID: <532E1866.4070402@ieee.org>
References: <1395528897-26031-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:37320 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbaCVXKV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Mar 2014 19:10:21 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so3994628iec.37
        for <ceph-devel@vger.kernel.org>; Sat, 22 Mar 2014 16:10:21 -0700 (PDT)
In-Reply-To: <1395528897-26031-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On 03/22/2014 05:54 PM, Yan, Zheng wrote:
> When there is no more data, ceph_msg_data_pagelist_advance() should
> not move on to the next page.

Without looking very hard at this, this looks right.
Does ceph_msg_data_pages_advance() need the same fix?
And ceph_msg_data_bio_advance()?

I'm going to spend a little more time to refresh my
memory on these things.

					-Alex

> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  net/ceph/messenger.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 30efc5c..8859f2e 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1004,6 +1004,9 @@ static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
>  	if (!bytes || cursor->offset & ~PAGE_MASK)
>  		return false;	/* more bytes to process in the current page */
>  
> +	if (!cursor->resid)
> +		return false;   /* no more data */
> +
>  	/* Move on to the next page */
>  
>  	BUG_ON(list_is_last(&cursor->page->lru, &pagelist->head));
> 

