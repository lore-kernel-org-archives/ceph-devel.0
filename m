From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: activate support for layered images
Date: Mon, 22 Apr 2013 18:11:58 -0500
Message-ID: <5175C3BE.7090907@inktank.com>
References: <51746031.1030109@inktank.com> <5175B8B6.3030908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:60867 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3DVXMC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 19:12:02 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so12169iec.37
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 16:12:01 -0700 (PDT)
In-Reply-To: <5175B8B6.3030908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/22/2013 05:24 PM, Josh Durgin wrote:
> On 04/21/2013 02:54 PM, Alex Elder wrote:
>> (This patch and the next one are available in the
>> "review/wip-enable-layering" branch of the ceph-client
>> git respository.)
>>
>>
>> Now that we have most everything in place to support layered rbd
>> images, enable support for them in the kernel client.  Issue a
>> warning to the log that the support is considered experimental
>> whenever a format 2 layered image is mapped.
>>
>> Note that we also have to claim to support the STRIPINGV2 feature,
>> due to a mistake in the way the rbd CLI set up those flags.  This
>> feature can work if it has the right parameters, and safeguards
>> have been put in place to reject those images that do not have
>> compatible parameters.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |    4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index d23cc8f..1ddbcdc 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -80,7 +80,7 @@
>>
>>   /* Features supported by this (client software) implementation. */
>>
>> -#define RBD_FEATURES_SUPPORTED    (0)
>> +#define RBD_FEATURES_SUPPORTED    (RBD_FEATURES_ALL)
>>
>>   /*
>>    * An RBD device name will be "rbd#", where the "rbd" comes from
>> @@ -4723,6 +4723,8 @@ static int rbd_dev_v2_probe(struct rbd_device
>> *rbd_dev)
>>           ret = rbd_dev_v2_parent_info(rbd_dev);
>>           if (ret)
>>               goto out_err;
>> +        rbd_warn(rbd_dev, "WARNING: layered rbd image support "
>> +                    "is EXPERIMENTAL!");
> 
> Maybe add "for the kernel rbd driver" or something, since librbd
> support isn't experimental. If you're removing this warning soon
> it doesn't matter though. Either way is fine with me.

I'll reword it slightly.  Thanks a lot for all the
reviews, Josh.

					-Alex

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
> 

