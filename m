From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 4/4] libceph: use sizeof_footer() in ceph_msg_revoke()
Date: Sat, 20 Feb 2016 13:56:21 -0600
Message-ID: <56C8C4E5.3000408@ieee.org>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
 <1455986729-12544-5-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:32890 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbcBTT4X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 14:56:23 -0500
Received: by mail-io0-f171.google.com with SMTP id z135so142324151iof.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 11:56:23 -0800 (PST)
In-Reply-To: <1455986729-12544-5-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/messenger.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index dd7c1b7f932b..43edf897c9eb 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3085,10 +3085,7 @@ void ceph_msg_revoke(struct ceph_msg *msg)
>  			con->out_skip += con_out_kvec_skip(con);
>  		} else {
>  			BUG_ON(!msg->data_length);
> -			if (con->peer_features & CEPH_FEATURE_MSG_AUTH)
> -				con->out_skip += sizeof(msg->footer);
> -			else
> -				con->out_skip += sizeof(msg->old_footer);
> +			con->out_skip += sizeof_footer(con);
>  		}
>  		/* data, middle, front */
>  		if (msg->data_length)
> 

