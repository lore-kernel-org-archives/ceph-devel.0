From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 1/6] libceph: make encode_request_*() work with r_mempool requests
Date: Mon, 31 Jul 2017 09:55:14 +0800
Message-ID: <CAAM7YAnGFt7uqY1jeLfwG+PvmWzqdO1KcSs-Wv=ngw3bDdUvug@mail.gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com> <1501245690-2362-2-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36519 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbdGaBzQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Jul 2017 21:55:16 -0400
Received: by mail-ua0-f196.google.com with SMTP id w45so22692115uac.3
        for <ceph-devel@vger.kernel.org>; Sun, 30 Jul 2017 18:55:15 -0700 (PDT)
In-Reply-To: <1501245690-2362-2-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 28, 2017 at 8:41 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Messages allocated out of ceph_msgpool have a fixed front length
> (pool->front_len).  Asserting that the entire front has been filled
> while encoding is thus wrong.
>
> Fixes: 8cb441c0545d ("libceph: MOSDOp v8 encoding (actual spgid + full hash)")
> Reported-by: "Yan, Zheng" <zyan@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  net/ceph/osd_client.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 901bb8221366..b5f016cb9569 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1918,10 +1918,12 @@ static void encode_request_partial(struct ceph_osd_request *req,
>         }
>
>         ceph_encode_32(&p, req->r_attempts); /* retry_attempt */
> -       BUG_ON(p != end - 8); /* space for features */
> +       BUG_ON(p > end - 8); /* space for features */
>
>         msg->hdr.version = cpu_to_le16(8); /* MOSDOp v8 */
>         /* front_len is finalized in encode_request_finish() */
> +       msg->front.iov_len = p - msg->front.iov_base;
> +       msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>         msg->hdr.data_len = cpu_to_le32(data_len);
>         /*
>          * The header "data_off" is a hint to the receiver allowing it
> @@ -1937,11 +1939,12 @@ static void encode_request_partial(struct ceph_osd_request *req,
>  static void encode_request_finish(struct ceph_msg *msg)
>  {
>         void *p = msg->front.iov_base;
> +       void *const partial_end = p + msg->front.iov_len;
>         void *const end = p + msg->front_alloc_len;
>
>         if (CEPH_HAVE_FEATURE(msg->con->peer_features, RESEND_ON_SPLIT)) {
>                 /* luminous OSD -- encode features and be done */
> -               p = end - 8;
> +               p = partial_end;
>                 ceph_encode_64(&p, msg->con->peer_features);
>         } else {
>                 struct {
> @@ -1984,7 +1987,7 @@ static void encode_request_finish(struct ceph_msg *msg)
>                 oid_len = p - oid;
>
>                 tail = p;
> -               tail_len = (end - p) - 8;
> +               tail_len = partial_end - p;
>
>                 p = msg->front.iov_base;
>                 ceph_encode_copy(&p, &head.client_inc, sizeof(head.client_inc));
> --
> 2.4.3
>
> --

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>


> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
