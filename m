From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 5/8] libceph: define and use in_msg_pos_next()
Date: Mon, 11 Mar 2013 14:16:44 -0500
Message-ID: <513E2D9C.2030104@inktank.com>
References: <513B5116.2020305@inktank.com> <513B51E5.6080503@inktank.com> <513E28FC.8060608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:59796 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab3CKTQs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 15:16:48 -0400
Received: by mail-ve0-f169.google.com with SMTP id 15so3028465vea.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 12:16:47 -0700 (PDT)
In-Reply-To: <513E28FC.8060608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/11/2013 01:57 PM, Josh Durgin wrote:
> On 03/09/2013 07:14 AM, Alex Elder wrote:
>> Define a new function in_msg_pos_next() to match out_msg_pos_next(),
>> and use it in place of code at the end of read_partial_message_pages()
>> and read_partial_message_bio().
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   net/ceph/messenger.c |   57
>> ++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 2017b88..fb5f6e7 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -1052,6 +1052,28 @@ static void out_msg_pos_next(struct
>> ceph_connection *con, struct page *page,
>>   #endif
>>   }
>>
>> +static void in_msg_pos_next(struct ceph_connection *con, size_t len,
>> +                size_t received)
>> +{
>> +    struct ceph_msg *msg = con->in_msg;
>> +
>> +    BUG_ON(!msg);
>> +    BUG_ON(!received);
>> +
>> +    con->in_msg_pos.data_pos += received;
>> +    con->in_msg_pos.page_pos += received;
>> +    if (received < len)
>> +        return;
> 
> This is different from the condition in read_partial_message_pages()
> case, which only increments in_msg_pos.page and resets page_pos when
> page_pos == PAGE_SIZE. Maybe this is equivalent, but if so it's not
> obvious.

You are correct.  And, despite my usual thoroughness and
verbosity, I didn't explain this one.

This message position structure (in_msg_pos) is tracking
how much of the message has been consumed.  Each time a
an incoming message is going to arrive, we find out how
much room is left--not surpassing the current page--and
provide that as the "len" (number of bytes) to receive:

      left = min((int)(data_len - con->in_msg_pos.data_pos),
             (int)(bv->bv_len - con->in_msg_pos.page_pos));

This is saying the amount we'll use is the lesser of:
- all that's left of the entire request
- all that's left in the current page

The number of bytes received is then used, along with
the "len" value, to determine how to advance the position.
If we received exactly how many were requested, we either
reached the end of the request or the end of the page.
In the first case, we're done, in the second, we move
onto the next page in the array.

In all cases but (possibly) on the last page, after adding
the number of bytes received, page_pos == PAGE_SIZE.  On the
last page, it doesn't really matter whether we increment
the page number and reset the page position, because we're
done and we won't come back here again.  The code previously
skipped over that last case, basically.  The new code
handles that case the same as the others, incrementing
and resetting.

So the short answer is, they are still equivalent.  And
I agree, it is not obvious.

If you are satisfied, I can add the above (or maybe an
abbreviated form of it) to the commit message.

					-Alex

>> +
>> +    BUG_ON(received != len);
>> +    con->in_msg_pos.page_pos = 0;
>> +    con->in_msg_pos.page++;
>> +#ifdef CONFIG_BLOCK
>> +    if (msg->bio)
>> +        iter_bio_next(&msg->bio_iter, &msg->bio_seg);
>> +#endif /* CONFIG_BLOCK */
>> +}
>> +
>>   /*
>>    * Write as much message data payload as we can.  If we finish, queue
>>    * up the footer.
>> @@ -1789,6 +1811,7 @@ static int read_partial_message_pages(struct
>> ceph_connection *con,
>>                         struct page **pages,
>>                         unsigned int data_len, bool do_datacrc)
>>   {
>> +    struct page *page;
>>       void *p;
>>       int ret;
>>       int left;
>> @@ -1797,22 +1820,18 @@ static int read_partial_message_pages(struct
>> ceph_connection *con,
>>              (int)(PAGE_SIZE - con->in_msg_pos.page_pos));
>>       /* (page) data */
>>       BUG_ON(pages == NULL);
>> -    p = kmap(pages[con->in_msg_pos.page]);
>> -    ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos,
>> -                   left);
>> +    page = pages[con->in_msg_pos.page];
>> +    p = kmap(page);
>> +    ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos,
>> left);
>>       if (ret > 0 && do_datacrc)
>>           con->in_data_crc =
>>               crc32c(con->in_data_crc,
>>                     p + con->in_msg_pos.page_pos, ret);
>> -    kunmap(pages[con->in_msg_pos.page]);
>> +    kunmap(page);
>>       if (ret <= 0)
>>           return ret;
>> -    con->in_msg_pos.data_pos += ret;
>> -    con->in_msg_pos.page_pos += ret;
>> -    if (con->in_msg_pos.page_pos == PAGE_SIZE) {
>> -        con->in_msg_pos.page_pos = 0;
>> -        con->in_msg_pos.page++;
>> -    }
>> +
>> +    in_msg_pos_next(con, left, ret);
>>
>>       return ret;
>>   }
>> @@ -1823,32 +1842,30 @@ static int read_partial_message_bio(struct
>> ceph_connection *con,
>>   {
>>       struct ceph_msg *msg = con->in_msg;
>>       struct bio_vec *bv;
>> +    struct page *page;
>>       void *p;
>>       int ret, left;
>>
>>       BUG_ON(!msg);
>>       BUG_ON(!msg->bio_iter);
>>       bv = bio_iovec_idx(msg->bio_iter, msg->bio_seg);
>> +
>>       left = min((int)(data_len - con->in_msg_pos.data_pos),
>>              (int)(bv->bv_len - con->in_msg_pos.page_pos));
>>
>> -    p = kmap(bv->bv_page) + bv->bv_offset;
>> +    page = bv->bv_page;
>> +    p = kmap(page) + bv->bv_offset;
>>
>> -    ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos,
>> -                   left);
>> +    ret = ceph_tcp_recvmsg(con->sock, p + con->in_msg_pos.page_pos,
>> left);
>>       if (ret > 0 && do_datacrc)
>>           con->in_data_crc =
>>               crc32c(con->in_data_crc,
>>                     p + con->in_msg_pos.page_pos, ret);
>> -    kunmap(bv->bv_page);
>> +    kunmap(page);
>>       if (ret <= 0)
>>           return ret;
>> -    con->in_msg_pos.data_pos += ret;
>> -    con->in_msg_pos.page_pos += ret;
>> -    if (con->in_msg_pos.page_pos == bv->bv_len) {
>> -        con->in_msg_pos.page_pos = 0;
>> -        iter_bio_next(&msg->bio_iter, &msg->bio_seg);
>> -    }
>> +
>> +    in_msg_pos_next(con, left, ret);
>>
>>       return ret;
>>   }
>>
> 

