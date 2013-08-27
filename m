From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: fix I/O error propagation for reads
Date: Tue, 27 Aug 2013 00:19:22 -0700
Message-ID: <521C52FA.6070801@inktank.com>
References: <1377567242-25736-1-git-send-email-josh.durgin@inktank.com> <521C1CB2.6090008@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35456 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab3H0HR4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 03:17:56 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so4347067obc.35
        for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 00:17:56 -0700 (PDT)
In-Reply-To: <521C1CB2.6090008@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: ceph-devel@vger.kernel.org

On 08/26/2013 08:27 PM, Mike Dawson wrote:
> Josh,
>
> The original bug is marked as krbd, but could this bug could affect rbd
> volumes mounted via qemu as well? If so, could you describe how it might
> block a qemu guest?

No, this is just a patch for the kernel rbd driver, which doesn't
affect qemu at all.

> We've been fighting i/o issues on some of our guests for some time. With
> qemu 1.4.0, we saw the entire guest freeze. But now with qemu 1.5.2
> which includes your asynchronous flush patch, the issue is typified by
> periodic dips in performance and high latency (especially for reads, it
> seems). Could this bug be related?

A good next step for tracking this down would be narrowing in on the
source of the periods of high latency - starting with whether they're
primarily coming from the server or client side. Since it's especially
reads, I'd guess it's more likely to be an osd-side issue. If you look
at the admin socket's dump_historic_ops do you see higher op durations
around the dips in performance? What about any correlation with
underlying disk stats from iostat -x?

> Thanks,
> Mike Dawson
>
>
> On 8/26/2013 9:34 PM, Josh Durgin wrote:
>> When a request returns an error, the driver needs to report the entire
>> extent of the request as completed.  Writes already did this, since
>> they always set xferred = length, but reads were skipping that step if
>> an error other than -ENOENT occurred.  Instead, rbd would end up
>> passing 0 xferred to blk_end_request(), which would always report
>> needing more data.  This resulted in an assert failing when more data
>> was required by the block layer, but all the object requests were
>> done:
>>
>> [ 1868.719077] rbd: obj_request read result -108 xferred 0
>> [ 1868.719077]
>> [ 1868.719518] end_request: I/O error, dev rbd1, sector 0
>> [ 1868.719739]
>> [ 1868.719739] Assertion failure in rbd_img_obj_callback() at line 1736:
>> [ 1868.719739]
>> [ 1868.719739]   rbd_assert(more ^ (which ==
>> img_request->obj_request_count));
>>
>> Without this assert, reads that hit errors would hang forever, since
>> the block layer considered them incomplete.
>>
>> Fixes: http://tracker.ceph.com/issues/5647
>> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
>> ---
>>   drivers/block/rbd.c |   14 +++++++-------
>>   1 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 0d669ae..f8fd7d3 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -1557,11 +1557,12 @@ rbd_img_obj_request_read_callback(struct
>> rbd_obj_request *obj_request)
>>           obj_request, obj_request->img_request, obj_request->result,
>>           xferred, length);
>>       /*
>> -     * ENOENT means a hole in the image.  We zero-fill the
>> -     * entire length of the request.  A short read also implies
>> -     * zero-fill to the end of the request.  Either way we
>> -     * update the xferred count to indicate the whole request
>> -     * was satisfied.
>> +     * ENOENT means a hole in the image.  We zero-fill the entire
>> +     * length of the request.  A short read also implies zero-fill
>> +     * to the end of the request.  An error requires the whole
>> +     * length of the request to be reported finished with an error
>> +     * to the block layer.  In each case we update the xferred
>> +     * count to indicate the whole request was satisfied.
>>        */
>>       rbd_assert(obj_request->type != OBJ_REQUEST_NODATA);
>>       if (obj_request->result == -ENOENT) {
>> @@ -1570,14 +1571,13 @@ rbd_img_obj_request_read_callback(struct
>> rbd_obj_request *obj_request)
>>           else
>>               zero_pages(obj_request->pages, 0, length);
>>           obj_request->result = 0;
>> -        obj_request->xferred = length;
>>       } else if (xferred < length && !obj_request->result) {
>>           if (obj_request->type == OBJ_REQUEST_BIO)
>>               zero_bio_chain(obj_request->bio_list, xferred);
>>           else
>>               zero_pages(obj_request->pages, xferred, length);
>> -        obj_request->xferred = length;
>>       }
>> +    obj_request->xferred = length;
>>       obj_request_done_set(obj_request);
>>   }
>>
>>

