From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/5] libceph: drop version variable from
 ceph_monmap_decode()
Date: Tue, 23 May 2017 12:42:53 -0500
Message-ID: <0e2fdc26-2e4b-bc18-46a1-11772b2285b1@ieee.org>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
 <1495557238-1077-4-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33075 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdEWRmz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 13:42:55 -0400
Received: by mail-io0-f169.google.com with SMTP id p24so102497448ioi.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 10:42:54 -0700 (PDT)
In-Reply-To: <1495557238-1077-4-git-send-email-idryomov@gmail.com>
Content-Language: en-CA
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 05/23/2017 11:33 AM, Ilya Dryomov wrote:
> It's set but not used: CEPH_FEATURE_MONNAMES feature bit isn't
> advertised, which guarantees a v1 MonMap.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/mon_client.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 29a0ef351c5e..250f11f78609 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -43,15 +43,13 @@ struct ceph_monmap *ceph_monmap_decode(void *p, void *end)
>  	int i, err = -EINVAL;
>  	struct ceph_fsid fsid;
>  	u32 epoch, num_mon;
> -	u16 version;
>  	u32 len;
>  
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	ceph_decode_need(&p, end, len, bad);
>  
>  	dout("monmap_decode %p %p len %d\n", p, end, (int)(end-p));
> -
> -	ceph_decode_16_safe(&p, end, version, bad);
> +	p += sizeof(u16);  /* skip version */
>  
>  	ceph_decode_need(&p, end, sizeof(fsid) + 2*sizeof(u32), bad);
>  	ceph_decode_copy(&p, &fsid, sizeof(fsid));
> 

