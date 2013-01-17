From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH REPOST 6/6] rbd: move remaining osd op setup into rbd_osd_req_op_create()
Date: Wed, 16 Jan 2013 22:37:32 -0600
Message-ID: <50F7800C.4070306@inktank.com>
References: <50E6EF5F.9080200@inktank.com> <50E6F028.6040904@inktank.com> <50F77CC5.6070703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:52889 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab3AQEhf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 23:37:35 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so4040824ieb.6
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 20:37:35 -0800 (PST)
In-Reply-To: <50F77CC5.6070703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/16/2013 10:23 PM, Josh Durgin wrote:
> On 01/04/2013 07:07 AM, Alex Elder wrote:
>> The two remaining osd ops used by rbd are CEPH_OSD_OP_WATCH and
>> CEPH_OSD_OP_NOTIFY_ACK.  Move the setup of those operations into
>> rbd_osd_req_op_create(), and get rid of rbd_create_rw_op() and
>> rbd_destroy_op().
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   68
>> ++++++++++++++++++++-------------------------------
>>   1 file changed, 27 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 9f41c32..21fbf82 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -1027,24 +1027,6 @@ out_err:
>>       return NULL;
>>   }
>>
>> -static struct ceph_osd_req_op *rbd_create_rw_op(int opcode, u64 ofs,
>> u64 len)
>> -{
>> -    struct ceph_osd_req_op *op;
>> -
>> -    op = kzalloc(sizeof (*op), GFP_NOIO);
>> -    if (!op)
>> -        return NULL;
>> -
>> -    op->op = opcode;
>> -
>> -    return op;
>> -}
>> -
>> -static void rbd_destroy_op(struct ceph_osd_req_op *op)
>> -{
>> -    kfree(op);
>> -}
>> -
>>   struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
>>   {
>>       struct ceph_osd_req_op *op;
>> @@ -1087,6 +1069,16 @@ struct ceph_osd_req_op *rbd_osd_req_op_create(u16
>> opcode, ...)
>>           op->cls.indata_len = (u32) size;
>>           op->payload_len += size;
>>           break;
>> +    case CEPH_OSD_OP_NOTIFY_ACK:
>> +    case CEPH_OSD_OP_WATCH:
>> +        /* rbd_osd_req_op_create(NOTIFY_ACK, cookie, version) */
>> +        /* rbd_osd_req_op_create(WATCH, cookie, version, flag) */
>> +        op->watch.cookie = va_arg(args, u64);
>> +        op->watch.ver = va_arg(args, u64);
>> +        op->watch.ver = cpu_to_le64(op->watch.ver);    /* XXX */
> 
> why the /* XXX */ comment?

Because it's the only value here that is converted
from cpu byte order.  It was added in this commit:

    a71b891bc7d77a070e723c8c53d1dd73cf931555
    rbd: send header version when notifying

And I think was done without full understanding that it
was being done different from all the others.  I think
it may be wrong but I haven't really looked at it yet.
Pulling them all into this function made this difference
more obvious.

It was a "note to self" that I wanted to fix that.

I normally try to resolve anything like that before I
post for review but I guess I forgot.  There may be
others.

					-Alex

>> +        if (opcode == CEPH_OSD_OP_WATCH && va_arg(args, int))
>> +            op->watch.flag = (u8) 1;
>> +        break;
>>       default:
>>           rbd_warn(NULL, "unsupported opcode %hu\n", opcode);
>>           kfree(op);
>> @@ -1434,14 +1426,10 @@ static int rbd_req_sync_notify_ack(struct
>> rbd_device *rbd_dev,
>>       struct ceph_osd_req_op *op;
>>       int ret;
>>
>> -    op = rbd_create_rw_op(CEPH_OSD_OP_NOTIFY_ACK, 0, 0);
>> +    op = rbd_osd_req_op_create(CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver);
>>       if (!op)
>>           return -ENOMEM;
>>
>> -    op->watch.ver = cpu_to_le64(ver);
>> -    op->watch.cookie = notify_id;
>> -    op->watch.flag = 0;
>> -
>>       ret = rbd_do_request(NULL, rbd_dev, NULL, CEPH_NOSNAP,
>>                 rbd_dev->header_name, 0, 0, NULL,
>>                 NULL, 0,
>> @@ -1450,7 +1438,8 @@ static int rbd_req_sync_notify_ack(struct
>> rbd_device *rbd_dev,
>>                 NULL, 0,
>>                 rbd_simple_req_cb, 0, NULL);
>>
>> -    rbd_destroy_op(op);
>> +    rbd_osd_req_op_destroy(op);
>> +
>>       return ret;
>>   }
>>
>> @@ -1480,14 +1469,9 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
>> u8 opcode, void *data)
>>    */
>>   static int rbd_req_sync_watch(struct rbd_device *rbd_dev, int start)
>>   {
>> -    struct ceph_osd_req_op *op;
>>       struct ceph_osd_request **linger_req = NULL;
>> -    __le64 version = 0;
>> -    int ret;
>> -
>> -    op = rbd_create_rw_op(CEPH_OSD_OP_WATCH, 0, 0);
>> -    if (!op)
>> -        return -ENOMEM;
>> +    struct ceph_osd_req_op *op;
>> +    int ret = 0;
>>
>>       if (start) {
>>           struct ceph_osd_client *osdc;
>> @@ -1496,26 +1480,28 @@ static int rbd_req_sync_watch(struct rbd_device
>> *rbd_dev, int start)
>>           ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0, rbd_dev,
>>                           &rbd_dev->watch_event);
>>           if (ret < 0)
>> -            goto done;
>> -        version = cpu_to_le64(rbd_dev->header.obj_version);
>> +            return ret;
>>           linger_req = &rbd_dev->watch_request;
>> +    } else {
>> +        rbd_assert(rbd_dev->watch_request != NULL);
>>       }
>>
>> -    op->watch.ver = version;
>> -    op->watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
>> -    op->watch.flag = (u8) start ? 1 : 0;
>> -
>> -    ret = rbd_req_sync_op(rbd_dev,
>> +    op = rbd_osd_req_op_create(CEPH_OSD_OP_WATCH,
>> +                rbd_dev->watch_event->cookie,
>> +                rbd_dev->header.obj_version, start);
>> +    if (op)
>> +        ret = rbd_req_sync_op(rbd_dev,
>>                     CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
>>                     op, rbd_dev->header_name,
>>                     0, 0, NULL, linger_req, NULL);
>>
>> -    if (!start || ret < 0) {
>> +    /* Cancel the event if we're tearing down, or on error */
>> +
>> +    if (!start || !op || ret < 0) {
>>           ceph_osdc_cancel_event(rbd_dev->watch_event);
>>           rbd_dev->watch_event = NULL;
>>       }
>> -done:
>> -    rbd_destroy_op(op);
>> +    rbd_osd_req_op_destroy(op);
>>
>>       return ret;
>>   }
>>
> 

