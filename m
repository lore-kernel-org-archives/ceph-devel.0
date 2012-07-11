From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 10/16] rbd: dynamically allocate image name
Date: Wed, 11 Jul 2012 13:52:25 -0700
Message-ID: <4FFDE789.2080203@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8769.90501@inktank.com> <4FFDE6C8.8070906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:59765 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030191Ab2GKUw3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 16:52:29 -0400
Received: by yhpp61 with SMTP id p61so1975997yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 13:52:28 -0700 (PDT)
In-Reply-To: <4FFDE6C8.8070906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 01:49 PM, Josh Durgin wrote:
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
>
> On 07/11/2012 07:02 AM, Alex Elder wrote:
>> There is no need to impose a small limit the length of the rbd image
>> name recorded in a struct rbd_dev. Remove the limitation by
>> allocating space for the image name dynamically.
>>
>> Signed-off-by: Alex Elder<elder@inktank.com>
>> ---
>> drivers/block/rbd.c | 34 ++++++++++++++++++----------------
>> drivers/block/rbd_types.h | 1 -
>> 2 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 4d11337..28afff9 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -161,8 +161,8 @@ struct rbd_device {
>> spinlock_t lock; /* queue lock */
>>
>> struct rbd_image_header header;
>> - char obj[RBD_MAX_OBJ_NAME_LEN]; /* rbd image name */
>> - int obj_len;
>> + char *obj; /* rbd image name */
>> + size_t obj_len;

On second look, obj_len can be a local variable. It's not used
outside of option parsing.

>> char *obj_md_name; /* hdr nm. */
>> int pool_id;
>>
>> @@ -2333,6 +2333,8 @@ static inline char *dup_token(const char **buf,
>> size_t *lenp)
>> * Returns a pointer to a dynamically-allocated buffer containing
>> * the pool name provided, or a pointer-coded errno if an error
>> * occurs.
>> + *
>> + * Note: rbd_dev is assumed to have been initially zero-filled.
>> */
>> static char *rbd_add_parse_args(struct rbd_device *rbd_dev,
>> const char *buf,
>> @@ -2360,27 +2362,22 @@ static char *rbd_add_parse_args(struct
>> rbd_device *rbd_dev,
>> if (!len || len>= options_size)
>> goto out_err;
>>
>> + ret = -ENOMEM;
>> pool_name = dup_token(&buf, NULL);
>> - if (!pool_name) {
>> - ret = -ENOMEM;
>> + if (!pool_name)
>> goto out_err;
>> - }
>>
>> - len = copy_token(&buf, rbd_dev->obj, sizeof (rbd_dev->obj));
>> - if (!len || len>= sizeof (rbd_dev->obj))
>> + rbd_dev->obj = dup_token(&buf,&rbd_dev->obj_len);
>> + if (!rbd_dev->obj)
>> goto out_err;
>>
>> - /* We have the object length in hand, save it. */
>> -
>> - rbd_dev->obj_len = len;
>> -
>> /* Create the name of the header object */
>>
>> - rbd_dev->obj_md_name = kmalloc(len + sizeof (RBD_SUFFIX), GFP_KERNEL);
>> - if (!rbd_dev->obj_md_name) {
>> - ret = -ENOMEM;
>> + rbd_dev->obj_md_name = kmalloc(rbd_dev->obj_len
>> + + sizeof (RBD_SUFFIX),
>> + GFP_KERNEL);
>> + if (!rbd_dev->obj_md_name)
>> goto out_err;
>> - }
>> sprintf(rbd_dev->obj_md_name, "%s%s", rbd_dev->obj, RBD_SUFFIX);
>>
>> /*
>> @@ -2391,13 +2388,16 @@ static char *rbd_add_parse_args(struct
>> rbd_device *rbd_dev,
>> if (!len)
>> memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
>> sizeof (RBD_SNAP_HEAD_NAME));
>> - else if (len>= sizeof (rbd_dev->snap_name))
>> + else if (len>= sizeof (rbd_dev->snap_name)) {
>> + ret = -EINVAL;
>> goto out_err;
>> + }
>>
>> return pool_name;
>>
>> out_err:
>> kfree(rbd_dev->obj_md_name);
>> + kfree(rbd_dev->obj);
>> kfree(pool_name);
>>
>> return ERR_PTR(ret);
>> @@ -2506,6 +2506,7 @@ err_out_client:
>> err_put_id:
>> if (pool_name) {
>> kfree(rbd_dev->obj_md_name);
>> + kfree(rbd_dev->obj);
>> kfree(pool_name);
>> }
>> rbd_id_put(rbd_dev);
>> @@ -2557,6 +2558,7 @@ static void rbd_dev_release(struct device *dev)
>>
>> /* done with the id, and with the rbd_dev */
>> kfree(rbd_dev->obj_md_name);
>> + kfree(rbd_dev->obj);
>> rbd_id_put(rbd_dev);
>> kfree(rbd_dev);
>>
>> diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
>> index 9507086..0924e9e 100644
>> --- a/drivers/block/rbd_types.h
>> +++ b/drivers/block/rbd_types.h
>> @@ -31,7 +31,6 @@
>> #define RBD_MIN_OBJ_ORDER 16
>> #define RBD_MAX_OBJ_ORDER 30
>>
>> -#define RBD_MAX_OBJ_NAME_LEN 96
>> #define RBD_MAX_SEG_NAME_LEN 128
>>
>> #define RBD_COMP_NONE 0
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

