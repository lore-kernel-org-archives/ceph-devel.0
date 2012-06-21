From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 09/12] libceph: distinguish two phases of connect sequence
Date: Thu, 21 Jun 2012 13:54:37 -0500
Message-ID: <4FE36DED.9060409@inktank.com>
References: <4FE32C84.2050408@inktank.com> <4FE32E28.8030006@inktank.com> <Pine.LNX.4.64.1206211141460.23422@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56265 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759329Ab2FUSyj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 14:54:39 -0400
Received: by vcbf11 with SMTP id f11so481629vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 11:54:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206211141460.23422@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/21/2012 01:44 PM, Sage Weil wrote:
> I get the feeling that all of these lists of clear/set_bit calls would go 
> away if we
> 
> - verify we are under the mutex at each of these sites
> - replace con->state with an enum
> 
> Is there a reason you stopped short of doing that (besides time)?

Time.

Where I was/am headed is to have functions just like I did with
the connection socket states, in which a function would contain
the state change itself and would verify we're transitioning
from a valid previous state.

I also have been working toward having distinct, non-overlapping
states, which has not really been the case here.

But my approach has been to do all this incrementally, so at each
step along the way it is easy to understand that a particular
change is doing the right thing, and at with each change we can
do regression tests to verify nothing is broken as a result.

I probably have another dozen or more small patches that bring
it even closer, but at this point I'll probably try to trickle
them in as I get little blocks of time.  They need to be looked
at again individually to make sure they still make sense before
I send them out for review.

					-Alex

> sage
> 
> 
> On Thu, 21 Jun 2012, Alex Elder wrote:
> 
>> Currently a ceph connection enters a "CONNECTING" state when it
>> begins the process of (re-)connecting with its peer.  Once the two
>> ends have successfully exchanged their banner and addresses, an
>> additional NEGOTIATING bit is set in the ceph connection's state to
>> indicate the connection information exhange has begun.  The
>> CONNECTING bit/state continues to be set during this phase.
>>
>> Rather than have the CONNECTING state continue while the NEGOTIATING
>> bit is set, interpret these two phases as distinct states.  In other
>> words, when NEGOTIATING is set, clear CONNECTING.  That way only
>> one of them will be active at a time.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>  net/ceph/messenger.c |   48
>> ++++++++++++++++++++++++++----------------------
>>  1 file changed, 26 insertions(+), 22 deletions(-)
>>
>> Index: b/net/ceph/messenger.c
>> ===================================================================
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -1583,7 +1583,6 @@ static int process_connect(struct ceph_c
>>  			return -1;
>>  		}
>>  		clear_bit(NEGOTIATING, &con->state);
>> -		clear_bit(CONNECTING, &con->state);
>>  		set_bit(CONNECTED, &con->state);
>>  		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
>>  		con->connect_seq++;
>> @@ -2025,7 +2024,8 @@ more_kvec:
>>  	}
>>
>>  do_next:
>> -	if (!test_bit(CONNECTING, &con->state)) {
>> +	if (!test_bit(CONNECTING, &con->state) &&
>> +			!test_bit(NEGOTIATING, &con->state)) {
>>  		/* is anything else pending? */
>>  		if (!list_empty(&con->out_queue)) {
>>  			prepare_write_message(con);
>> @@ -2082,25 +2082,29 @@ more:
>>  	}
>>
>>  	if (test_bit(CONNECTING, &con->state)) {
>> -		if (!test_bit(NEGOTIATING, &con->state)) {
>> -			dout("try_read connecting\n");
>> -			ret = read_partial_banner(con);
>> -			if (ret <= 0)
>> -				goto out;
>> -			ret = process_banner(con);
>> -			if (ret < 0)
>> -				goto out;
>> +		dout("try_read connecting\n");
>> +		ret = read_partial_banner(con);
>> +		if (ret <= 0)
>> +			goto out;
>> +		ret = process_banner(con);
>> +		if (ret < 0)
>> +			goto out;
>>
>> -			/* Banner is good, exchange connection info */
>> -			ret = prepare_write_connect(con);
>> -			if (ret < 0)
>> -				goto out;
>> -			prepare_read_connect(con);
>> -			set_bit(NEGOTIATING, &con->state);
>> +		clear_bit(CONNECTING, &con->state);
>> +		set_bit(NEGOTIATING, &con->state);
>>
>> -			/* Send connection info before awaiting response */
>> +		/* Banner is good, exchange connection info */
>> +		ret = prepare_write_connect(con);
>> +		if (ret < 0)
>>  			goto out;
>> -		}
>> +		prepare_read_connect(con);
>> +
>> +		/* Send connection info before awaiting response */
>> +		goto out;
>> +	}
>> +
>> +	if (test_bit(NEGOTIATING, &con->state)) {
>> +		dout("try_read negotiating\n");
>>  		ret = read_partial_connect(con);
>>  		if (ret <= 0)
>>  			goto out;
>> @@ -2222,12 +2226,12 @@ restart:
>>  	if (test_and_clear_bit(SOCK_CLOSED, &con->flags)) {
>>  		if (test_and_clear_bit(CONNECTED, &con->state))
>>  			con->error_msg = "socket closed";
>> -		else if (test_and_clear_bit(CONNECTING, &con->state)) {
>> -			clear_bit(NEGOTIATING, &con->state);
>> +		else if (test_and_clear_bit(NEGOTIATING, &con->state))
>> +			con->error_msg = "negotiation failed";
>> +		else if (test_and_clear_bit(CONNECTING, &con->state))
>>  			con->error_msg = "connection failed";
>> -		} else {
>> +		else
>>  			con->error_msg = "unrecognized con state";
>> -		}
>>  		goto fault;
>>  	}
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 

