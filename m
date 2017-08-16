From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: default debug_client level is too high
Date: Wed, 16 Aug 2017 11:49:05 -0700
Message-ID: <CA+2bHPYtaDZXay32G09urXaqNfctfPSpFx5_g5RW86sfCQSj4g@mail.gmail.com>
References: <CABZ+qq=cNRn+18bLM6_T_weeEAweg9jKe2n8jjitsDz7bgtpNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35963 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbdHPStg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Aug 2017 14:49:36 -0400
Received: by mail-qk0-f180.google.com with SMTP id o124so16674254qke.3
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 11:49:36 -0700 (PDT)
In-Reply-To: <CABZ+qq=cNRn+18bLM6_T_weeEAweg9jKe2n8jjitsDz7bgtpNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 9, 2017 at 9:32 AM, Dan van der Ster <dan@vanderster.com> wrote:
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
>
> I would therefore propose either increasing the ldout level for these
> ll_* client ops to 6, or decreasing the default debug_client level to
> 0/2.
>
> Any opinions?

I'm in favor of keeping ll_* ops in debug level 3 but not the other
messages, like xattr_permission and the various helpers. I've created
an issue here:

http://tracker.ceph.com/issues/21014

I agree with John's hesitation on reducing the debug level default to 0/2.

-- 
Patrick Donnelly
