From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH 1/2] rbd: zero return code in rbd_dev_image_id()
Date: Mon, 22 Oct 2012 13:00:40 -0700
Message-ID: <5085A5E8.3020701@inktank.com>
References: <508577B6.2020708@inktank.com> <508577F5.3020102@inktank.com> <50857FE2.5060705@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52258 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2JVUAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 16:00:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2253325pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 13:00:43 -0700 (PDT)
In-Reply-To: <50857FE2.5060705@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

OK, assuming the comment is changed to reflect the "we expect a data 
length back here" indication, Alex explained this offline and I agree.


On 10/22/2012 10:18 AM, Dan Mick wrote:
> I really feel like we ought to root-cause this before we patch the
> kernel client.  Something isn't working the way we expect.
>
> On 10/22/2012 09:44 AM, Alex Elder wrote:
>> There is a call in rbd_dev_image_id() to rbd_req_sync_exec()
>> to get the image id for an image.  Despite the "get_id" class
>> method only returning 0 on success, I am getting back a positive
>> value (I think the number of bytes returned with the call).
>>
>> That may or may not be how rbd_req_sync_exec() is supposed to
>> behave, but zeroing the return value if successful makes it moot
>> and makes this path through the code work as desired.
>>
>> Do the same in rbd_dev_v2_object_prefix().
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index cf5d109..65e9f1f 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -2169,6 +2169,7 @@ static int rbd_dev_v2_object_prefix(struct
>> rbd_device *rbd_dev)
>>       dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
>>       if (ret < 0)
>>           goto out;
>> +    ret = 0;    /* rbd_req_sync_exec() can return positive */
>>
>>       p = reply_buf;
>>       rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
>> @@ -2862,6 +2863,7 @@ static int rbd_dev_image_id(struct rbd_device
>> *rbd_dev)
>>       dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
>>       if (ret < 0)
>>           goto out;
>> +    ret = 0;    /* rbd_req_sync_exec() can return positive */
>>
>>       p = response;
>>       rbd_dev->image_id = ceph_extract_encoded_string(&p,
>>
