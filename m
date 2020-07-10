From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] net : client only want latest osdmap. If the gap with the
 latest version exceeds the threshold, mon will send the fullosdmap instead of
 incremental osdmap
Date: Fri, 10 Jul 2020 10:58:02 +0200
Message-ID: <CAOi1vP9vPq9TcG9qiEEtDb795PZ2QjDTye=89E4yrjEaFSHE7g@mail.gmail.com>
References: <1594355944-7137-1-git-send-email-simon29rock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgGJI54 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2020 04:57:56 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B34EC08C5CE
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2020 01:57:56 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h16so4422580ilj.11
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2020 01:57:56 -0700 (PDT)
In-Reply-To: <1594355944-7137-1-git-send-email-simon29rock@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: simon gao <simon29rock@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 10, 2020 at 6:39 AM simon gao <simon29rock@gmail.com> wrote:
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

Hi Simon,

Where is this flag introduced?  Looks like it is mentioned in the
comments of https://github.com/ceph/ceph/pull/32422, but it is not
actually added anywhere I can see.

>
>  struct ceph_mon_subscribe_item {
>         __le64 start;
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 3d8c801..b0d1ce6 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -349,7 +349,8 @@ static bool __ceph_monc_want_map(struct ceph_mon_client *monc, int sub,
>  {
>         __le64 start = cpu_to_le64(epoch);
>         u8 flags = !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
> -
> +    if (CEPH_SUB_OSDMAP == sub)
> +        flags |= CEPH_SUBSCRIBE_LATEST_OSDMAP

This won't compile because of the missing semicolon.

Thanks,

                Ilya
