From: Sage Weil <sage@inktank.com>
Subject: Re: RFC: object operation instruction set
Date: Fri, 22 Nov 2013 14:54:42 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311221448410.2298@cobra.newdream.net>
References: <BC963CDE-A36F-42EE-AC7D-6638D878BBCD@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34240 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab3KVWyn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Nov 2013 17:54:43 -0500
In-Reply-To: <BC963CDE-A36F-42EE-AC7D-6638D878BBCD@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Sun, 17 Nov 2013, Noah Watkins wrote:
> The ObjectOperation interface in librados is great for performing compound atomic operations. However, it doesn?t seem to be capable of expressing more complex flows. Consider the following set of operations that I one might want to run atomically to optionally initialize an xattr:
> 
>    int ret = getxattr(?foo?)
>    if (ret < 0 && ret != -ENODATA)
>      return ret;
> 
>    if (ret == -ENODATA)
>      /* do some initialization */
>    else
>      /* do something else */
> 
> As it stands, one would need to build a cls_xyz to do this. Alternatively, something like cls_lua could be used, but there is a lot of downsides to that. However, after building several cls_xyz modules, it is clear that the majority of the time is spent doing basic logic, moving some data around, and occasionally doing something like incrementing some counters.
> 
> I?ve put a prototype solution up in github
> 
>     `github.com/ceph/ceph.git obj_op_virt_machine`
> 
> that adds control instructions into the ObjectOperation interface. Using the interface I can express the above logic as follows:
> 
>    ObjectReadOperation op;

Hmm.. I still have a hard time remembering what ObjectReadOperation vs 
ObjectWriteOperation actually mean/enforce.  Especially for these types of 
requests, which could be either (return useful data on read, or if checks 
pass do a mutation).

>    // foo doesn?t exist. the return value
>    // will be placed into a named register ?ret"
>    op.getxattr(?foo?, bl, NULL);

IIRC there is a per-op flag to ignore the return value (or rather, not 
return immediately if it is <0).  

This looks pretty handy!  I think we should be careful about extending 
this interface until we have a pretty good picture of the use-cases, 
though, and at least one user.

sage

> 
>    // jump to label if ?ret? register >= 0
>    op.ois_jge(?ret?, 0, ?has_attr?); 
> 
>    // jump to label if ?ret? register == 0
>    op.ois_jeq(?ret?, -ENODATA, ?no_attr?);
> 
>    // fall through to return any error in the
>    // ?ret? register. returns immediately
>    op.ois_ret(?ret?);
> 
>    // define a label target
>    op.ois_label(?has_attr?);
>    /* ? do some stuff ? */
>    op.ois_ret(0);
> 
>   // defines a label target
>   op.ois_label(?no_attr?);
>   /* ? do initialization ? */
>   op.ois_ret(0);
> 
>   ioctx.operate(?obj?, &op);
> 
> Using only a few instructions, we can get pretty good building blocks. Adding a few to examine some data in primitive ways would add another level of usefulness, too (e.g. atomic counter increment). And, this can also be made safe by ensuring that jumps are always forward, removing any problems like infinite loops.
> 
> - Noah--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
