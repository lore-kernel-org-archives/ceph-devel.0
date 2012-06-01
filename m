From: Alex Elder <elder@inktank.com>
Subject: Fwd: Re: [PATCH 04/13] libceph: rename socket callbacks
Date: Fri, 01 Jun 2012 07:03:09 -0500
Message-ID: <4FC8AF7D.7070707@inktank.com>
References: <4FC8AECA.7050004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40042 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab2FAMDG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 08:03:06 -0400
Received: by yenm10 with SMTP id m10so1645715yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jun 2012 05:03:05 -0700 (PDT)
In-Reply-To: <4FC8AECA.7050004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Forgot to "reply-all" my response.	-Alex

-------- Original Message --------
Subject: Re: [PATCH 04/13] libceph: rename socket callbacks
Date: Fri, 01 Jun 2012 07:00:10 -0500
From: Alex Elder <elder@inktank.com>
To: Sage Weil <sage@inktank.com>

On 05/31/2012 11:02 PM, Sage Weil wrote:
> On Wed, 30 May 2012, Alex Elder wrote:
>> Change the names of the three socket callback functions to make it
>> more obvious they're specifically associated with a connection's
>> socket (not the ceph connection that uses it).
>>
>> Signed-off-by: Alex Elder<elder@inktank.com>
>> ---
>>   net/ceph/messenger.c |   28 ++++++++++++++--------------
>>   1 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index fe3c2a1..5ad1f0a 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -153,46 +153,46 @@ EXPORT_SYMBOL(ceph_msgr_flush);
>>    */
>>
>>   /* data available on socket, or listen socket received a connect */
>> -static void ceph_data_ready(struct sock *sk, int count_unused)
>> +static void ceph_sock_data_ready(struct sock *sk, int count_unused)
>>   {
>>   	struct ceph_connection *con = sk->sk_user_data;
>>
>>   	if (sk->sk_state != TCP_CLOSE_WAIT) {
>> -		dout("ceph_data_ready on %p state = %lu, queueing work\n",
>> +		dout("%s on %p state = %lu, queueing work\n", __func__,
>
> I think it's marginally better to do
>
> 		dout(__func__ " on %p state = %lu, queueing work\n",
>
> so that the concatenation happens at compile-time instead of runtime.

I think that's a good idea, but we can't assume __func__ is in fact
a constant, can we?  __LINE__ and __FILE__ are, but I think __func__
is named lower case to emphasize that it is not a string literal but
a variable.  And this concatenation only works for string literals.

					-Alex

> Otherwise, looks good!
>
> Reviewed-by: Sage Weil<sage@inktank.com>
>
>>   		con, con->state);
>>   		queue_con(con);
>>   	}
>>   }
>>
>>   /* socket has buffer space for writing */
>> -static void ceph_write_space(struct sock *sk)
>> +static void ceph_sock_write_space(struct sock *sk)
>>   {
>>   	struct ceph_connection *con = sk->sk_user_data;
>>
>>   	/* only queue to workqueue if there is data we want to write,
>>   	 * and there is sufficient space in the socket buffer to accept
>> -	 * more data.  clear SOCK_NOSPACE so that ceph_write_space()
>> +	 * more data.  clear SOCK_NOSPACE so that ceph_sock_write_space()
>>   	 * doesn't get called again until try_write() fills the socket
>>   	 * buffer. See net/ipv4/tcp_input.c:tcp_check_space()
>>   	 * and net/core/stream.c:sk_stream_write_space().
>>   	 */
>>   	if (test_bit(WRITE_PENDING,&con->state)) {
>>   		if (sk_stream_wspace(sk)>= sk_stream_min_wspace(sk)) {
>> -			dout("ceph_write_space %p queueing write work\n",
>> con);
>> +			dout("%s %p queueing write work\n", __func__, con);
>>   			clear_bit(SOCK_NOSPACE,&sk->sk_socket->flags);
>>   			queue_con(con);
>>   		}
>>   	} else {
>> -		dout("ceph_write_space %p nothing to write\n", con);
>> +		dout("%s %p nothing to write\n", __func__, con);
>>   	}
>>   }
>>
>>   /* socket's state has changed */
>> -static void ceph_state_change(struct sock *sk)
>> +static void ceph_sock_state_change(struct sock *sk)
>>   {
>>   	struct ceph_connection *con = sk->sk_user_data;
>>
>> -	dout("ceph_state_change %p state = %lu sk_state = %u\n",
>> +	dout("%s %p state = %lu sk_state = %u\n", __func__,
>>   	     con, con->state, sk->sk_state);
>>
>>   	if (test_bit(CLOSED,&con->state))
>> @@ -200,9 +200,9 @@ static void ceph_state_change(struct sock *sk)
>>
>>   	switch (sk->sk_state) {
>>   	case TCP_CLOSE:
>> -		dout("ceph_state_change TCP_CLOSE\n");
>> +		dout("%s TCP_CLOSE\n", __func__);
>>   	case TCP_CLOSE_WAIT:
>> -		dout("ceph_state_change TCP_CLOSE_WAIT\n");
>> +		dout("%s TCP_CLOSE_WAIT\n", __func__);
>>   		if (test_and_set_bit(SOCK_CLOSED,&con->state) == 0) {
>>   			if (test_bit(CONNECTING,&con->state))
>>   				con->error_msg = "connection failed";
>> @@ -212,7 +212,7 @@ static void ceph_state_change(struct sock *sk)
>>   		}
>>   		break;
>>   	case TCP_ESTABLISHED:
>> -		dout("ceph_state_change TCP_ESTABLISHED\n");
>> +		dout("%s TCP_ESTABLISHED\n", __func__);
>>   		queue_con(con);
>>   		break;
>>   	default:	/* Everything else is uninteresting */
>> @@ -228,9 +228,9 @@ static void set_sock_callbacks(struct socket *sock,
>>   {
>>   	struct sock *sk = sock->sk;
>>   	sk->sk_user_data = con;
>> -	sk->sk_data_ready = ceph_data_ready;
>> -	sk->sk_write_space = ceph_write_space;
>> -	sk->sk_state_change = ceph_state_change;
>> +	sk->sk_data_ready = ceph_sock_data_ready;
>> +	sk->sk_write_space = ceph_sock_write_space;
>> +	sk->sk_state_change = ceph_sock_state_change;
>>   }
>>
>>
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>

