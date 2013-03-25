From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 6/6] libceph: verify authorizer reply
Date: Mon, 25 Mar 2013 09:41:19 -0500
Message-ID: <5150620F.7010709@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com> <1363734486-26879-6-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38560 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757257Ab3CYOlS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 10:41:18 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so5983605ieb.14
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 07:41:17 -0700 (PDT)
In-Reply-To: <1363734486-26879-6-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/19/2013 06:08 PM, Sage Weil wrote:
> The 'cephx' auth protocol provides mutual authenticate for client and
> server.  However, as the client, we were not verifying that the server
> auth reply was in fact authentic.  Although the infrastructure to do so was
> all in place, we neglected to actually call the function to do it.  Fix!
> 
> This resolves http://tracker.ceph.com/issues/2429.

I can't comment on the correctness of putting this check here
(but it looks reasonable to me).  But the patch looks good.
Minor comments for you to consider below, but otherwise:

Reviewed-by: Alex Elder <elder@inktank.com>

> Reported-by: Alex Elder <elder@inktank.com>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/messenger.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 19af956..664adb1 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1954,10 +1954,27 @@ static int process_connect(struct ceph_connection *con)
>  	u64 sup_feat = con->msgr->supported_features;
>  	u64 req_feat = con->msgr->required_features;
>  	u64 server_feat = le64_to_cpu(con->in_reply.features);
> +	int authorizer_len = le32_to_cpu(con->in_reply.authorizer_len);
>  	int ret;
>  
>  	dout("process_connect on %p tag %d\n", con, (int)con->in_tag);
>  
> +	if (authorizer_len && con->ops->verify_authorizer_reply) {

Don't bother checking the method pointer, use the helper
below instead.

> +		mutex_unlock(&con->mutex);
> +		ret = con->ops->verify_authorizer_reply(con, authorizer_len);

Use the helper function.

> +		mutex_lock(&con->mutex);
> +		if (con->state != CON_STATE_NEGOTIATING)
> +			return -EAGAIN;

An assertion that we were in that state before dropping the
mutex would communicate to the reader why we're making this
particular check here.

> +		if (ret < 0) {
> +			pr_err("%s%lld %s bad authorizer reply, failed to"
> +			       " authenticate server\n",
> +			       ENTITY_NAME(con->peer_name),
> +			       ceph_pr_addr(&con->peer_addr.in_addr));
> +			con->error_msg = "failed to authenticate server";
> +			return -1;
> +		}
> +	}
> +
>  	switch (con->in_reply.tag) {
>  	case CEPH_MSGR_TAG_FEATURES:
>  		pr_err("%s%lld %s feature set mismatch,"
> 

