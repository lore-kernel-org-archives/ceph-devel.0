From: John Spray <jspray@redhat.com>
Subject: Re: MDS balancer modes / docs
Date: Mon, 21 Nov 2016 14:54:36 +0000
Message-ID: <CALe9h7dZFTDahVRENpCSHwpKjtCKfwC4m2zVhSQNmyoAz+ermA@mail.gmail.com>
References: <CAMdDSN2Ybqa3jLhW7j6fu7qt+35K7LoFuJsn=UNC=oZuyJgsbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35657 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbcKUOy5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2016 09:54:57 -0500
Received: by mail-qk0-f181.google.com with SMTP id n204so353813390qke.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2016 06:54:57 -0800 (PST)
In-Reply-To: <CAMdDSN2Ybqa3jLhW7j6fu7qt+35K7LoFuJsn=UNC=oZuyJgsbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brett Niver <bniver@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 21, 2016 at 2:47 PM, Brett Niver <bniver@redhat.com> wrote:
> Jewel docs say:
>
> mds bal mode
>
> Description:
>
> The method for calculating MDS load.
>
> 1 = Hybrid.
> 2 = Request rate and latency.
> 3 = CPU load.
>
> Type:
>
> 32-bit Integer
>
> Default: 0
>
> -----------------------------
> which is confusing in and of itself,but code seems to use :
> 0: hybrid
> 1: request rate and queue length (latency)
> 2: cpu load.
>
> doc bug, or do we subtract one somewhere? :-).

Looks like the docs are just wrong.

John

> Thanks,
> Brett
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
