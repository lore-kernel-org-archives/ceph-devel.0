From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 7/8] rbd: add reference counting to rbd_spec
Date: Tue, 30 Oct 2012 13:17:26 -0700
Message-ID: <509035D6.3000100@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com> <508B16C9.8040708@inktank.com> <508F0147.1000205@inktank.com> <508FCF35.4090507@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48491 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab2J3URh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 16:17:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so414400pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 13:17:37 -0700 (PDT)
In-Reply-To: <508FCF35.4090507@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/30/2012 05:59 AM, Alex Elder wrote:
> On 10/29/2012 05:20 PM, Josh Durgin wrote:
>> On 10/26/2012 04:03 PM, Alex Elder wrote:
>>> With layered images we'll share rbd_spec structures, so add a
>>> reference count to it.  It neatens up some code also.
>>
>> Could you explain your plan for these data structures? What
>> will the structs and their relationships look like with
>> clones mapped?
>
> Like I mentioned in the previous message, this structure
> encapsulates the information that identifies an rbd image.
>
> In the next patch, the information defining the image to
> be mapped is extracted from "command line" arguments to
> populate the content of one of these in the argument
> parsing routine.
>
> In an upcoming patch, some create/destroy helper routines
> will be defined for an rbd_device structure. To create an
> rbd device, you provide an initialized (activated?)
> rbd_client (which includes a ceph client) and the identity
> of an image you want that rbd_device to map using that client.
>
> So in response to a map request via /sys/bus/rbd/add, a
> new rbd_client will be created in that way.  Later, a
> mapped rbd image (v2) will continue its probing activity
> by probing its parent, and if it has one, an rbd_device
> structure will be created for that purpose, using the
> same client as the original/child image and the image
> specification fetched from the child for the parent.
>
> I suppose it's not obvious at this point why reference
> counting is needed.  It's one of those things that is
> needed later on (in work that's well underway but which
> I have not posted yet), and this turns out to be a
> good time to put that in place so it's there when it's
> needed, shortly.
>
> In any case, the reference counting here arises because
> the image spec for a parent will be created and filled in
> while probing the child.  But I want to provide that image
> spec for creating the parent rbd_device structure, and
> keeping track of who owned what got a little confusing
> so I decided that just sharing a reference counted
> structure was the best way to go.

This makes sense now, thanks.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> 					-Alex
>
>>> A silly get/put pair is added to the alloc routine just to avoid
>>> "defined but not used" warnings.  It will go away soon.
>>>
>>> Signed-off-by: Alex Elder <elder@inktank.com>
>>> ---
>>>    drivers/block/rbd.c |   52
>>> +++++++++++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 42 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index c39e238..19c7c6b 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -2134,6 +2134,45 @@ static struct device_type rbd_snap_device_type = {
>>>        .release    = rbd_snap_dev_release,
>>>    };
>>>
>>> +static struct rbd_spec *rbd_spec_get(struct rbd_spec *spec)
>>> +{
>>> +    kref_get(&spec->kref);
>>> +
>>> +    return spec;
>>> +}
>>> +
>>> +static void rbd_spec_free(struct kref *kref);
>>> +static void rbd_spec_put(struct rbd_spec *spec)
>>> +{
>>> +    if (spec)
>>> +        kref_put(&spec->kref, rbd_spec_free);
>>> +}
>>> +
>>> +static struct rbd_spec *rbd_spec_alloc(void)
>>> +{
>>> +    struct rbd_spec *spec;
>>> +
>>> +    spec = kzalloc(sizeof (*spec), GFP_KERNEL);
>>> +    if (!spec)
>>> +        return NULL;
>>> +    kref_init(&spec->kref);
>>> +
>>> +    rbd_spec_put(rbd_spec_get(spec));    /* TEMPORARY */
>>> +
>>> +    return spec;
>>> +}
>>> +
>>> +static void rbd_spec_free(struct kref *kref)
>>> +{
>>> +    struct rbd_spec *spec = container_of(kref, struct rbd_spec, kref);
>>> +
>>> +    kfree(spec->pool_name);
>>> +    kfree(spec->image_id);
>>> +    kfree(spec->image_name);
>>> +    kfree(spec->snap_name);
>>> +    kfree(spec);
>>> +}
>>> +
>>>    static bool rbd_snap_registered(struct rbd_snap *snap)
>>>    {
>>>        bool ret = snap->dev.type == &rbd_snap_device_type;
>>> @@ -3165,7 +3204,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>>>        rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
>>>        if (!rbd_dev)
>>>            return -ENOMEM;
>>> -    rbd_dev->spec = kzalloc(sizeof (*rbd_dev->spec), GFP_KERNEL);
>>> +    rbd_dev->spec = rbd_spec_alloc();
>>>        if (!rbd_dev->spec)
>>>            goto err_out_mem;
>>>
>>> @@ -3278,16 +3317,12 @@ err_out_probe:
>>>    err_out_client:
>>>        kfree(rbd_dev->header_name);
>>>        rbd_put_client(rbd_dev);
>>> -    kfree(rbd_dev->spec->image_id);
>>>    err_out_args:
>>>        if (ceph_opts)
>>>            ceph_destroy_options(ceph_opts);
>>> -    kfree(rbd_dev->spec->snap_name);
>>> -    kfree(rbd_dev->spec->image_name);
>>> -    kfree(rbd_dev->spec->pool_name);
>>>        kfree(rbd_opts);
>>>    err_out_mem:
>>> -    kfree(rbd_dev->spec);
>>> +    rbd_spec_put(rbd_dev->spec);
>>>        kfree(rbd_dev);
>>>
>>>        dout("Error adding device %s\n", buf);
>>> @@ -3336,12 +3371,9 @@ static void rbd_dev_release(struct device *dev)
>>>        rbd_header_free(&rbd_dev->header);
>>>
>>>        /* done with the id, and with the rbd_dev */
>>> -    kfree(rbd_dev->spec->snap_name);
>>> -    kfree(rbd_dev->spec->image_id);
>>>        kfree(rbd_dev->header_name);
>>> -    kfree(rbd_dev->spec->pool_name);
>>> -    kfree(rbd_dev->spec->image_name);
>>>        rbd_dev_id_put(rbd_dev);
>>> +    rbd_spec_put(rbd_dev->spec);
>>>        kfree(rbd_dev);
>>>
>>>        /* release module ref */
>>>
>>

