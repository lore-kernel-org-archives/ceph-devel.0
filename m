From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH] Ceph: Fix use-after-free in destroy_fs_client()
Date: Sat, 25 Dec 2010 22:16:31 +0100
Message-ID: <AANLkTikw_2ztHC4Q0e=QoJ7RjuAXGpX5u0nTjtbdECXa@mail.gmail.com>
References: <alpine.LNX.2.00.1012251858190.10759@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57585 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab0LYVQe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Dec 2010 16:16:34 -0500
In-Reply-To: <alpine.LNX.2.00.1012251858190.10759@swampdragon.chaosbits.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesper Juhl <jj@chaosbits.net>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Sat, Dec 25, 2010 at 7:01 PM, Jesper Juhl <jj@chaosbits.net> wrote:
> Hi,
>
> In fs/ceph/super.c::destroy_fs_client() the pointer 'fsc' is freed by
> kfree() and subsequently used in a call to dout() - use after free bu=
g.
> Easily fixed by simply moving the kfree() call after the dout() call.

As I sad before, %p reads only the address.

> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
> =A0super.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 08b460a..7373594 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -498,8 +498,8 @@ void destroy_fs_client(struct ceph_fs_client *fsc=
)
>
> =A0 =A0 =A0 =A0ceph_destroy_client(fsc->client);
>
> - =A0 =A0 =A0 kfree(fsc);
> =A0 =A0 =A0 =A0dout("destroy_fs_client %p done\n", fsc);
> + =A0 =A0 =A0 kfree(fsc);
> =A0}
>
> =A0/*
>
>
> --
> Jesper Juhl <jj@chaosbits.net> =A0 =A0 =A0 =A0 =A0 =A0http://www.chao=
sbits.net/
> Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
