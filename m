From: John Spray <jspray@redhat.com>
Subject: Re: default debug_client level is too high
Date: Wed, 9 Aug 2017 17:42:17 +0100
Message-ID: <CALe9h7fXYc_nLB-rybtoz7QNaXVwHsMF5k+XH_sgLS7e+ndV+A@mail.gmail.com>
References: <CABZ+qq=cNRn+18bLM6_T_weeEAweg9jKe2n8jjitsDz7bgtpNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33485 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbdHIQmj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 12:42:39 -0400
Received: by mail-oi0-f46.google.com with SMTP id f11so51593014oic.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 09:42:38 -0700 (PDT)
In-Reply-To: <CABZ+qq=cNRn+18bLM6_T_weeEAweg9jKe2n8jjitsDz7bgtpNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 9, 2017 at 5:32 PM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi all,
>
> During some ceph-fuse perf testing I've noticed that small buffered
> write throughput is slowed down by the debug_client ldout logs.
> At the default 0/5, the in mem log is filled with, e.g.:
>
>  -9760> 2017-08-09 18:16:10.487511 7f848c1a5700  3 client.407554315
> xattr_permission 0x7f84a52c8a00 = 0
>  -9759> 2017-08-09 18:16:10.487515 7f848c1a5700  3 client.407554315
> _getxattr(10003284f73, "security.capability", 0) = -61
>  -9758> 2017-08-09 18:16:10.487525 7f848c1a5700  3 client.407554315
> ll_forget 10003284f73 1
>  -9757> 2017-08-09 18:16:10.487542 7f848b9a4700  3 client.407554315
> ll_write 0x7f84a5147680 10003284f73 71824~1
>  -9756> 2017-08-09 18:16:10.487566 7f848b9a4700  3 client.407554315
> ll_write 0x7f84a5147680 71824~1 = 1
>  -9755> 2017-08-09 18:16:10.487599 7f848c9a6700  3 client.407554315
> ll_getxattr 10003284f73.head security.capability size 0
>  -9754> 2017-08-09 18:16:10.487609 7f848c9a6700  3 client.407554315
> xattr_permission 0x7f84a52c8a00 = 0
>  -9753> 2017-08-09 18:16:10.487612 7f848c9a6700  3 client.407554315
> _getxattr(10003284f73, "security.capability", 0) = -61
>
> (so even tiny 1 byte buffered writes result in huge amounts of logging work).
>
> In a simple test [1], I found that 100000 one byte writes takes
> ~10-11s with the default client log level, and ~5 to 6s with
> debug_client=0/2.

Wow, I had no idea the overhead was so high!

> I would therefore propose either increasing the ldout level for these
> ll_* client ops to 6, or decreasing the default debug_client level to
> 0/2.

Hmm.  I'm not sure what would be left in the memory log at 0/2 though?
 For example in the case of a crash would we even have the message
from the start of the operation that crashed?

John

>
> Any opinions?
>
> Cheers, Dan
>
> [1]
> for i in xrange(100000):
>   f.write('x')
>   f.flush()
> f.close()
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
