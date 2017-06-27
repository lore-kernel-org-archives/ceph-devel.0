From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: cls_rbd copyup and write
Date: Tue, 27 Jun 2017 09:40:35 -0400
Message-ID: <CA+aFP1AJRmsA57aEp-1jQkvLp=NW81hJqUHUM4+HRrpN=8ONHw@mail.gmail.com>
References: <CALZt5jzk+8yS7SY6L+5BNvKuTGDZV+KOW5b=vDqO=R7t_o9Vfw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:36824 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbdF0Nkh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 09:40:37 -0400
Received: by mail-yb0-f180.google.com with SMTP id s9so9352839ybe.3
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 06:40:37 -0700 (PDT)
In-Reply-To: <CALZt5jzk+8yS7SY6L+5BNvKuTGDZV+KOW5b=vDqO=R7t_o9Vfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is definitely an optimization we can test post-Luminous release
once bluestore is the defacto OSD object store. Of course, even
bluestore won't track holes down to 8KiB -- only 16KiB or 64KiB
depending on your backing device and settings. I am pretty sure
Luminous already has an optimization to not copy-up if the full parent
object is zeroed.

I do remember a presentation about surprising results when
implementing NFS v4.2 READ_PLUS sparse support where it actually
degraded performance due to the need to seek the file holes. There
might be a performance trade-off to consider when objects have lots of
holes due to increased metadata plus decreased data locality.

On Tue, Jun 27, 2017 at 4:22 AM, Ning Yao <zay11022@gmail.com> wrote:
> Hi, all
>
> currently I find that when do copy on write for a clone image. librbd
> call the cls copyup function to write the data, reading from its
> parent, to the child.
>
> However, there is a issue here:  if an object in the parent image -->
> [0, 8192] with data and [8192, end] without data, then after COW
> operation, it will filling the whole object [0, end] to the children
> object with [8192, end] all zeros. This phenomenon also occurs in
> flatten images.
>
> Actually, we already have sparse_read to just read data without holes.
> However, copyup function does not support to write serveral fragments
> such as {[0, 8192], [16384,20480]}.
>
> So it that possible to direct send OSDOp {[cow write], [cow write],
> [user write]} instead of  OSDOp {[copyup], [user write]} ?
>
>
>
> Regards
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
