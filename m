From: John Spray <jspray@redhat.com>
Subject: Re: dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 09:17:36 +0100
Message-ID: <CALe9h7fbRO1bJVf-WGT8HK+tNYEOc2KCvWfMpRTZMKBV0QELBg@mail.gmail.com>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35894 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdF3IR6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jun 2017 04:17:58 -0400
Received: by mail-wm0-f42.google.com with SMTP id 62so103078582wmw.1
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jun 2017 01:17:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jun 30, 2017 at 4:21 AM, Sage Weil <sweil@redhat.com> wrote:
> We're having a series of problems with the valgrind included in xenial[1]
> that have led us to restrict all valgrind tests to centos nodes.  At teh
> same time, we're also seeing spurious ENOSPC errors from btrfs on both
> centos on xenial kernels[2], making trusty the only distro where btrfs
> works reliably.
>
> Teuthology doesn't handle this well when it tries to put together the
> test matrix (we can't test filestore+btrfs+valgrind).
>
> The easiest thing is to
>
> 1/ Stop testing filestore+btrfs for luminous onward.  We've recommended
> against btrfs for a long time and are moving toward bluestore anyway.

+1000

John

> 2/ Leave btrfs in the mix for jewel, and manually tolerate and filter out
> the occasional ENOSPC errors we see.  (They make the test runs noisy but
> are pretty easy to identify.)
>
> If we don't stop testing filestore on btrfs now, I'm not sure when we
> would ever be able to stop, and that's pretty clearly not sustainable.
> Does that seem reasonable?  (Pretty please?)
>
> sage
>
>
> [1] http://tracker.ceph.com/issues/18126 and http://tracker.ceph.com/issues/20360
> [2] http://tracker.ceph.com/issues/20169
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
