From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 3/9] libceph: report socket read/write error message
Date: Tue, 24 Jul 2012 15:26:23 -0700
Message-ID: <CAC-hyiEXC1gOV8FRi7D3+4HtUsDW41WCj+Pk_brTDv-1Vxjung@mail.gmail.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
	<1342831308-18815-4-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35829 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab2GXW0Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 18:26:24 -0400
Received: by bkwj10 with SMTP id j10so52079bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 15:26:23 -0700 (PDT)
In-Reply-To: <1342831308-18815-4-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> We need to set error_msg to something useful before calling ceph_fault();
> do so here for try_{read,write}().  This is more informative than
>
> libceph: osd0 192.168.106.220:6801 (null)
>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/messenger.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 12419a0..7105908 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2291,14 +2291,18 @@ restart:
>         ret = try_read(con);
>         if (ret == -EAGAIN)
>                 goto restart;
> -       if (ret < 0)
> +       if (ret < 0) {
> +               con->error_msg = "socket error on read";
>                 goto fault;
> +       }
>
>         ret = try_write(con);
>         if (ret == -EAGAIN)
>                 goto restart;
> -       if (ret < 0)
> +       if (ret < 0) {
> +               con->error_msg = "socket error on write";
>                 goto fault;
> +       }
>
>  done:
>         mutex_unlock(&con->mutex);
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
