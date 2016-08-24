From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 04/16] libceph: support for advisory locking on RADOS objects
Date: Wed, 24 Aug 2016 22:49:47 +0200
Message-ID: <CAOi1vP_CVG=ERSJ8g9T9zwmx0jPYff67vVZPEZtw4pf+6auSYw@mail.gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
 <1472044720-29116-5-git-send-email-idryomov@gmail.com> <b94c591b-a0f5-4306-2388-b08796a904c6@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33926 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756158AbcHXUuH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 16:50:07 -0400
Received: by mail-ua0-f194.google.com with SMTP id d97so2245271uad.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 13:49:48 -0700 (PDT)
In-Reply-To: <b94c591b-a0f5-4306-2388-b08796a904c6@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 24, 2016 at 9:42 PM, Alex Elder <elder@ieee.org> wrote:
> On 08/24/2016 08:18 AM, Ilya Dryomov wrote:
>> From: Douglas Fuller <dfuller@redhat.com>
>>
>> This patch adds support for rados lock, unlock and break lock.
>>
>> Based heavily on code by Mike Christie <michaelc@cs.wisc.edu>.
>
> I have an unrelated comment on ceph_encode_timespec().  But
> this looks good to me otherwise.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>
>> Signed-off-by: Douglas Fuller <dfuller@redhat.com>
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  include/linux/ceph/cls_lock_client.h |  27 ++++++
>>  net/ceph/Makefile                    |   1 +
>>  net/ceph/cls_lock_client.c           | 180 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 208 insertions(+)
>>  create mode 100644 include/linux/ceph/cls_lock_client.h
>>  create mode 100644 net/ceph/cls_lock_client.c
>>
>> diff --git a/include/linux/ceph/cls_lock_client.h b/include/linux/ceph/cls_lock_client.h
>> new file mode 100644
>> index 000000000000..4e4dffef22bb
>> --- /dev/null
>> +++ b/include/linux/ceph/cls_lock_client.h
>> @@ -0,0 +1,27 @@
>> +#ifndef _LINUX_CEPH_CLS_LOCK_CLIENT_H
>> +#define _LINUX_CEPH_CLS_LOCK_CLIENT_H
>> +
>> +#include <linux/ceph/osd_client.h>
>> +
>> +enum ceph_cls_lock_type {
>> +     CEPH_CLS_LOCK_NONE = 0,
>> +     CEPH_CLS_LOCK_EXCLUSIVE = 1,
>> +     CEPH_CLS_LOCK_SHARED = 2,
>> +};
>> +
>> +int ceph_cls_lock(struct ceph_osd_client *osdc,
>> +               struct ceph_object_id *oid,
>> +               struct ceph_object_locator *oloc,
>> +               char *lock_name, u8 type, char *cookie,
>> +               char *tag, char *desc, u8 flags);
>> +int ceph_cls_unlock(struct ceph_osd_client *osdc,
>> +                 struct ceph_object_id *oid,
>> +                 struct ceph_object_locator *oloc,
>> +                 char *lock_name, char *cookie);
>> +int ceph_cls_break_lock(struct ceph_osd_client *osdc,
>> +                     struct ceph_object_id *oid,
>> +                     struct ceph_object_locator *oloc,
>> +                     char *lock_name, char *cookie,
>> +                     struct ceph_entity_name *locker);
>> +
>> +#endif
>> diff --git a/net/ceph/Makefile b/net/ceph/Makefile
>> index 84cbed630c4b..6a5180903e7b 100644
>> --- a/net/ceph/Makefile
>> +++ b/net/ceph/Makefile
>> @@ -5,6 +5,7 @@ obj-$(CONFIG_CEPH_LIB) += libceph.o
>>
>>  libceph-y := ceph_common.o messenger.o msgpool.o buffer.o pagelist.o \
>>       mon_client.o \
>> +     cls_lock_client.o \
>>       osd_client.o osdmap.o crush/crush.o crush/mapper.o crush/hash.o \
>>       debugfs.o \
>>       auth.o auth_none.o \
>> diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
>> new file mode 100644
>> index 000000000000..2a314537f958
>> --- /dev/null
>> +++ b/net/ceph/cls_lock_client.c
>> @@ -0,0 +1,180 @@
>> +#include <linux/ceph/ceph_debug.h>
>> +
>> +#include <linux/types.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/ceph/cls_lock_client.h>
>> +#include <linux/ceph/decode.h>
>> +
>> +/**
>> + * ceph_cls_lock - grab rados lock for object
>> + * @oid, @oloc: object to lock
>> + * @lock_name: the name of the lock
>> + * @type: lock type (CEPH_CLS_LOCK_EXCLUSIVE or CEPH_CLS_LOCK_SHARED)
>> + * @cookie: user-defined identifier for this instance of the lock
>> + * @tag: user-defined tag
>> + * @desc: user-defined lock description
>> + * @flags: lock flags
>> + *
>> + * All operations on the same lock should use the same tag.
>> + */
>> +int ceph_cls_lock(struct ceph_osd_client *osdc,
>> +               struct ceph_object_id *oid,
>> +               struct ceph_object_locator *oloc,
>> +               char *lock_name, u8 type, char *cookie,
>> +               char *tag, char *desc, u8 flags)
>> +{
>> +     int lock_op_buf_size;
>> +     int name_len = strlen(lock_name);
>> +     int cookie_len = strlen(cookie);
>> +     int tag_len = strlen(tag);
>> +     int desc_len = strlen(desc);
>> +     void *p, *end;
>> +     struct page *lock_op_page;
>> +     struct timespec mtime;
>> +     int ret;
>> +
>> +     lock_op_buf_size = name_len + sizeof(__le32) +
>> +                        cookie_len + sizeof(__le32) +
>> +                        tag_len + sizeof(__le32) +
>> +                        desc_len + sizeof(__le32) +
>> +                        sizeof(struct ceph_timespec) +
>> +                        /* flag and type */
>> +                        sizeof(u8) + sizeof(u8) +
>> +                        CEPH_ENCODING_START_BLK_LEN;
>> +     if (lock_op_buf_size > PAGE_SIZE)
>> +             return -E2BIG;
>> +
>> +     lock_op_page = alloc_page(GFP_NOIO);
>> +     if (!lock_op_page)
>> +             return -ENOMEM;
>> +
>> +     p = page_address(lock_op_page);
>> +     end = p + lock_op_buf_size;
>> +
>> +     /* encode cls_lock_lock_op struct */
>> +     ceph_start_encoding(&p, 1, 1,
>> +                         lock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
>> +     ceph_encode_string(&p, end, lock_name, name_len);
>> +     ceph_encode_8(&p, type);
>> +     ceph_encode_string(&p, end, cookie, cookie_len);
>> +     ceph_encode_string(&p, end, tag, tag_len);
>> +     ceph_encode_string(&p, end, desc, desc_len);
>> +     /* only support infinite duration */
>> +     memset(&mtime, 0, sizeof(mtime));
>> +     ceph_encode_timespec(p, &mtime);
>
> This is another unfortunate encoding function.  It should take
> the address of the pointer, and advance the pointer internally
> like most of the other ceph_encode_*() functions do.

A large number of users encode into another structure and not a p/end
buffer.  Though in general I agree - unifying all encode/decode
functions to use consistent signatures and naming scheme would be
a good cleanup project.

Thanks,

                Ilya
