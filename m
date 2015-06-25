From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] libceph: Avoid holding the zero page on ceph_msgr_slab_init
 errors
Date: Thu, 25 Jun 2015 09:09:42 -0500
Message-ID: <558C0BA6.2020307@ieee.org>
References: <1435195676-2873-1-git-send-email-benoit.canet@nodalink.com> <1435195676-2873-2-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36087 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbFYOJo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 10:09:44 -0400
Received: by pdcu2 with SMTP id u2so54312795pdc.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 07:09:43 -0700 (PDT)
In-Reply-To: <1435195676-2873-2-git-send-email-benoit.canet@nodalink.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmVub8OudCBDYW5ldA==?= <benoit.canet@nodalink.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 06/24/2015 08:27 PM, Beno=C3=AEt Canet wrote:
> ceph_msgr_slab_init may fail due to a temporary ENOMEM.

Looks good.

> Delay a bit the initialization of zero_page in ceph_msgr_init and
> reorder it's cleanup in _ceph_msgr_exit for readability sake.

I'd say it's not readability, but a proper ordering (tear down
in reverse order of set up).

Reviewed-by: Alex Elder <elder@linaro.org>

> BUG_ON() will not suffer to be postponed in case it is triggered.

This is unrelated, but in cases like this (where there's already
something in place to return an error) we should replace these
BUG_ON() calls with logged errors and a return.  They should
never ever happen, of course (they represent design problems)
but if it did it's better to allow the system to keep running.

> Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
> ---
>   net/ceph/messenger.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 38f06a4..ec68cd3 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -275,22 +275,22 @@ static void _ceph_msgr_exit(void)
>   		ceph_msgr_wq =3D NULL;
>   	}
>
> -	ceph_msgr_slab_exit();
> -
>   	BUG_ON(zero_page =3D=3D NULL);
>   	page_cache_release(zero_page);
>   	zero_page =3D NULL;
> +
> +	ceph_msgr_slab_exit();
>   }
>
>   int ceph_msgr_init(void)
>   {
> +	if (ceph_msgr_slab_init())
> +		return -ENOMEM;
> +
>   	BUG_ON(zero_page !=3D NULL);
>   	zero_page =3D ZERO_PAGE(0);
>   	page_cache_get(zero_page);
>
> -	if (ceph_msgr_slab_init())
> -		return -ENOMEM;
> -
>   	/*
>   	 * The number of active work items is limited by the number of
>   	 * connections, so leave @max_active at default.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
