From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 01/16] libceph: fix off-by-one bug in ceph_encode_filepath()
Date: Wed, 11 Jul 2012 11:35:47 -0700
Message-ID: <4FFDC783.9040600@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8701.6020203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43295 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082Ab2GKSfu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 14:35:50 -0400
Received: by gglu4 with SMTP id u4so1562662ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 11:35:50 -0700 (PDT)
In-Reply-To: <4FFD8701.6020203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 07/11/2012 07:00 AM, Alex Elder wrote:
> There is a BUG_ON() call that doesn't account for the single byte
> structure version at the start of an encoded filepath in
> ceph_encode_filepath().  Fix that.
>
> Signed-off-by: Alex Elder<elder@inktank.com>
> ---
>   include/linux/ceph/decode.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index d8615de..bcbd66c 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -151,7 +151,7 @@ static inline void ceph_encode_filepath(void **p,
> void *end,
>   					u64 ino, const char *path)
>   {
>   	u32 len = path ? strlen(path) : 0;
> -	BUG_ON(*p + sizeof(ino) + sizeof(len) + len>  end);
> +	BUG_ON(*p + 1 + sizeof(ino) + sizeof(len) + len>  end);
>   	ceph_encode_8(p, 1);
>   	ceph_encode_64(p, ino);
>   	ceph_encode_32(p, len);

