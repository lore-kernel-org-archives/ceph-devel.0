From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 01/12, v2] rbd: new request tracking code
Date: Tue, 29 Jan 2013 18:34:48 -0600
Message-ID: <51086AA8.3090704@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com> <5107A7BF.4080704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61912 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab3A3Aer (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 19:34:47 -0500
Received: by mail-ie0-f169.google.com with SMTP id c14so864066ieb.14
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 16:34:46 -0800 (PST)
In-Reply-To: <5107A7BF.4080704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/29/2013 04:43 AM, Josh Durgin wrote:
> On 01/24/2013 06:08 AM, Alex Elder wrote:
>> This is an update of the first patch in my request tracking
>> code series.  After posting it the other day I identified some
>> problems related to reference counting of image and object
>> requests.  I also am starting to look at the details of
>> implementing layered reads, and ended up making some
>> substantive changes.  Since I have not seen any review
>> feedback I thought the best thing would be to just
>> re-post the updated patch.
>>
>> The remaining patches in the series have changed accordingly,
>> but they have not really changed substantively, so I am
>> not re-posting those (but will if it's requested).
>>
>> The main functional change is that an image request no longer
>> maintains an array of object request pointers, it maintains
>> a list of object requests.  This simplifies some things, and
>> makes the image request structure fixed size.
>>
>> A few other functional changes:
>> - Reference counting of object and image requests is now
>>    done sensibly.
>> - Image requests now support a callback when complete,
>>    which will be used for layered I/O requests.
>> - There are a few new helper functions that encapsulate
>>    tying an object request to an image request.
>> - An distinct value is now used for the "which" field
>>    for object requests not associated with a image request
>>    (mainly used for validation/assertions).
>>
>> Other changes:
>> - Everything that was named "image_request" now uses
>>    "img_request" instead.
>> - A few blocks and lines of code have been rearranged.
>>
>> The updated series is available on the ceph-client git
>> repository in the branch "wip-rbd-review-v2".
>>
>>                     -Alex
>>
>> This patch fully implements the new request tracking code for rbd
>> I/O requests.

Responses to your review comments are below.

Thank you very much for careful, thorough, and thoughtful
work on this.  I believe it's very important and you do
a good job of it.

					-Alex

>> Each I/O request to an rbd image will get an rbd_image_request
>> structure allocated to track it.  This provides access to all
>> information about the original request, as well as access to the
>> set of one or more object requests that are initiated as a result
>> of the image request.
>>
>> An rbd_obj_request structure defines a request sent to a single osd
>> object (possibly) as part of an rbd image request.  An rbd object
>> request refers to a ceph_osd_request structure built up to represent
>> the request; for now it will contain a single osd operation.  It
>> also provides space to hold the result status and the version of the
>> object when the osd request completes.
>>
>> An rbd_obj_request structure can also stand on its own.  This will
>> be used for reading the version 1 header object, for issuing
>> acknowledgements to event notifications, and for making object
>> method calls.
>>
>> All rbd object requests now complete asynchronously with respect
>> to the osd client--they supply a common callback routine.
>>
>> This resolves:
>>      http://tracker.newdream.net/issues/3741
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>> v2: - fixed reference counting
>>      - image request callback support
>>      - image/object connection helper functions
>>      - distinct BAD_WHICH value for non-image object requests
>>
>>   drivers/block/rbd.c |  622
>> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 620 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 6689363..46a61dd 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -181,6 +181,67 @@ struct rbd_req_coll {
>>       struct rbd_req_status    status[0];
>>   };
>>
>> +struct rbd_img_request;
>> +typedef void (*rbd_img_callback_t)(struct rbd_img_request *);
>> +
>> +#define    BAD_WHICH    U32_MAX        /* Good which or bad which,
>> which? */
>> +
>> +struct rbd_obj_request;
>> +typedef void (*rbd_obj_callback_t)(struct rbd_obj_request *);
>> +
>> +enum obj_req_type { obj_req_bio };    /* More types to come */
> 
> enum labels should be capitalized.

Not where I come from (at least not always), but I'll
convert these to be all caps.

>> +struct rbd_obj_request {
>> +    const char        *object_name;
>> +    u64            offset;        /* object start byte */
>> +    u64            length;        /* bytes from offset */
>> +
>> +    struct rbd_img_request    *img_request;
>> +    struct list_head    links;
>> +    u32            which;        /* posn image request list */
>> +
>> +    enum obj_req_type    type;
>> +    struct bio        *bio_list;
>> +
>> +    struct ceph_osd_request    *osd_req;
>> +
>> +    u64            xferred;    /* bytes transferred */
>> +    u64            version;
> 
> This version is only used (uselessly) for the watch operation. It
> should be removed in a future patch (along with the obj_ver in the
> header).

I'm not sure whether the description is quite right, but:
   http://tracker.ceph.com/issues/3952

>> +    s32            result;
>> +    atomic_t        done;
>> +
>> +    rbd_obj_callback_t    callback;
>> +
>> +    struct kref        kref;
>> +};
>> +
>> +struct rbd_img_request {
>> +    struct request        *rq;
>> +    struct rbd_device    *rbd_dev;
>> +    u64            offset;    /* starting image byte offset */
>> +    u64            length;    /* byte count from offset */
>> +    bool            write_request;    /* false for read */
>> +    union {
>> +        struct ceph_snap_context *snapc;    /* for writes */
>> +        u64        snap_id;        /* for reads */
>> +    };
>> +    spinlock_t        completion_lock;
> 
> It'd be nice to have a comment describing what this lock protects.

OK, I'll add one.  The lock may not be needed, but for now I left
it in.  It protects updates to the next_completion field.

>> +    u32            next_completion;
>> +    rbd_img_callback_t    callback;
>> +
>> +    u32            obj_request_count;
>> +    struct list_head    obj_requests;
> 
> Maybe note that these are rbd_obj_requests, and not ceph_osd_requests.

I meant for the name to suggest that (I'm pretty consistent
about using osd_req and obj_request prefixes), but I'll add
a short comment since the list type doesn't make it obvious.

>> +    struct kref        kref;
>> +};
>> +
>> +#define for_each_obj_request(ireq, oreq) \
>> +    list_for_each_entry(oreq, &ireq->obj_requests, links)
>> +#define for_each_obj_request_from(ireq, oreq) \
>> +    list_for_each_entry_from(oreq, &ireq->obj_requests, links)
>> +#define for_each_obj_request_safe(ireq, oreq, n) \
>> +    list_for_each_entry_safe_reverse(oreq, n, &ireq->obj_requests,
>> links)
>> +
>>   /*
>>    * a single io request
>>    */

. . .

>> @@ -1395,6 +1512,26 @@ done:
>>       return ret;
>>   }
>>
>> +static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
>> +                struct rbd_obj_request *obj_request)
>> +{
>> +    return ceph_osdc_start_request(osdc, obj_request->osd_req, false);
>> +}
>> +
>> +static void rbd_img_request_complete(struct rbd_img_request
>> *img_request)
>> +{
>> +    if (img_request->callback)
>> +        img_request->callback(img_request);
>> +    else
>> +        rbd_img_request_put(img_request);
>> +}
> 
> Why rely on the callback to rbd_img_request_put()? Wouldn't it be a
> bit simpler to unconditionally do the put here?

I think it's because I wanted the callback to have the chance
to defer completion, and hang onto the reference until that
time rather than taking another reference.  But right now it
isn't used so it's sort of moot anyway.

Unless you object, I'm going to leave it as-is for now,
and when I look at upcoming patches that will use this
functionality I may change it to drop the reference
unconditionally as you suggest.

>> +static void rbd_obj_request_complete(struct rbd_obj_request
>> *obj_request)
>> +{
>> +    if (obj_request->callback)
>> +        obj_request->callback(obj_request);
>> +}
>> +
>>   /*
>>    * Request sync osd read
>>    */

. . .

>> +static struct ceph_osd_request *rbd_osd_req_create(
>> +                    struct rbd_device *rbd_dev,
>> +                    bool write_request,
>> +                    struct rbd_obj_request *obj_request,
>> +                    struct ceph_osd_req_op *op)
>> +{
>> +    struct rbd_img_request *img_request = obj_request->img_request;
>> +    struct ceph_snap_context *snapc = NULL;
>> +    struct ceph_osd_client *osdc;
>> +    struct ceph_osd_request *osd_req;
>> +    struct timespec now;
>> +    struct timespec *mtime;
>> +    u64 snap_id = CEPH_NOSNAP;
>> +    u64 offset = obj_request->offset;
>> +    u64 length = obj_request->length;
>> +
>> +    if (img_request) {
>> +        rbd_assert(img_request->write_request == write_request);
>> +        if (img_request->write_request)
>> +            snapc = img_request->snapc;
>> +        else
>> +            snap_id = img_request->snap_id;
>> +    }
>> +
>> +    /* Allocate and initialize the request, for the single op */
>> +
>> +    osdc = &rbd_dev->rbd_client->client->osdc;
>> +    osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false,
>> GFP_ATOMIC);
>> +    if (!osd_req)
>> +        return NULL;    /* ENOMEM */
>> +
>> +    rbd_assert(obj_req_type_valid(obj_request->type));
>> +    switch (obj_request->type) {
>> +    case obj_req_bio:
>> +        rbd_assert(obj_request->bio_list != NULL);
>> +        osd_req->r_bio = obj_request->bio_list;
>> +        bio_get(osd_req->r_bio);
>> +        /* osd client requires "num pages" even for bio */
>> +        osd_req->r_num_pages = calc_pages_for(offset, length);
>> +        break;
>> +    }
>> +
>> +    if (write_request) {
>> +        osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
>> +        now = CURRENT_TIME;
>> +        mtime = &now;
>> +    } else {
>> +        osd_req->r_flags = CEPH_OSD_FLAG_READ;
>> +        mtime = NULL;    /* not needed for reads */
>> +        offset = 0;    /* These are not used... */
>> +        length = 0;    /* ...for osd read requests */
>> +    }
>> +
>> +    osd_req->r_callback = rbd_osd_req_callback;
>> +    osd_req->r_priv = obj_request;
>> +
>> +    /* No trailing '\0' required for the object name in the request */
> 
> It looks like ceph_calc_object_layout() does require the trailing '\0':

Bummer.  The request itself doesn't need it.

You're right though.  I'll fix that.  (And I'm inclined to
fix ceph_calc_object_layout() so it doesn't require it...)

All that's required is changing "<=" to "<" in this assertion:
        rbd_assert(osd_req->r_oid_len <= sizeof (osd_req->r_oid));

> osd_client.c:
>   __map_request()
>     ceph_calc_object_layout(...,->r_oid,...)
>       strlen(oid)
> 
>> +    osd_req->r_oid_len = strlen(obj_request->object_name);
>> +    rbd_assert(osd_req->r_oid_len <= sizeof (osd_req->r_oid));
>> +    memcpy(osd_req->r_oid, obj_request->object_name,
>> osd_req->r_oid_len);
>> +
>> +    osd_req->r_file_layout = rbd_dev->layout;    /* struct */
>> +
>> +    /* osd_req will get its own reference to snapc (if non-null) */
>> +
>> +    ceph_osdc_build_request(osd_req, offset, length, 1, op,
>> +                snapc, snap_id, mtime);
>> +
>> +    return osd_req;
>> +}

. . .

>> +static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
>> +{
>> +    struct rbd_img_request *img_request;
>> +    u32 which = obj_request->which;
>> +    bool more = true;
>> +
>> +    img_request = obj_request->img_request;
>> +    rbd_assert(img_request != NULL);
>> +    rbd_assert(img_request->rq != NULL);
>> +    rbd_assert(which != BAD_WHICH);
>> +    rbd_assert(which < img_request->obj_request_count);
>> +    rbd_assert(which >= img_request->next_completion);
>> +
>> +    spin_lock(&img_request->completion_lock);
> 
> In the current equivalent code (rbd_coll_end_req_index), we use
> spin_lock_irq(), and don't hold the spinlock while calling
> blk_end_request.
> 
> Why the change, and is this change safe?

In the current "collection" code, the queue lock for the rbd
device is used.  And that lock *is* held (as required) when
__blk_end_request() function is called (and interrupts are
disabled)

In the new code, each image request has its own lock.  We
call blk_end_request() when there's something to tell the
block layer about (and that form of the function will
acquire the queue lock itself).  This separates the lock
from the Linux block code.

It's possible it is not be safe though.  Without thinking
a bit harder about this I'm not entirely sure whether I
need to disable interrupts.  So for now I'll just change
it to use spin_lock_irq() to be on the safe (and easier)
side.

As I said earlier, I'm not even sure a spinlock is
required here, atomic operations and barriers around
accesses to the next_completion field may be enough.
But that's an optimization for another day...

>> +    if (which != img_request->next_completion)
>> +        goto out;
>> +
>> +    for_each_obj_request_from(img_request, obj_request) {
>> +        unsigned int xferred;
>> +        int result;
>> +
>> +        rbd_assert(more);
>> +        rbd_assert(which < img_request->obj_request_count);
>> +
>> +        if (!atomic_read(&obj_request->done))
>> +            break;
>> +
>> +        rbd_assert(obj_request->xferred <= (u64) UINT_MAX);
>> +        xferred = (unsigned int) obj_request->xferred;
>> +        result = (int) obj_request->result;
>> +        if (result)
>> +            rbd_warn(NULL, "obj_request %s result %d xferred %u\n",
>> +                img_request->write_request ? "write" : "read",
>> +                result, xferred);
>> +
>> +        more = blk_end_request(img_request->rq, result, xferred);
>> +        which++;
>> +    }
>> +    rbd_assert(more ^ (which == img_request->obj_request_count));
>> +    img_request->next_completion = which;
>> +out:
>> +    spin_unlock(&img_request->completion_lock);
>> +
>> +    if (!more)
>> +        rbd_img_request_complete(img_request);
>> +}
>> +

. . .


