From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: ceph_features.h: drop duplicated word in a comment
Date: Sat, 18 Jul 2020 07:00:06 -0400
Message-ID: <db5f0447a43c9820a020d1dfcb80637029e4e516.camel@kernel.org>
References: <37c50064-e4ee-d79f-5a9f-2824479b01ca@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgGRLAI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 18 Jul 2020 07:00:08 -0400
In-Reply-To: <37c50064-e4ee-d79f-5a9f-2824479b01ca@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 2020-07-17 at 16:36 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "the" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: ceph-devel@vger.kernel.org
> ---
>  include/linux/ceph/ceph_features.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200714.orig/include/linux/ceph/ceph_features.h
> +++ linux-next-20200714/include/linux/ceph/ceph_features.h
> @@ -58,7 +58,7 @@
>   *    because 10.2.z (jewel) did not care if its peers advertised this
>   *    feature bit.
>   *
> - *  - In the second phase we stop advertising the the bit and call it
> + *  - In the second phase we stop advertising the bit and call it
>   *    RETIRED.  This can normally be done in the *next* major release
>   *    following the one in which we marked the feature DEPRECATED.  In
>   *    the above example, for 12.0.z (luminous) we can say:
> 

Merged into the testing branch. Thanks, Randy!
-- 
Jeff Layton <jlayton@kernel.org>
