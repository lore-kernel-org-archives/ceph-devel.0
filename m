From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3.6-rc1] libceph: ensure banner is written on client connect
 before feature negotiation starts
Date: Wed, 08 Aug 2012 18:13:29 -0700
Message-ID: <50230EB9.1070302@inktank.com>
References: <1344449378-304-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:38887 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab2HIBNd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 21:13:33 -0400
Received: by ghrr11 with SMTP id r11so1492244ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Aug 2012 18:13:33 -0700 (PDT)
In-Reply-To: <1344449378-304-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On 08/08/2012 11:09 AM, Jim Schutt wrote:
> Because the Ceph client messenger uses a non-blocking connect, it is possible
> for the sending of the client banner to race with the arrival of the banner
> sent by the peer.

This is possible because the server-side messenger immediately sends
its banner and addresses after accepting a connect request, *before*
actually attempting to read or verify the banner from the client.

> When ceph_sock_state_change() notices the connect has completed, it schedules
> work to process the socket via con_work().  During this time the peer is
> writing its banner, and arrival of the peer banner races with con_work().
>
> If con_work() calls try_read() before the peer banner arrives, there is
> nothing for it to do, after which con_work() calls try_write() to send the
> client's banner.  In this case Ceph's protocol negotiation can complete
> succesfully.
>
> If, however, the peer's banner arrives before con_work() calls try_read(),
> then try_read() will read the banner and prepare protocol negotiation info via
> prepare_write_connect().  prepare_write_connect() calls con_out_kvec_reset(),
> which discards the as-yet-unsent client banner.  Next, con_work() calls
> try_write(), which sends the protocol negotiation info rather than the banner
> that the peer is expecting.

I believe your analysis is correct.  And I think your solution sounds
good as well.  I think Sage was going to take a look at this also, and
I'll wait for him to have a chance to comment.  But in any case, your
fix looks good.  Nice job.

Reviewed-by: Alex Elder <elder@inktank.com>

> The result is that the peer sees an invalid banner, and the client reports
> "negotiation failed".
>
> Fix this by moving con_out_kvec_reset() out of prepare_write_connect() to its
> callers at all locations except the one where the banner might still need to
> be sent.
>
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>   net/ceph/messenger.c |   11 +++++++++--
>   1 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index b979675..24c5eea 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -915,7 +915,6 @@ static int prepare_write_connect(struct ceph_connection *con)
>   	con->out_connect.authorizer_len = auth ?
>   		cpu_to_le32(auth->authorizer_buf_len) : 0;
>
> -	con_out_kvec_reset(con);
>   	con_out_kvec_add(con, sizeof (con->out_connect),
>   					&con->out_connect);
>   	if (auth && auth->authorizer_buf_len)
> @@ -1557,6 +1556,7 @@ static int process_connect(struct ceph_connection *con)
>   			return -1;
>   		}
>   		con->auth_retry = 1;
> +		con_out_kvec_reset(con);
>   		ret = prepare_write_connect(con);
>   		if (ret < 0)
>   			return ret;
> @@ -1577,6 +1577,7 @@ static int process_connect(struct ceph_connection *con)
>   		       ENTITY_NAME(con->peer_name),
>   		       ceph_pr_addr(&con->peer_addr.in_addr));
>   		reset_connection(con);
> +		con_out_kvec_reset(con);
>   		ret = prepare_write_connect(con);
>   		if (ret < 0)
>   			return ret;
> @@ -1601,6 +1602,7 @@ static int process_connect(struct ceph_connection *con)
>   		     le32_to_cpu(con->out_connect.connect_seq),
>   		     le32_to_cpu(con->in_reply.connect_seq));
>   		con->connect_seq = le32_to_cpu(con->in_reply.connect_seq);
> +		con_out_kvec_reset(con);
>   		ret = prepare_write_connect(con);
>   		if (ret < 0)
>   			return ret;
> @@ -1617,6 +1619,7 @@ static int process_connect(struct ceph_connection *con)
>   		     le32_to_cpu(con->in_reply.global_seq));
>   		get_global_seq(con->msgr,
>   			       le32_to_cpu(con->in_reply.global_seq));
> +		con_out_kvec_reset(con);
>   		ret = prepare_write_connect(con);
>   		if (ret < 0)
>   			return ret;
> @@ -2135,7 +2138,11 @@ more:
>   		BUG_ON(con->state != CON_STATE_CONNECTING);
>   		con->state = CON_STATE_NEGOTIATING;
>
> -		/* Banner is good, exchange connection info */
> +		/*
> +		 * Received banner is good, exchange connection info.
> +		 * Do not reset out_kvec, as sending our banner raced
> +		 * with receiving peer banner after connect completed.
> +		 */
>   		ret = prepare_write_connect(con);
>   		if (ret < 0)
>   			goto out;
>

