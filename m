From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: which Linux kernel version corresponds to 0.48argonaut?
Date: Thu, 20 Dec 2012 18:37:45 -0700
Message-ID: <50D3BD69.8010305@cs.utah.edu>
References: <50D35ECA.4040602@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:58266 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab2LUBhr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 20:37:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 5B59A6500C5
	for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 18:37:46 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
	by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N1QXVBUTwHW2 for <ceph-devel@vger.kernel.org>;
	Thu, 20 Dec 2012 18:37:45 -0700 (MST)
Received: from [155.99.162.136] (155-99-162-136.uconnect.utah.edu [155.99.162.136])
	by smtps.cs.utah.edu (Postfix) with ESMTPSA id C28786500BC
	for <ceph-devel@vger.kernel.org>; Thu, 20 Dec 2012 18:37:45 -0700 (MST)
In-Reply-To: <50D35ECA.4040602@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This may be useful for other Ceph newbies just like me.

I have ported my changes to 0.48argonaut to related Ceph files included 
in Linux, though files with the same name are not exactly the same. Then 
I recompiled and installed the kernel. After that, everything seems to 
be working again now: Ceph is working with my new simple replica 
placement algorithm. :)
So, it seems that Ceph files included in the Linux kernel are supposed 
to be different from those in 0.48argonaut. Presumably, the Linux kernel 
contains the client-side implementation while 0.48argonaut contains the 
server-side implementation. It would be appreciated if someone can 
confirm it. Thank you!

Xing

On 12/20/2012 11:54 AM, Xing Lin wrote:
> Hi,
>
> I was trying to add a simple replica placement algorithm in Ceph. This 
> algorithm simply returns r_th item in a bucket for the r_th replica. I 
> have made that change in Ceph source code (including files such as 
> crush.h, crush.c, mapper.c, ...) and I can run Ceph monitor and osd 
> daemons. However, I am not able to map rbd block devices at client 
> machines. 'rbd map image0' reported "input/output error" and 'dmesg' 
> at the client machine showed message like "libceph: handle_map corrupt 
> msg". I believe that is because I have not ported my changes to Ceph 
> client side programs and it does not recognize the new placement 
> algorithm. I probably need to recompile the rbd block device driver. 
> When I was trying to replace Ceph related files in Linux with my own 
> version, I noticed that files in Linux-3.2.16 are different from these 
> included in Ceph source code. For example, the following is the diff 
> of crush.h in Linux-3.2.16 and 0.48argonaut. So, my question is that 
> is there any version of Linux that contains the exact Ceph files as 
> included in 0.48argonaut? Thanks.
>
> -------------------
>  $ diff -uNrp ceph-0.48argonaut/src/crush/crush.h 
> linux-3.2.16/include/linux/crush/crush.h
> --- ceph-0.48argonaut/src/crush/crush.h    2012-06-26 
> 11:56:36.000000000 -0600
> +++ linux-3.2.16/include/linux/crush/crush.h    2012-04-22 
> 16:31:32.000000000 -0600
> @@ -1,12 +1,7 @@
>  #ifndef CEPH_CRUSH_CRUSH_H
>  #define CEPH_CRUSH_CRUSH_H
>
> -#if defined(__linux__)
>  #include <linux/types.h>
> -#elif defined(__FreeBSD__)
> -#include <sys/types.h>
> -#include "include/inttypes.h"
> -#endif
>
>  /*
>   * CRUSH is a pseudo-random data distribution algorithm that
> @@ -156,24 +151,25 @@ struct crush_map {
>      struct crush_bucket **buckets;
>      struct crush_rule **rules;
>
> +    /*
> +     * Parent pointers to identify the parent bucket a device or
> +     * bucket in the hierarchy.  If an item appears more than
> +     * once, this is the _last_ time it appeared (where buckets
> +     * are processed in bucket id order, from -1 on down to
> +     * -max_buckets.
> +     */
> +    __u32 *bucket_parents;
> +    __u32 *device_parents;
> +
>      __s32 max_buckets;
>      __u32 max_rules;
>      __s32 max_devices;
> -
> -    /* choose local retries before re-descent */
> -    __u32 choose_local_tries;
> -    /* choose local attempts using a fallback permutation before
> -     * re-descent */
> -    __u32 choose_local_fallback_tries;
> -    /* choose attempts before giving up */
> -    __u32 choose_total_tries;
> -
> -    __u32 *choose_tries;
>  };
>
>
>  /* crush.c */
> -extern int crush_get_bucket_item_weight(const struct crush_bucket *b, 
> int pos);
> +extern int crush_get_bucket_item_weight(struct crush_bucket *b, int 
> pos);
> +extern void crush_calc_parents(struct crush_map *map);
>  extern void crush_destroy_bucket_uniform(struct crush_bucket_uniform 
> *b);
>  extern void crush_destroy_bucket_list(struct crush_bucket_list *b);
>  extern void crush_destroy_bucket_tree(struct crush_bucket_tree *b);
> @@ -181,9 +177,4 @@ extern void crush_destroy_bucket_straw(s
>  extern void crush_destroy_bucket(struct crush_bucket *b);
>  extern void crush_destroy(struct crush_map *map);
>
> -static inline int crush_calc_tree_node(int i)
> -{
> -    return ((i+1) << 1)-1;
> -}
> -
>  #endif
>
> ----
> Xing
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

