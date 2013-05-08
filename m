From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: Use min_t() to fix comparison of distinct pointer
 types warning
Date: Wed, 08 May 2013 15:36:27 -0500
Message-ID: <518AB74B.50401@inktank.com>
References: <1368043353-21896-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:61738 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab3EHUg2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 16:36:28 -0400
Received: by mail-ia0-f178.google.com with SMTP id t29so2345783iag.23
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 13:36:28 -0700 (PDT)
In-Reply-To: <1368043353-21896-1-git-send-email-geert@linux-m68k.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/08/2013 03:02 PM, Geert Uytterhoeven wrote:
> drivers/block/rbd.c: In function =E2=80=98zero_pages=E2=80=99:
> drivers/block/rbd.c:1102: warning: comparison of distinct pointer typ=
es lacks a cast
>=20
> Remove the hackish casts and use min_t() to fix this.

Looks good to me.  I'm not sure why I didn't use that to
begin with.

I'll pull this into the ceph tree.  Thanks a lot.

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/block/rbd.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 22ffd5d..1318c6b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1098,8 +1098,8 @@ static void zero_pages(struct page **pages, u64=
 offset, u64 end)
>  		unsigned long flags;
>  		void *kaddr;
> =20
> -		page_offset =3D (size_t)(offset & ~PAGE_MASK);
> -		length =3D min(PAGE_SIZE - page_offset, (size_t)(end - offset));
> +		page_offset =3D offset & ~PAGE_MASK;
> +		length =3D min_t(size_t, PAGE_SIZE - page_offset, end - offset);
>  		local_irq_save(flags);
>  		kaddr =3D kmap_atomic(*page);
>  		memset(kaddr + page_offset, 0, length);
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
