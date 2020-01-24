From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] rbd: set the 'device' link in sysfs
Date: Fri, 24 Jan 2020 08:03:58 +0100
Message-ID: <fe3fcf53-94fb-84b8-75ed-6375d81e1452@suse.de>
References: <20200123124433.121939-1-hare@suse.de>
 <CAOi1vP8Q44jLNoq+LTm8GRX687wfwLkJ3WRW_DWvY7nYUtPQxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730779AbgAXHED (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:04:03 -0500
In-Reply-To: <CAOi1vP8Q44jLNoq+LTm8GRX687wfwLkJ3WRW_DWvY7nYUtPQxQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Jens Axboe <axboe@kernel.dk>, Ceph Development <ceph-devel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, David Disseldorp <ddiss@suse.com>, Hannes Reinecke <hare@suse.com>

On 1/23/20 7:45 PM, Ilya Dryomov wrote:
> On Thu, Jan 23, 2020 at 1:44 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> The rbd driver already provides additional information in sysfs
>> under /sys/bus/rbd, so we should set the 'device' link in the block
>> device to reference this information.
>>
>> Cc: David Disseldorp <ddiss@suse.com>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/block/rbd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 9f1f8689e316..3240b7744aeb 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -6938,7 +6938,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>>         if (rc)
>>                 goto err_out_image_lock;
>>
>> -       add_disk(rbd_dev->disk);
>> +       device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
>>         /* see rbd_init_disk() */
>>         blk_put_queue(rbd_dev->disk->queue);
> 
> Hi Hannes,
> 
> I looked at this a while ago and didn't go through with the patch
> because I wasn't sure whether this symlink can point to something
> arbitrary.  IIRC it usually points a couple of levels up, to some
> parent.  In the rbd case, this would be a completely different tree:
> /sys/devices/virtual -> /sys/bus/rbd.
> 
Yes, this is expected.
The 'device' link will _always_ point into a different tree; the
accessor via /sys/block or /sys/bus are assumed to be virtual entries,
with the 'device' link pointing to the underlying device.
In our case the underlying device is also a virtual entity, but that's okay.

> Do you know if there is precedent for this in some other driver?
> Are you sure it's not going to break any assumptions?
> 
Things like iscsi do the very same thing.
And no, it doesn't break assumptions; quite the contrary.

> How did this came up?  I'm curious because rbd(8) is only utility
> that I know of that (somewhat) cares.
> 
That's me digging through the rbd driver and see if I could hook up
nvme-over-fabrics as a frontend to ceph/rbd.
As such I needed to find some information about the rbd device, and
found that while the driver provides additional information under
/sys/devices/rbd/X, this information is not linked to /sys/block/rbdX.
And this patch just links these to bits of information together, so that
now you can get the driver specific informations by following the
'device' link like all the other drivers do, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
