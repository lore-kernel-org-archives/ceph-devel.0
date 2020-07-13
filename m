From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph : client only want latest osdmap. If the gap with
 the latest version exceeds the threshold, mon will send the fullosdmap
 instead of incremental osdmap
Date: Mon, 13 Jul 2020 16:01:51 +0200
Message-ID: <CAOi1vP9Qu4QZcpLBYcpmxfsBFh-p0MxOFKw75qZH6QM=AusSPQ@mail.gmail.com>
References: <1594439373-2120-1-git-send-email-simon29rock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbgGMOBr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2020 10:01:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2CC061755
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2020 07:01:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so11249047ila.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2020 07:01:47 -0700 (PDT)
In-Reply-To: <1594439373-2120-1-git-send-email-simon29rock@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: simon gao <simon29rock@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jul 11, 2020 at 5:52 AM simon gao <simon29rock@gmail.com> wrote:
>
> Fix: https://tracker.ceph.com/issues/43421
> Signed-off-by: simon gao <simon29rock@gmail.com>
> ---
>  include/linux/ceph/ceph_fs.h | 1 +
>  net/ceph/mon_client.c        | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> index ebf5ba6..9dcc132 100644
> --- a/include/linux/ceph/ceph_fs.h
> +++ b/include/linux/ceph/ceph_fs.h
> @@ -208,6 +208,7 @@ struct ceph_client_mount {
>  } __attribute__ ((packed));
>
>  #define CEPH_SUBSCRIBE_ONETIME    1  /* i want only 1 update after have */
> +#define CEPH_SUBSCRIBE_LATEST_OSDMAP   2  /* i want the latest fullmap, for client */
>
>  struct ceph_mon_subscribe_item {
>         __le64 start;
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 3d8c801..8d67671 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -349,7 +349,8 @@ static bool __ceph_monc_want_map(struct ceph_mon_client *monc, int sub,
>  {
>         __le64 start = cpu_to_le64(epoch);
>         u8 flags = !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
> -
> +       if (CEPH_SUB_OSDMAP == sub)
> +            flags |= CEPH_SUBSCRIBE_LATEST_OSDMAP;
>         dout("%s %s epoch %u continuous %d\n", __func__, ceph_sub_str[sub],
>              epoch, continuous);

I left my comments in https://github.com/ceph/ceph/pull/32422.
This patch cannot be considered unless a corresponding change is
merged into Objecter.

Thanks,

                Ilya
