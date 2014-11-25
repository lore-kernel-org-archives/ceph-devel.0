From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 01/12] libceph: add SETXATTR/CMPXATTR osd operations support
Date: Tue, 25 Nov 2014 13:46:42 +0400
Message-ID: <CALFYKtBpt08BEhpe+iwoy7dn2m26H=AS_YaArYnYD_1HHzDp9w@mail.gmail.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
	<1416211026-11524-2-git-send-email-zyan@redhat.com>
	<CALFYKtAoxXYRpR1bQ4KtV_UQeWJirwCOktWuw2CHDe5bQqUQfw@mail.gmail.com>
	<8B1B08A1-E953-4E16-AE6A-C26F9BC88D13@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:48221 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaKYJqn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 04:46:43 -0500
Received: by mail-qc0-f182.google.com with SMTP id r5so124876qcx.13
        for <ceph-devel@vger.kernel.org>; Tue, 25 Nov 2014 01:46:43 -0800 (PST)
In-Reply-To: <8B1B08A1-E953-4E16-AE6A-C26F9BC88D13@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Li Wang <liwang@ubuntukylin.com>

On Tue, Nov 25, 2014 at 5:36 AM, =E4=B8=A5=E6=AD=A3 <zyan@redhat.com> w=
rote:
> updated patch
>
> =E2=80=94
> From 1f7963731ccbd2cd0f19d4f357c915e23d702d60 Mon Sep 17 00:00:00 200=
1
> From: "Yan, Zheng" <zyan@redhat.com>
> Date: Wed, 12 Nov 2014 14:00:43 +0800
> Subject: [PATCH 01/12] libceph: add SETXATTR/CMPXATTR osd operations =
support
>
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  include/linux/ceph/osd_client.h | 10 +++++++++
>  net/ceph/osd_client.c           | 47 +++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd=
_client.h
> index 03aeb27..bcf9c21 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -87,6 +87,13 @@ struct ceph_osd_req_op {
>                         struct ceph_osd_data osd_data;
>                 } extent;
>                 struct {
> +                       __le32 name_len;
> +                       __le32 value_len;
> +                       __u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* =
*/
> +                       __u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_=
* */
> +                       struct ceph_osd_data osd_data;
> +               } xattr;
> +               struct {
>                         const char *class_name;
>                         const char *method_name;
>                         struct ceph_osd_data request_info;
> @@ -295,6 +302,9 @@ extern void osd_req_op_cls_response_data_pages(st=
ruct ceph_osd_request *,
>  extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
>                                         unsigned int which, u16 opcod=
e,
>                                         const char *class, const char=
 *method);
> +extern int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, u=
nsigned int which,
> +                                u16 opcode, const char *name, const =
void *value,
> +                                size_t size, u8 cmp_op, u8 cmp_mode)=
;
>  extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>                                         unsigned int which, u16 opcod=
e,
>                                         u64 cookie, u64 version, int =
flag);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1f6c405..489c830 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -292,6 +292,10 @@ static void osd_req_op_data_release(struct ceph_=
osd_request *osd_req,
>                 ceph_osd_data_release(&op->cls.request_data);
>                 ceph_osd_data_release(&op->cls.response_data);
>                 break;
> +       case CEPH_OSD_OP_SETXATTR:
> +       case CEPH_OSD_OP_CMPXATTR:
> +               ceph_osd_data_release(&op->xattr.osd_data);
> +               break;
>         default:
>                 break;
>         }
> @@ -545,6 +549,39 @@ void osd_req_op_cls_init(struct ceph_osd_request=
 *osd_req, unsigned int which,
>  }
>  EXPORT_SYMBOL(osd_req_op_cls_init);
>
> +int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned=
 int which,
> +                         u16 opcode, const char *name, const void *v=
alue,
> +                         size_t size, u8 cmp_op, u8 cmp_mode)
> +{
> +       struct ceph_osd_req_op *op =3D _osd_req_op_init(osd_req, whic=
h, opcode);
> +       struct ceph_pagelist *pagelist;
> +       size_t payload_len;
> +
> +       BUG_ON(opcode !=3D CEPH_OSD_OP_SETXATTR && opcode !=3D CEPH_O=
SD_OP_CMPXATTR);
> +
> +       pagelist =3D kmalloc(sizeof (*pagelist), GFP_NOFS);
> +       if (!pagelist)
> +               return -ENOMEM;
> +
> +       ceph_pagelist_init(pagelist);
> +
> +       payload_len =3D strlen(name);
> +       op->xattr.name_len =3D payload_len;
> +       ceph_pagelist_append(pagelist, name, payload_len);
> +
> +       op->xattr.value_len =3D size;
> +       ceph_pagelist_append(pagelist, value, size);
> +       payload_len +=3D size;
> +
> +       op->xattr.cmp_op =3D cmp_op;
> +       op->xattr.cmp_mode =3D cmp_mode;
> +
> +       ceph_osd_data_pagelist_init(&op->xattr.osd_data, pagelist);
> +       op->payload_len =3D payload_len;
> +       return 0;
> +}
> +EXPORT_SYMBOL(osd_req_op_xattr_init);
> +
>  void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
>                                 unsigned int which, u16 opcode,
>                                 u64 cookie, u64 version, int flag)
> @@ -676,6 +713,16 @@ static u64 osd_req_encode_op(struct ceph_osd_req=
uest *req,
>                 dst->alloc_hint.expected_write_size =3D
>                     cpu_to_le64(src->alloc_hint.expected_write_size);
>                 break;
> +       case CEPH_OSD_OP_SETXATTR:
> +       case CEPH_OSD_OP_CMPXATTR:
> +               dst->xattr.name_len =3D cpu_to_le32(src->xattr.name_l=
en);
> +               dst->xattr.value_len =3D cpu_to_le32(src->xattr.value=
_len);
> +               dst->xattr.cmp_op =3D src->xattr.cmp_op;
> +               dst->xattr.cmp_mode =3D src->xattr.cmp_mode;
> +               osd_data =3D &src->xattr.osd_data;
> +               ceph_osdc_msg_data_add(req->r_request, osd_data);
> +               request_data_len =3D osd_data->pagelist->length;
> +               break;
>         default:
>                 pr_err("unsupported osd opcode %s\n",
>                         ceph_osd_op_name(src->op));

I see you've also added osd_req_op_data_release() hunk.

Reviewed-by: Ilya Dryomov <idryomov@redhat.com>

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
