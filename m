From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 1/1 linux-next] ceph: use %zu for size_t display
Date: Mon, 5 Jan 2015 12:31:09 +0300
Message-ID: <CALFYKtDRfxBF-3KaAPMK4S35xeARNZQkLq2ckUfSob+YHQ5x3Q@mail.gmail.com>
References: <1420304531-15176-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:52717 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbbAEJbK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 04:31:10 -0500
Received: by mail-qg0-f43.google.com with SMTP id z107so15051499qgd.16
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 01:31:09 -0800 (PST)
In-Reply-To: <1420304531-15176-1-git-send-email-fabf@skynet.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fabian Frederick <fabf@skynet.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jan 3, 2015 at 8:02 PM, Fabian Frederick <fabf@skynet.be> wrote:
> Fixes the following 32-bit compilation warning:
> fs/ceph/addr.c:1419:2: warning: format '%lu' expects argument of type
> 'long unsigned int', but argument 5 has type 'size_t' [-Wformat=]
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  fs/ceph/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index f5013d9..c81c0e0 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1416,7 +1416,7 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
>                 }
>         }
>
> -       dout("fill_inline_data %p %llx.%llx len %lu locked_page %p\n",
> +       dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
>              inode, ceph_vinop(inode), len, locked_page);
>
>         if (len > 0) {

This was fixed a while ago but hasn't been pushed to linux-next.  I'll
try to make a point of pushing such fixes immediately in the future.

Thanks,

                Ilya
