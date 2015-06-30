From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH] crush: fix a bug in tree bucket decode
Date: Tue, 30 Jun 2015 09:09:52 -0700
Message-ID: <5592BF50.3030504@redhat.com>
References: <1435598272-44621-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42317 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbbF3QJw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 12:09:52 -0400
In-Reply-To: <1435598272-44621-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 06/29/2015 10:17 AM, Ilya Dryomov wrote:
> struct crush_bucket_tree::num_nodes is u8, so ceph_decode_8_safe()
> should be used.  -Wconversion catches this, but I guess it went
> unnoticed in all the noise it spews.  The actual problem (at least for
> common crushmaps) isn't the u32 -> u8 truncation though - it's the
> advancement by 4 bytes insead of 1 in the crushmap buffer.
>
> Fixes: http://tracker.ceph.com/issues/2759
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>   net/ceph/osdmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 15796696d64e..4a3125836b64 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -89,7 +89,7 @@ static int crush_decode_tree_bucket(void **p, void *end,
>   {
>   	int j;
>   	dout("crush_decode_tree_bucket %p to %p\n", *p, end);
> -	ceph_decode_32_safe(p, end, b->num_nodes, bad);
> +	ceph_decode_8_safe(p, end, b->num_nodes, bad);
>   	b->node_weights = kcalloc(b->num_nodes, sizeof(u32), GFP_NOFS);
>   	if (b->node_weights == NULL)
>   		return -ENOMEM;
>

Reviewed-by: Josh Durgin <jdurgin@redhat.com>
