From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 09/33] libceph: fix crush_decode() call site in osdmap_decode()
Date: Thu, 27 Mar 2014 14:45:31 -0500
Message-ID: <53347FDB.5030203@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-10-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:62045 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbaC0TpK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 15:45:10 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so1876815igc.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 12:45:09 -0700 (PDT)
In-Reply-To: <1395944299-21970-10-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
> The size of the memory area feeded to crush_decode() should be limited
> not only by osdmap end, but also by the crush map length.  Also, drop

You're also letting crush_decode() verify it has the buffer space
it needs internally, rather than checking it before making the call,
which is good.  (Though I guess you don't have to mention it.)

> unnecessary dout() (dout() in crush_decode() conveys the same info) and
> step past crush map only if it is decoded successfully.

I actually think crush_decode() should take a (void **)
instead, as its first argument and advance the pointer
by as much as it uses (like most of the other routines do).
That's a suggestion, but I don't really care, this is fine.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osdmap.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 19aca4d3c5dd..b70357adbdc0 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -796,16 +796,13 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
>  
>  	/* crush */
>  	ceph_decode_32_safe(p, end, len, e_inval);
> -	dout("osdmap_decode crush len %d from off 0x%x\n", len,
> -	     (int)(*p - start));
> -	ceph_decode_need(p, end, len, e_inval);
> -	map->crush = crush_decode(*p, end);
> -	*p += len;
> +	map->crush = crush_decode(*p, min(*p + len, end));
>  	if (IS_ERR(map->crush)) {
>  		err = PTR_ERR(map->crush);
>  		map->crush = NULL;
>  		goto bad;
>  	}
> +	*p += len;
>  
>  	/* ignore the rest */
>  	*p = end;
> 

