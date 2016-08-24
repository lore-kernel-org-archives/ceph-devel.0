From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 04/16] libceph: support for advisory locking on RADOS
 objects
Date: Wed, 24 Aug 2016 14:42:36 -0500
Message-ID: <b94c591b-a0f5-4306-2388-b08796a904c6@ieee.org>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
 <1472044720-29116-5-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37500 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbcHXTtG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 15:49:06 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so53325648ith.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 12:48:22 -0700 (PDT)
In-Reply-To: <1472044720-29116-5-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 08/24/2016 08:18 AM, Ilya Dryomov wrote:
> From: Douglas Fuller <dfuller@redhat.com>
> 
> This patch adds support for rados lock, unlock and break lock.
> 
> Based heavily on code by Mike Christie <michaelc@cs.wisc.edu>.

I have an unrelated comment on ceph_encode_timespec().  But
this looks good to me otherwise.

Reviewed-by: Alex Elder <elder@linaro.org>


> Signed-off-by: Douglas Fuller <dfuller@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/cls_lock_client.h |  27 ++++++
>  net/ceph/Makefile                    |   1 +
>  net/ceph/cls_lock_client.c           | 180 +++++++++++++++++++++++++++++++++++
>  3 files changed, 208 insertions(+)
>  create mode 100644 include/linux/ceph/cls_lock_client.h
>  create mode 100644 net/ceph/cls_lock_client.c
> 
> diff --git a/include/linux/ceph/cls_lock_client.h b/include/linux/ceph/cls_lock_client.h
> new file mode 100644
> index 000000000000..4e4dffef22bb
> --- /dev/null
> +++ b/include/linux/ceph/cls_lock_client.h
> @@ -0,0 +1,27 @@
> +#ifndef _LINUX_CEPH_CLS_LOCK_CLIENT_H
> +#define _LINUX_CEPH_CLS_LOCK_CLIENT_H
> +
> +#include <linux/ceph/osd_client.h>
> +
> +enum ceph_cls_lock_type {
> +	CEPH_CLS_LOCK_NONE = 0,
> +	CEPH_CLS_LOCK_EXCLUSIVE = 1,
> +	CEPH_CLS_LOCK_SHARED = 2,
> +};
> +
> +int ceph_cls_lock(struct ceph_osd_client *osdc,
> +		  struct ceph_object_id *oid,
> +		  struct ceph_object_locator *oloc,
> +		  char *lock_name, u8 type, char *cookie,
> +		  char *tag, char *desc, u8 flags);
> +int ceph_cls_unlock(struct ceph_osd_client *osdc,
> +		    struct ceph_object_id *oid,
> +		    struct ceph_object_locator *oloc,
> +		    char *lock_name, char *cookie);
> +int ceph_cls_break_lock(struct ceph_osd_client *osdc,
> +			struct ceph_object_id *oid,
> +			struct ceph_object_locator *oloc,
> +			char *lock_name, char *cookie,
> +			struct ceph_entity_name *locker);
> +
> +#endif
> diff --git a/net/ceph/Makefile b/net/ceph/Makefile
> index 84cbed630c4b..6a5180903e7b 100644
> --- a/net/ceph/Makefile
> +++ b/net/ceph/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_CEPH_LIB) += libceph.o
>  
>  libceph-y := ceph_common.o messenger.o msgpool.o buffer.o pagelist.o \
>  	mon_client.o \
> +	cls_lock_client.o \
>  	osd_client.o osdmap.o crush/crush.o crush/mapper.o crush/hash.o \
>  	debugfs.o \
>  	auth.o auth_none.o \
> diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
> new file mode 100644
> index 000000000000..2a314537f958
> --- /dev/null
> +++ b/net/ceph/cls_lock_client.c
> @@ -0,0 +1,180 @@
> +#include <linux/ceph/ceph_debug.h>
> +
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +
> +#include <linux/ceph/cls_lock_client.h>
> +#include <linux/ceph/decode.h>
> +
> +/**
> + * ceph_cls_lock - grab rados lock for object
> + * @oid, @oloc: object to lock
> + * @lock_name: the name of the lock
> + * @type: lock type (CEPH_CLS_LOCK_EXCLUSIVE or CEPH_CLS_LOCK_SHARED)
> + * @cookie: user-defined identifier for this instance of the lock
> + * @tag: user-defined tag
> + * @desc: user-defined lock description
> + * @flags: lock flags
> + *
> + * All operations on the same lock should use the same tag.
> + */
> +int ceph_cls_lock(struct ceph_osd_client *osdc,
> +		  struct ceph_object_id *oid,
> +		  struct ceph_object_locator *oloc,
> +		  char *lock_name, u8 type, char *cookie,
> +		  char *tag, char *desc, u8 flags)
> +{
> +	int lock_op_buf_size;
> +	int name_len = strlen(lock_name);
> +	int cookie_len = strlen(cookie);
> +	int tag_len = strlen(tag);
> +	int desc_len = strlen(desc);
> +	void *p, *end;
> +	struct page *lock_op_page;
> +	struct timespec mtime;
> +	int ret;
> +
> +	lock_op_buf_size = name_len + sizeof(__le32) +
> +			   cookie_len + sizeof(__le32) +
> +			   tag_len + sizeof(__le32) +
> +			   desc_len + sizeof(__le32) +
> +			   sizeof(struct ceph_timespec) +
> +			   /* flag and type */
> +			   sizeof(u8) + sizeof(u8) +
> +			   CEPH_ENCODING_START_BLK_LEN;
> +	if (lock_op_buf_size > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	lock_op_page = alloc_page(GFP_NOIO);
> +	if (!lock_op_page)
> +		return -ENOMEM;
> +
> +	p = page_address(lock_op_page);
> +	end = p + lock_op_buf_size;
> +
> +	/* encode cls_lock_lock_op struct */
> +	ceph_start_encoding(&p, 1, 1,
> +			    lock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
> +	ceph_encode_string(&p, end, lock_name, name_len);
> +	ceph_encode_8(&p, type);
> +	ceph_encode_string(&p, end, cookie, cookie_len);
> +	ceph_encode_string(&p, end, tag, tag_len);
> +	ceph_encode_string(&p, end, desc, desc_len);
> +	/* only support infinite duration */
> +	memset(&mtime, 0, sizeof(mtime));
> +	ceph_encode_timespec(p, &mtime);

This is another unfortunate encoding function.  It should take
the address of the pointer, and advance the pointer internally
like most of the other ceph_encode_*() functions do.

> +	p += sizeof(struct ceph_timespec);
> +	ceph_encode_8(&p, flags);
> +
> +	dout("%s lock_name %s type %d cookie %s tag %s desc %s flags 0x%x\n",
> +	     __func__, lock_name, type, cookie, tag, desc, flags);
> +	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "lock",
> +			     CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> +			     lock_op_page, lock_op_buf_size, NULL, NULL);
> +
> +	dout("%s: status %d\n", __func__, ret);
> +	__free_page(lock_op_page);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ceph_cls_lock);
> +
> +/**
> + * ceph_cls_unlock - release rados lock for object
> + * @oid, @oloc: object to lock
> + * @lock_name: the name of the lock
> + * @cookie: user-defined identifier for this instance of the lock
> + */
> +int ceph_cls_unlock(struct ceph_osd_client *osdc,
> +		    struct ceph_object_id *oid,
> +		    struct ceph_object_locator *oloc,
> +		    char *lock_name, char *cookie)
> +{
> +	int unlock_op_buf_size;
> +	int name_len = strlen(lock_name);
> +	int cookie_len = strlen(cookie);
> +	void *p, *end;
> +	struct page *unlock_op_page;
> +	int ret;
> +
> +	unlock_op_buf_size = name_len + sizeof(__le32) +
> +			     cookie_len + sizeof(__le32) +
> +			     CEPH_ENCODING_START_BLK_LEN;
> +	if (unlock_op_buf_size > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	unlock_op_page = alloc_page(GFP_NOIO);
> +	if (!unlock_op_page)
> +		return -ENOMEM;
> +
> +	p = page_address(unlock_op_page);
> +	end = p + unlock_op_buf_size;
> +
> +	/* encode cls_lock_unlock_op struct */
> +	ceph_start_encoding(&p, 1, 1,
> +			    unlock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
> +	ceph_encode_string(&p, end, lock_name, name_len);
> +	ceph_encode_string(&p, end, cookie, cookie_len);
> +
> +	dout("%s lock_name %s cookie %s\n", __func__, lock_name, cookie);
> +	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "unlock",
> +			     CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> +			     unlock_op_page, unlock_op_buf_size, NULL, NULL);
> +
> +	dout("%s: status %d\n", __func__, ret);
> +	__free_page(unlock_op_page);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ceph_cls_unlock);
> +
> +/**
> + * ceph_cls_break_lock - release rados lock for object for specified client
> + * @oid, @oloc: object to lock
> + * @lock_name: the name of the lock
> + * @cookie: user-defined identifier for this instance of the lock
> + * @locker: current lock owner
> + */
> +int ceph_cls_break_lock(struct ceph_osd_client *osdc,
> +			struct ceph_object_id *oid,
> +			struct ceph_object_locator *oloc,
> +			char *lock_name, char *cookie,
> +			struct ceph_entity_name *locker)
> +{
> +	int break_op_buf_size;
> +	int name_len = strlen(lock_name);
> +	int cookie_len = strlen(cookie);
> +	struct page *break_op_page;
> +	void *p, *end;
> +	int ret;
> +
> +	break_op_buf_size = name_len + sizeof(__le32) +
> +			    cookie_len + sizeof(__le32) +
> +			    sizeof(u8) + sizeof(__le64) +
> +			    CEPH_ENCODING_START_BLK_LEN;
> +	if (break_op_buf_size > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	break_op_page = alloc_page(GFP_NOIO);
> +	if (!break_op_page)
> +		return -ENOMEM;
> +
> +	p = page_address(break_op_page);
> +	end = p + break_op_buf_size;
> +
> +	/* encode cls_lock_break_op struct */
> +	ceph_start_encoding(&p, 1, 1,
> +			    break_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
> +	ceph_encode_string(&p, end, lock_name, name_len);
> +	ceph_encode_copy(&p, locker, sizeof(*locker));
> +	ceph_encode_string(&p, end, cookie, cookie_len);
> +
> +	dout("%s lock_name %s cookie %s locker %s%llu\n", __func__, lock_name,
> +	     cookie, ENTITY_NAME(*locker));
> +	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "break_lock",
> +			     CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
> +			     break_op_page, break_op_buf_size, NULL, NULL);
> +
> +	dout("%s: status %d\n", __func__, ret);
> +	__free_page(break_op_page);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ceph_cls_break_lock);
> 

