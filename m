From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] libceph: Remove spurious kunmap() of the zero page
Date: Wed, 24 Jun 2015 19:35:05 -0500
Message-ID: <558B4CB9.3000907@ieee.org>
References: <1435180719-12000-1-git-send-email-benoit.canet@nodalink.com> <1435180719-12000-2-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35838 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbFYAfH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jun 2015 20:35:07 -0400
Received: by pdbci14 with SMTP id ci14so41034300pdb.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Jun 2015 17:35:06 -0700 (PDT)
In-Reply-To: <1435180719-12000-2-git-send-email-benoit.canet@nodalink.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmVub8OudCBDYW5ldA==?= <benoit.canet@nodalink.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 06/24/2015 04:18 PM, Beno=C3=AEt Canet wrote:
> ceph_tcp_sendpage already does the work of mapping/unmapping
> the zero page if needed.
>
> Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>

This looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   net/ceph/messenger.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 967080a..38f06a4 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -278,7 +278,6 @@ static void _ceph_msgr_exit(void)
>   	ceph_msgr_slab_exit();
>
>   	BUG_ON(zero_page =3D=3D NULL);
> -	kunmap(zero_page);
>   	page_cache_release(zero_page);
>   	zero_page =3D NULL;
>   }
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
