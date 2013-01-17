From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH REPOST 1/2] rbd: encapsulate handling for a single request
Date: Thu, 17 Jan 2013 15:01:33 -0600
Message-ID: <50F866AD.4030802@inktank.com>
References: <50E6094F.9080101@inktank.com> <50E60981.2090801@inktank.com> <50F5EA25.2070303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41806 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab3AQVBh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 16:01:37 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so773882iad.5
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 13:01:36 -0800 (PST)
In-Reply-To: <50F5EA25.2070303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/15/2013 05:45 PM, Josh Durgin wrote:
> On 01/03/2013 02:43 PM, Alex Elder wrote:
>> In rbd_rq_fn(), requests are fetched from the block layer and each
>> request is processed, looping through the request's list of bio's
>> until they've all been consumed.
>>
>> Separate the handling for a single request into its own function to
>> make it a bit easier to see what's going on.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---

. . .

>> -
>> -        spin_lock_irq(q->queue_lock);
>> -
>> +        result = rbd_dev_do_request(rq, rbd_dev, snapc, ofs, size, bio);
>>           ceph_put_snap_context(snapc);
>> +        spin_lock_irq(q->queue_lock);
>> +        if (result < 0)
> 
> result may be 0 if num_segs == 0, which will make the request hang.
> I'm not sure if this will happen (or is even possible), but it's
> different from the previous behavior, which called
> __blk_end_request_all() in this case as well.

You're right.  And I think there may be some valid special
zero-length requests (like cache flush requests or something).

The value of num_segs comes from rbd_get_num_segments().  The
only way that will ever return 0 is if the len it is provided
is 0.

So my fix will be to change the check after the spin_lock_irq()
call from this:
	if (result < 0)
to this:
	if (!size || result < 0)

I'll re-post the result shortly.

					-Alex

>> +            __blk_end_request_all(rq, result);
>>       }
>>   }
>>
> 

