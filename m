From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/8] libceph: be less chatty about stray replies
Date: Mon, 30 Jul 2012 18:00:17 -0500
Message-ID: <50171201.40703@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com> <1343663971-3221-2-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40551 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab2G3XAS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:00:18 -0400
Received: by yhmm54 with SMTP id m54so5463162yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 16:00:17 -0700 (PDT)
In-Reply-To: <1343663971-3221-2-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 10:59 AM, Sage Weil wrote:
> There are many (normal) conditions that can lead to us getting
> unexpected replies, include cluster topology changes, osd failures,
> and timeouts.  There's no need to spam the console about it.
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/osd_client.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index ad427e6..42119c0 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2037,8 +2037,8 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
>  	if (!req) {
>  		*skip = 1;
>  		m = NULL;
> -		pr_info("get_reply unknown tid %llu from osd%d\n", tid,
> -			osd->o_osd);
> +		dout("get_reply unknown tid %llu from osd%d\n", tid,
> +		     osd->o_osd);
>  		goto out;
>  	}
>  
> 

