From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 6/6] rbd: always set read-only flag in rbd_add()
Date: Wed, 08 May 2013 07:50:27 -0500
Message-ID: <518A4A13.60806@inktank.com>
References: <51885A97.9070005@inktank.com> <51885B13.4070900@inktank.com> <51898577.7040509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:54651 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab3EHMu3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 08:50:29 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so1938930oag.17
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 05:50:28 -0700 (PDT)
In-Reply-To: <51898577.7040509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/07/2013 05:51 PM, Josh Durgin wrote:
> On 05/06/2013 06:38 PM, Alex Elder wrote:
>> Hold off setting the read-only flag in rbd_add() for an image being
>> mapped until we have successfully probed the image.  At that point
>> we know whether it's a snapshot mapping or not, so we can set the
>> read-only flag in that one place rather than doing so (for
>> snapshots) in rbd_dev_mapping_set().  To do this, pass a flag to the
>> image probe routine indicating whether we want a read-only mapping.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 530793a..0c72643 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c

. . .

>> @@ -4850,11 +4854,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>>       rbdc = NULL;        /* rbd_dev now owns this */
>>       spec = NULL;        /* rbd_dev now owns this */
>>
>> -    rbd_dev->mapping.read_only = rbd_opts->read_only;
>> -    kfree(rbd_opts);
>> -    rbd_opts = NULL;    /* done with this */
> 
> It looks like this was moved accidentally? Maybe needed
> by a later patch?

No, I changed to grabbing the read-only flag in a local
variable, and as long as I was doing that I moved it
up right after argument parsing so I could free the
options structure right away.

					-Alex

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
>> -
>> -    rc = rbd_dev_image_probe(rbd_dev);
>> +    rc = rbd_dev_image_probe(rbd_dev, read_only);
>>       if (rc < 0)
>>           goto err_out_rbd_dev;
>>
> 

