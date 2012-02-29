From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] net/ceph: Only clear SOCK_NOSPACE when there is
 sufficient space in the socket buffer
Date: Wed, 29 Feb 2012 08:30:58 -0700
Message-ID: <4F4E44B2.3040707@sandia.gov>
References: <1328111989-10191-1-git-send-email-jaschut@sandia.gov>
 <1328234852.21405.66.camel@doink>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:54837 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031159Ab2B2PbO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 10:31:14 -0500
In-Reply-To: <1328234852.21405.66.camel@doink>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@dreamhost.com
Cc: ceph-devel@vger.kernel.org

Hi Alex,

On 02/02/2012 07:07 PM, Alex Elder wrote:
> On Wed, 2012-02-01 at 08:59 -0700, Jim Schutt wrote:
>> The Ceph messenger would sometimes queue multiple work items to write
>> data to a socket when the socket buffer was full.
>>
>> Fix this problem by making ceph_write_space() use SOCK_NOSPACE in the
>> same way that net/core/stream.c:sk_stream_write_space() does, i.e.,
>> clearing it only when sufficient space is available in the socket buffer.
>>
>> Signed-off-by: Jim Schutt<jaschut@sandia.gov>
>
> This looks good to me.  You are avoiding queueing more
> messages if the amount of free space for writing is
> less than the minimum.  And if not, you leave the
> SOCK_NOSPACE flag alone.
>
> My only general thought on looking at this is that
> this is using instantaneous space available in a
> socket send buffer to make a decision on whether
> to add something to a workqueue, whose work item
> *may* put something into the send buffer.  By the
> time the work item actually runs, the state of
> the socket may be very different.
>
> Still, this is an improvement and at this point I
> am not in a position to suggest anything that
> would close the gap.
>
> Reviewed-by: Alex Elder<elder@dreamhost.com>

Do you think this is worth sending upstream?

Do I need to to something more, or are you willing
to add it to your ceph-client for-review branch?

Thanks -- Jim

>
>
>> ---
>>   net/ceph/messenger.c |   18 ++++++++++++------
>>   1 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 67973f0..a4df90b 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -175,16 +175,22 @@ static void ceph_write_space(struct sock *sk)
>>   	struct ceph_connection *con =
>>   		(struct ceph_connection *)sk->sk_user_data;
>>
>> -	/* only queue to workqueue if there is data we want to write. */
>> +	/* only queue to workqueue if there is data we want to write,
>> +	 * and there is sufficient space in the socket buffer to accept
>> +	 * more data.  clear SOCK_NOSPACE so that ceph_write_space()
>> +	 * doesn't get called again until try_write() fills the socket
>> +	 * buffer. See net/ipv4/tcp_input.c:tcp_check_space()
>> +	 * and net/core/stream.c:sk_stream_write_space().
>> +	 */
>>   	if (test_bit(WRITE_PENDING,&con->state)) {
>> -		dout("ceph_write_space %p queueing write work\n", con);
>> -		queue_con(con);
>> +		if (sk_stream_wspace(sk)>= sk_stream_min_wspace(sk)) {
>> +			dout("ceph_write_space %p queueing write work\n", con);
>> +			clear_bit(SOCK_NOSPACE,&sk->sk_socket->flags);
>> +			queue_con(con);
>> +		}
>>   	} else {
>>   		dout("ceph_write_space %p nothing to write\n", con);
>>   	}
>> -
>> -	/* since we have our own write_space, clear the SOCK_NOSPACE flag */
>> -	clear_bit(SOCK_NOSPACE,&sk->sk_socket->flags);
>>   }
>>
>>   /* socket's state has changed */
>
>
>
>
>


