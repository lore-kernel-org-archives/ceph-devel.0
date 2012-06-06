From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH] rbd: Clear ceph_msg->bio_iter for retransmitted message
Date: Wed, 06 Jun 2012 09:10:16 -0500
Message-ID: <4FCF64C8.7060506@dreamhost.com>
References: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46817 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab2FFOKL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 10:10:11 -0400
In-Reply-To: <1338969797-8412-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On 06/06/2012 03:03 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> The bug can cause NULL pointer dereference in write_partial_msg_pages

Although this looks simple enough, I want to study it a little more
before committing it.  I've been wanting to walk through this bit
of code anyway so I'll do that today.

One quick observation though:  m->bio_iter really ought to be
initialized only within #ifdef CONFIG_BLOCK (although I see it's
defined without it in the structure definition).  At some point
I'll put together a cleanup patch to do that everywhere; feel free
to do that yourself if you are so inclined.

					-Alex

> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
> ---
>  net/ceph/messenger.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 1a80907..785b953 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -598,6 +598,7 @@ static void prepare_write_message(struct ceph_connection *con)
>  	     le32_to_cpu(con->out_msg->footer.front_crc),
>  	     le32_to_cpu(con->out_msg->footer.middle_crc));
>  
> +	m->bio_iter = NULL;
>  	/* is there a data payload? */
>  	if (le32_to_cpu(m->hdr.data_len) > 0) {
>  		/* initialize page iterator */

