From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] rbd: Use rbd_segment_name_free
Date: Thu, 24 Jul 2014 12:09:06 +0400
Message-ID: <CALFYKtAA7W5XFjWF4upowZjX5Xhp3RgAUHtCJc7=vT0pqjxyUw@mail.gmail.com>
References: <20140723214707.GA8100@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:52412 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934204AbaGXIJI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:09:08 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so2539548qaq.41
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:09:07 -0700 (PDT)
In-Reply-To: <20140723214707.GA8100@himangi-Dell>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Himangi Saraogi <himangi774@gmail.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>

On Thu, Jul 24, 2014 at 1:47 AM, Himangi Saraogi <himangi774@gmail.com> wrote:
> Free memory allocated using kmem_cache_zalloc using kmem_cache_free
> rather than kfree. The helper rbd_segment_name_free does the job here.
> Its position is shifted above the calling function.
>
> The Coccinelle semantic patch that detects this change is as follows:
>
> // <smpl>
> @@
> expression x,E,c;
> @@
>
>  x = \(kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache_alloc_node\)(c,...)
>  ... when != x = E
>      when != &x
> ?-kfree(x)
> +kmem_cache_free(c,x)
> // </smpl>
>
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied.

Thanks,

                Ilya
