From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 01/16] libceph: fix off-by-one bug in ceph_encode_filepath()
Date: Wed, 11 Jul 2012 09:59:13 -0700
Message-ID: <CAC-hyiHtDuYR=o-LRAPOdqhhFjLKxFL=Tz=N_D3NvW_1x=Qg_g@mail.gmail.com>
References: <4FFD847C.7070205@inktank.com>
	<4FFD8701.6020203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64428 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab2GKQ7O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 12:59:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1341484bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 09:59:13 -0700 (PDT)
In-Reply-To: <4FFD8701.6020203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, Jul 11, 2012 at 7:00 AM, Alex Elder <elder@inktank.com> wrote:
> There is a BUG_ON() call that doesn't account for the single byte
> structure version at the start of an encoded filepath in
> ceph_encode_filepath().  Fix that.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  include/linux/ceph/decode.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index d8615de..bcbd66c 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -151,7 +151,7 @@ static inline void ceph_encode_filepath(void **p,
> void *end,
>                                         u64 ino, const char *path)
>  {
>         u32 len = path ? strlen(path) : 0;
> -       BUG_ON(*p + sizeof(ino) + sizeof(len) + len > end);
> +       BUG_ON(*p + 1 + sizeof(ino) + sizeof(len) + len > end);
>         ceph_encode_8(p, 1);
>         ceph_encode_64(p, ino);
>         ceph_encode_32(p, len);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
