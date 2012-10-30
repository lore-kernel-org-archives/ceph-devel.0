From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 6/8] rbd: define image specification structure
Date: Tue, 30 Oct 2012 07:40:05 -0500
Message-ID: <508FCAA5.6080207@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com> <508B16B8.1030706@inktank.com> <508EFF9F.2010009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50266 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab2J3MkH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 08:40:07 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so261645iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 05:40:07 -0700 (PDT)
In-Reply-To: <508EFF9F.2010009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/29/2012 05:13 PM, Josh Durgin wrote:
> A couple notes below, but looks good.

I responded to all of your notes below.  And I will update
the code/comments as appropriate after we have a chance
to talk about it but for the time being I'm going to
commit what I posted as-is.

					-Alex

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
> On 10/26/2012 04:03 PM, Alex Elder wrote:
>> Group the fields that uniquely specify an rbd image into a new
>> reference-counted rbd_spec structure.  This structure will be used
>> to describe the desired image when mapping an image, and when
>> probing parent images in layered rbd devices.  Replace the set of
>> fields in the rbd device structure with a pointer to a dynamically
>> allocated rbd_spec.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |  158
>> +++++++++++++++++++++++++++++----------------------
>>   1 file changed, 90 insertions(+), 68 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 388dd47..c39e238 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -112,6 +112,27 @@ struct rbd_image_header {
>>       u64 obj_version;
>>   };
>>
>> +/*
>> + * An rbd image specification.
>> + *
>> + * The tuple (pool_id, image_id, snap_id) is sufficient to uniquely
>> + * identify an image.
>> + */
> 
> This looks like it's meant to be immutable. If so, it'd be nice
> to have that in the comment.

I want to be sure we agree on what that term means before saying
either way.

My aim in encapsulating this was to have a single thing represent
the identity of an image.  I started with just the pool, image,
and snapshot id's, but after a bit decided the names really
belonged there too.  I think the name<->id association can in
some cases change.

Also, for a given image, the id never changes, but a parent
will be specified using this, and that can change.

>> +struct rbd_spec {
>> +    u64        pool_id;
>> +    char        *pool_name;
>> +
>> +    char        *image_id;
>> +    size_t        image_id_len;
>> +    char        *image_name;
>> +    size_t        image_name_len;
> 
> I realize you're just rearranging things in this patch, but it's a bit
> odd that only image_id and image_name have corresponding lengths stored.
> Those fields don't seem necessary.

That's somewhat of an artifact, carrying along what was
already there, and grouping them like this makes it more
obvious those two were different.

Both the image id and image name lengths are now used one
place and it's basically one time only--in the probe routine.
So it is not valuable to keep them around.  I will remove
them in a future patch.

>> +
>> +    u64        snap_id;
>> +    char        *snap_name;
>> +
>> +    struct kref    kref;
>> +};
>> +
>>   struct rbd_options {
>>       bool    read_only;
>>   };
>> @@ -189,16 +210,9 @@ struct rbd_device {
>>
>>       struct rbd_image_header    header;
>>       bool                    exists;
>> -    char            *image_id;
>> -    size_t            image_id_len;
>> -    char            *image_name;
>> -    size_t            image_name_len;
>> -    char            *header_name;
>> -    char            *pool_name;
>> -    u64            pool_id;
>> +    struct rbd_spec        *spec;
>>
>> -    char                    *snap_name;
>> -    u64                     snap_id;
>> +    char            *header_name;
> 
> Are you planning to split out more stuff into a common
> struct rbd_image, like header_name, exists, etc?
> There's a bunch of stuff that's not specific to a particular rbd_device
> in here.

Possibly.  Do you mean to distinguish the Linux device side
from the rados storage side?  Let's talk about this today.

>>
>>       struct ceph_osd_event   *watch_event;
>>       struct ceph_osd_request *watch_request;
>> @@ -654,7 +668,7 @@ static int snap_by_name(struct rbd_device *rbd_dev,
>> const char *snap_name)
>>
>>       list_for_each_entry(snap, &rbd_dev->snaps, node) {
>>           if (!strcmp(snap_name, snap->name)) {
>> -            rbd_dev->snap_id = snap->id;
>> +            rbd_dev->spec->snap_id = snap->id;
>>               rbd_dev->mapping.size = snap->size;
>>               rbd_dev->mapping.features = snap->features;
>>

. . .

