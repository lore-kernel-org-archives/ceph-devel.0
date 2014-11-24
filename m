From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 01/12] libceph: add SETXATTR/CMPXATTR osd operations support
Date: Mon, 24 Nov 2014 14:17:03 +0400
Message-ID: <CALFYKtAoxXYRpR1bQ4KtV_UQeWJirwCOktWuw2CHDe5bQqUQfw@mail.gmail.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
	<1416211026-11524-2-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:57074 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbaKXKRF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 05:17:05 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so6441449qcx.26
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 02:17:03 -0800 (PST)
In-Reply-To: <1416211026-11524-2-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, liwang@ubuntukylin.com

On Mon, Nov 17, 2014 at 10:56 AM, Yan, Zheng <zyan@redhat.com> wrote:
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  include/linux/ceph/osd_client.h | 10 ++++++++++
>  net/ceph/osd_client.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 03aeb27..1ad217b 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -87,6 +87,13 @@ struct ceph_osd_req_op {
>                         struct ceph_osd_data osd_data;
>                 } extent;
>                 struct {
> +                       __le32 name_len;
> +                       __le32 value_len;
> +                       __u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
> +                       __u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
> +                       struct ceph_osd_data osd_data;
> +               } xattr;
> +               struct {
>                         const char *class_name;
>                         const char *method_name;
>                         struct ceph_osd_data request_info;
> @@ -295,6 +302,9 @@ extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
>  extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
>                                         unsigned int which, u16 opcode,
>                                         const char *class, const char *method);
> +extern void osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
> +                                 u16 opcode, const char *name, const void *value,
> +                                 size_t size, u8 cmp_op, u8 cmp_mode);
>  extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>                                         unsigned int which, u16 opcode,
>                                         u64 cookie, u64 version, int flag);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1f6c405..f8fb376 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -545,6 +545,34 @@ void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
>  }
>  EXPORT_SYMBOL(osd_req_op_cls_init);
>
> +void osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
> +                         u16 opcode, const char *name, const void *value,
> +                         size_t size, u8 cmp_op, u8 cmp_mode)
> +{
> +       struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
> +       struct ceph_pagelist *pagelist;
> +       size_t payload_len;

Add

BUG_ON(opcode != CEPH_OSD_OP_SETXATTR && opcode != CEPH_OSD_OP_CMPXATTR);

These asserts in osd_req_op_*_init() proved to be useful and some day
we will change from BUG_ONs to something nicer throughout.

> +
> +       pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
> +       BUG_ON(!pagelist);

This BUG_ON OTOH is not useful ;)  Can you make osd_req_op_xattr_init()
return an error and get rid of it?  I know you just pasted this from
osd_req_op_cls_init(), but ceph_uninline_data() is perfectly capable of
handling -ENOMEM so no reason to spread this any further.

Also drop the space after sizeof.

Thanks,

                Ilya
