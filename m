From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: fix up endian bug in managing feature bits
Date: Tue, 28 Apr 2020 20:44:35 +0800
Message-ID: <CAAM7YAmBrYhsoBvm3yH4734y2nY2HNUXe9=6AFwk5m3bNG5rEA@mail.gmail.com>
References: <1588023986-23672-1-git-send-email-edward6@linux.ibm.com> <f36451800e4656f99483f4d47487a40ea5f942cd.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726678AbgD1Mot (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:44:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEFDC03C1A9
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2020 05:44:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n143so21556098qkn.8
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2020 05:44:47 -0700 (PDT)
In-Reply-To: <f36451800e4656f99483f4d47487a40ea5f942cd.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: edward6@linux.ibm.com, ceph-devel <ceph-devel@vger.kernel.org>, Ulrich.Weigand@de.ibm.com, Tuan.Hoang1@ibm.com

On Tue, Apr 28, 2020 at 8:23 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2020-04-27 at 23:46 +0200, edward6@linux.ibm.com wrote:
> > From: Eduard Shishkin <edward6@linux.ibm.com>
> >
> > In the function handle_session() variable @features always
> > contains little endian order of bytes. Just because the feature
> > bits are packed bytewise from left to right in
> > encode_supported_features().
> >
> > However, test_bit(), called to check features availability, assumes
> > the host order of bytes in that variable. This leads to problems on
> > big endian architectures. Specifically it is impossible to mount
> > ceph volume on s390.
> >
> > This patch adds conversion from little endian to the host order
> > of bytes, thus fixing the problem.
> >
> > Signed-off-by: Eduard Shishkin <edward6@linux.ibm.com>
> > ---
> >  fs/ceph/mds_client.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 486f91f..190598d 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3252,7 +3252,7 @@ static void handle_session(struct ceph_mds_session *session,
> >       struct ceph_mds_session_head *h;
> >       u32 op;
> >       u64 seq;
> > -     unsigned long features = 0;
> > +     __le64 features = 0;
> >       int wake = 0;
> >       bool blacklisted = false;
> >
> > @@ -3301,7 +3301,7 @@ static void handle_session(struct ceph_mds_session *session,
> >               if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
> >                       pr_info("mds%d reconnect success\n", session->s_mds);
> >               session->s_state = CEPH_MDS_SESSION_OPEN;
> > -             session->s_features = features;
> > +             session->s_features = le64_to_cpu(features);
> >               renewed_caps(mdsc, session, 0);
> >               wake = 1;
> >               if (mdsc->stopping)
>
> (cc'ing Zheng since he did the original patches here)
>
> Thanks Eduard. The problem is real, but I think we can just do the
> conversion during the decode.
>
> The feature mask words sent by the MDS are 64 bits, so if it's smaller
> we can assume that it's malformed. So, I don't think we need to handle
> the case where it's smaller than 8 bytes.
>
> How about this patch instead?
>
> --------------------------8<-----------------------------
>
> ceph: fix endianness bug when handling MDS session feature bits
>
> Eduard reported a problem mounting cephfs on s390 arch. The feature
> mask sent by the MDS is little-endian, so we need to convert it
> before storing and testing against it.
>
> Reported-by: Eduard Shishkin <edward6@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/mds_client.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a8a5b98148ec..6c283c52d401 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3260,8 +3260,7 @@ static void handle_session(struct ceph_mds_session *session,
>         void *end = p + msg->front.iov_len;
>         struct ceph_mds_session_head *h;
>         u32 op;
> -       u64 seq;
> -       unsigned long features = 0;
> +       u64 seq, features = 0;
>         int wake = 0;
>         bool blacklisted = false;
>
> @@ -3280,9 +3279,8 @@ static void handle_session(struct ceph_mds_session *session,
>                         goto bad;
>                 /* version >= 3, feature bits */
>                 ceph_decode_32_safe(&p, end, len, bad);
> -               ceph_decode_need(&p, end, len, bad);
> -               memcpy(&features, p, min_t(size_t, len, sizeof(features)));
> -               p += len;
> +               ceph_decode_64_safe(&p, end, features, bad);
> +               p += len - sizeof(features);
>         }

this one looks better.

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
>
>         mutex_lock(&mdsc->mutex);
> --
> 2.26.1
>
>
