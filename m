From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: Use %zu to format size_t in ceph_fill_inline_data()
Date: Sun, 21 Dec 2014 14:10:19 +0300
Message-ID: <CALFYKtBacSpF0+35gGhAcWe4PKS3-nRXhy98UivBLX2m_vBmwg@mail.gmail.com>
References: <1419159379-11407-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:50094 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbaLULKU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Dec 2014 06:10:20 -0500
Received: by mail-qg0-f54.google.com with SMTP id l89so2408301qgf.27
        for <ceph-devel@vger.kernel.org>; Sun, 21 Dec 2014 03:10:19 -0800 (PST)
In-Reply-To: <1419159379-11407-1-git-send-email-geert@linux-m68k.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Dec 21, 2014 at 1:56 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On 32-bit, where size_t is unsigned int:
>
> fs/ceph/addr.c: In function =E2=80=98ceph_fill_inline_data=E2=80=99:
> fs/ceph/addr.c:1419: warning: format =E2=80=98%lu=E2=80=99 expects ty=
pe =E2=80=98long unsigned int=E2=80=99, but argument 10 has type =E2=80=
=98size_t=E2=80=99
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  fs/ceph/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index f5013d92a7e6b73d..c81c0e004588b9e2 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1416,7 +1416,7 @@ void ceph_fill_inline_data(struct inode *inode,=
 struct page *locked_page,
>                 }
>         }
>
> -       dout("fill_inline_data %p %llx.%llx len %lu locked_page %p\n"=
,
> +       dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n"=
,
>              inode, ceph_vinop(inode), len, locked_page);

Sorry, it's been reported by kbuild robot a couple days ago and is
already fixed along with another warning.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
