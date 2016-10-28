From: Venky Shankar <vshankar@redhat.com>
Subject: Re: [rbd] should we add iov support to read/write/aio_read/aio_write
Date: Fri, 28 Oct 2016 14:15:31 +0530
Message-ID: <20161028084531.GA1838@h3ckers-pride>
References: <CAKZcxgdxpjv1SATfb5vx7SypnCbmywLPu3MYU+TJOwxO-bUV5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35568 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbcJ1Ipj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2016 04:45:39 -0400
Received: by mail-qk0-f181.google.com with SMTP id z190so77755843qkc.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Oct 2016 01:45:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKZcxgdxpjv1SATfb5vx7SypnCbmywLPu3MYU+TJOwxO-bUV5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org, Jason Dillaman <jdillama@redhat.com>

On 16-10-28 16:36:18, Jaze Lee wrote:
> Hi
>     Should we add iov support at rbd level ?  I think add iov support
> will be valuable for cloud vm which use ceph as the backend.

There's already a WIP PR by Jason for this: https://github.com/ceph/ceph/pull/5898

Though it hasn't been worked on for quite some time.

> 
> 
> 
> 
> 
> -- 
> 谦谦君子
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
