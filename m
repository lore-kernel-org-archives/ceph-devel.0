From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: initialize data fields on last msg put
Date: Fri, 29 Mar 2013 11:28:31 -0700
Message-ID: <5155DD4F.70704@inktank.com>
References: <515081D0.4080405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37025 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312Ab3C2SeF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 14:34:05 -0400
Received: by mail-pd0-f170.google.com with SMTP id 4so357023pdd.15
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 11:34:03 -0700 (PDT)
In-Reply-To: <515081D0.4080405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 03/25/2013 09:56 AM, Alex Elder wrote:
> (This patch is available in branch "review/wip-4540" of the
> ceph-client git repository, which is based on the current
> "testing" branch.)
>
> When the last reference to a ceph message is dropped,
> ceph_msg_last_put() is called to clean things up.  For "normal"
> messages (allocated via ceph_msg_new() rather than being allocated
> from a memory pool) it's sufficient to just release resources.  But
> for a mempool-allocated message we actually have to re-initialize
> the data fields in the message back to initial state so they're
> ready to go in the event the message gets reused.
>
> Some of this was already done; this fleshes it out so it's done
> more completely.
>
> This resolves:
>      http://tracker.ceph.com/issues/4540
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/messenger.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 997dacc..2ccbd189 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3299,12 +3299,17 @@ void ceph_msg_last_put(struct kref *kref)
>   	if (ceph_msg_has_pages(m)) {
>   		m->p.length = 0;
>   		m->p.pages = NULL;
> +		m->p.type = CEPH_OSD_DATA_TYPE_NONE;
>   	}
> -
>   	if (ceph_msg_has_pagelist(m)) {
>   		ceph_pagelist_release(m->l.pagelist);
>   		kfree(m->l.pagelist);
>   		m->l.pagelist = NULL;
> +		m->l.type = CEPH_OSD_DATA_TYPE_NONE;
> +	}
> +	if (ceph_msg_has_bio(m)) {
> +		m->b.bio = NULL;
> +		m->b.type = CEPH_OSD_DATA_TYPE_NONE;
>   	}
>
>   	if (m->pool)
>

