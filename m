From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH 0/3] RFC: Enable clients to distinguish busy and
 unreachable OSDs
Date: Thu, 23 Jun 2011 13:05:21 -0600
Message-ID: <4E038E71.1010404@sandia.gov>
References: <1308767187-10376-1-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1106221316310.16816@cobra.newdream.net>
 <Pine.LNX.4.64.1106221354140.16816@cobra.newdream.net>
 <4E034C24.6020103@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:59355 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595Ab1FWTFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2011 15:05:42 -0400
In-Reply-To: <4E034C24.6020103@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Jim Schutt wrote:
> Hi Sage,
> 
> Sage Weil wrote:
>> Hey Jim-
>>
>> I wonder if the below is sufficient, actually.  This avoids any change 
>> on the server side, and just changes the client to start the 
>> per-message timeout "clock" when the message is actually received by 
>> the server...
>> This way we still time out if the request gets stuck in cosd's request 
>> queues somewhere, or if the disk blocks up, or something.  Any 
>> requests that didn't get received don't time out, though.
>>
>> What do you think?
> 
> I like it.  I'm pretty sure you've addressed the
> case I'm after.  Let me give it a try.

Please consider queuing this patch up.

It has greatly increased the S/N ratio in those resets -
I'm still getting a few, and the ones I've looked at
so far don't make sense to me yet.  Probably as I learn
more I'll understand why they should be happening, but
maybe they're the result of bugs; in any event I would
never have noticed them without this patch.

Thanks -- Jim

> 
> Thanks!
> 
> -- Jim
> 
> 
>>
>> sage
>>
>>
>>
>>> From e129e4f3f500f4e77cd1a7c64ff64edc54a9a9ea Mon Sep 17 00:00:00 2001
>> From: Sage Weil <sage@newdream.net>
>> Date: Wed, 22 Jun 2011 13:43:06 -0700
>> Subject: [PATCH] libceph: don't time out osd requests that haven't 
>> been received
>>
>> Keep track of when an outgoing message is ACKed (i.e., the server fully
>> received it and, presumably, queued it for processing).  Time out OSD
>> requests only if it's been too long since they've been received.
>>
>> This prevents timeouts and connection thrashing when the OSDs are simply
>> busy and are throttling the requests they read off the network.
>>
>> Signed-off-by: Sage Weil <sage@newdream.net>
>> ---
>>  include/linux/ceph/messenger.h |    1 +
>>  net/ceph/messenger.c           |   12 +++++-------
>>  net/ceph/osd_client.c          |    6 ++++++
>>  3 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/ceph/messenger.h 
>> b/include/linux/ceph/messenger.h
>> index 31d91a6..d7adf15 100644
>> --- a/include/linux/ceph/messenger.h
>> +++ b/include/linux/ceph/messenger.h
>> @@ -94,6 +94,7 @@ struct ceph_msg {
>>      bool more_to_follow;
>>      bool needs_out_seq;
>>      int front_max;
>> +    unsigned long ack_stamp;        /* tx: when we were acked */
>>  
>>      struct ceph_msgpool *pool;
>>  };
>> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
>> index 78b55f4..c340e2e 100644
>> --- a/net/ceph/messenger.c
>> +++ b/net/ceph/messenger.c
>> @@ -486,13 +486,10 @@ static void prepare_write_message(struct 
>> ceph_connection *con)
>>      m = list_first_entry(&con->out_queue,
>>                 struct ceph_msg, list_head);
>>      con->out_msg = m;
>> -    if (test_bit(LOSSYTX, &con->state)) {
>> -        list_del_init(&m->list_head);
>> -    } else {
>> -        /* put message on sent list */
>> -        ceph_msg_get(m);
>> -        list_move_tail(&m->list_head, &con->out_sent);
>> -    }
>> +
>> +    /* put message on sent list */
>> +    ceph_msg_get(m);
>> +    list_move_tail(&m->list_head, &con->out_sent);
>>  
>>      /*
>>       * only assign outgoing seq # if we haven't sent this message
>> @@ -1399,6 +1396,7 @@ static void process_ack(struct ceph_connection 
>> *con)
>>              break;
>>          dout("got ack for seq %llu type %d at %p\n", seq,
>>               le16_to_cpu(m->hdr.type), m);
>> +        m->ack_stamp = jiffies;
>>          ceph_msg_remove(m);
>>      }
>>      prepare_read_tag(con);
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 7330c27..ce310ee 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -1085,9 +1085,15 @@ static void handle_timeout(struct work_struct 
>> *work)
>>          req = list_entry(osdc->req_lru.next, struct ceph_osd_request,
>>                   r_req_lru_item);
>>  
>> +        /* hasn't been long enough since we sent it? */
>>          if (time_before(jiffies, req->r_stamp + timeout))
>>              break;
>>  
>> +        /* hasn't been long enough since it was acked? */
>> +        if (req->r_request->ack_stamp == 0 ||
>> +            time_before(jiffies, req->r_request->ack_stamp + timeout))
>> +            break;
>> +
>>          BUG_ON(req == last_req && req->r_stamp == last_stamp);
>>          last_req = req;
>>          last_stamp = req->r_stamp;
> 
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


