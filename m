From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/3] ceph: messenger: change read_partial() to take "end"
 arg
Date: Mon, 14 May 2012 11:26:26 -0500
Message-ID: <4FB13232.5080901@inktank.com>
References: <4FAC4799.3010903@inktank.com> <4FAC68FF.9020406@inktank.com> <Pine.LNX.4.64.1205121708080.21796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40893 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184Ab2ENQ02 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 12:26:28 -0400
Received: by gglu4 with SMTP id u4so3276446ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 09:26:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205121708080.21796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/12/2012 07:11 PM, Sage Weil wrote:
> This looks correct, but seems like a more confusing calling convention
> to me.  Before this patch it's basically a (start, len) logical
> range in the input stream.. after it's (end, len).  It also seems to be
> more code?

I'm trying to make this code more understandable.  I have this
ongoing confusion with what the meaning of "to" is.  It may be
that it was a "start" position, in which case, "start" might be
a better name, and maybe just renaming it would have been better.

However, another source of confusion here is what the meaning of
this "start" would be versus the meaning of con->in_base_pos.
The actual input position is defined by in_base_pos, while "start"
would represent the start of the partially-filled portion of a
message we're now working on reading.  Where that starts is
irrelevant, and I found the existence of something called "start"
to be distracting and ambiguous.  It's a lot easier to wrap my
head around it by just providing the end position for the read
and leaving out any (other) notion of the "start" position
entirely.

So yes, it expands to a bit more code in the caller but the
result is something I can more easily understand and therefore
believe in.  (I also hope that some later refactoring may make
whatever excess this produces go away, or be less glaring anyway.)

					-Alex

> sage
>
> On Thu, 10 May 2012, Alex Elder wrote:
>
>> Make the second argument to read_partial() be the ending input byte
>> position rather than the beginning offset it now represents.  This
>> amounts to moving the addition "to + size" into the caller.
>>
>> Signed-off-by: Alex Elder<elder@inktank.com>
>> ---
>>   net/ceph/messenger.c |   59
>> ++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 38 insertions(+), 21 deletions(-)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 37fd2ae..364c902 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -992,10 +992,8 @@ static int prepare_read_message(struct ceph_connection
>> *con)
>>
>>
>>   static int read_partial(struct ceph_connection *con,
>> -			int to, int size, void *object)
>> +			int end, int size, void *object)
>>   {
>> -	int end = to + size;
>> -
>>   	while (con->in_base_pos<  end) {
>>   		int left = end - con->in_base_pos;
>>   		int have = size - left;
>> @@ -1013,40 +1011,52 @@ static int read_partial(struct ceph_connection *con,
>>    */
>>   static int read_partial_banner(struct ceph_connection *con)
>>   {
>> -	int ret, to = 0;
>> +	int size;
>> +	int end;
>> +	int ret;
>>
>>   	dout("read_partial_banner %p at %d\n", con, con->in_base_pos);
>>
>>   	/* peer's banner */
>> -	ret = read_partial(con, to, strlen(CEPH_BANNER), con->in_banner);
>> +	size = strlen(CEPH_BANNER);
>> +	end = size;
>> +	ret = read_partial(con, end, size, con->in_banner);
>>   	if (ret<= 0)
>>   		goto out;
>> -	to += strlen(CEPH_BANNER);
>> -	ret = read_partial(con, to, sizeof(con->actual_peer_addr),
>> -			&con->actual_peer_addr);
>> +
>> +	size = sizeof (con->actual_peer_addr);
>> +	end += size;
>> +	ret = read_partial(con, end, size,&con->actual_peer_addr);
>>   	if (ret<= 0)
>>   		goto out;
>> -	to += sizeof(con->actual_peer_addr);
>> -	ret = read_partial(con, to, sizeof(con->peer_addr_for_me),
>> -			&con->peer_addr_for_me);
>> +
>> +	size = sizeof (con->peer_addr_for_me);
>> +	end += size;
>> +	ret = read_partial(con, end, size,&con->peer_addr_for_me);
>>   	if (ret<= 0)
>>   		goto out;
>> +
>>   out:
>>   	return ret;
>>   }
>>
>>   static int read_partial_connect(struct ceph_connection *con)
>>   {
>> -	int ret, to = 0;
>> +	int size;
>> +	int end;
>> +	int ret;
>>
>>   	dout("read_partial_connect %p at %d\n", con, con->in_base_pos);
>>
>> -	ret = read_partial(con, to, sizeof(con->in_reply),&con->in_reply);
>> +	size = sizeof (con->in_reply);
>> +	end = size;
>> +	ret = read_partial(con, end, size,&con->in_reply);
>>   	if (ret<= 0)
>>   		goto out;
>> -	to += sizeof(con->in_reply);
>> -	ret = read_partial(con, to, le32_to_cpu(con->in_reply.authorizer_len),
>> -			   con->auth_reply_buf);
>> +
>> +	size = le32_to_cpu(con->in_reply.authorizer_len);
>> +	end += size;
>> +	ret = read_partial(con, end, size, con->auth_reply_buf);
>>   	if (ret<= 0)
>>   		goto out;
>>
>> @@ -1495,8 +1505,10 @@ static int process_connect(struct ceph_connection *con)
>>    */
>>   static int read_partial_ack(struct ceph_connection *con)
>>   {
>> -	return read_partial(con, 0, sizeof(con->in_temp_ack),
>> -			&con->in_temp_ack);
>> +	int size = sizeof (con->in_temp_ack);
>> +	int end = size;
>> +
>> +	return read_partial(con, end, size,&con->in_temp_ack);
>>   }
>>
>>
>> @@ -1629,6 +1641,8 @@ static int read_partial_message_bio(struct
>> ceph_connection *con,
>>   static int read_partial_message(struct ceph_connection *con)
>>   {
>>   	struct ceph_msg *m = con->in_msg;
>> +	int size;
>> +	int end;
>>   	int ret;
>>   	int to;
>>   	unsigned front_len, middle_len, data_len;
>> @@ -1640,7 +1654,9 @@ static int read_partial_message(struct ceph_connection
>> *con)
>>   	dout("read_partial_message con %p msg %p\n", con, m);
>>
>>   	/* header */
>> -	ret = read_partial(con, 0, sizeof (con->in_hdr),&con->in_hdr);
>> +	size = sizeof (con->in_hdr);
>> +	end = size;
>> +	ret = read_partial(con, end, size,&con->in_hdr);
>>   	if (ret<= 0)
>>   		return ret;
>>
>> @@ -1755,8 +1771,9 @@ static int read_partial_message(struct ceph_connection
>> *con)
>>   	}
>>
>>   	/* footer */
>> -	to = sizeof (m->hdr);
>> -	ret = read_partial(con, to, sizeof (m->footer),&m->footer);
>> +	size = sizeof (m->footer);
>> +	end += size;
>> +	ret = read_partial(con, end, size,&m->footer);
>>   	if (ret<= 0)
>>   		return ret;
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>

