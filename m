From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: Switching cephfs suites from btrfs to xfs
Date: Thu, 1 Sep 2016 20:51:10 -0400
Message-ID: <CA+2bHPZi87JdOVRUDgXjJQE6836zp16us2a+DVU-upWt6B0FLA@mail.gmail.com>
References: <CALe9h7e7ePnRe+cmFO4DZTwCbJJErVbwpHH4YzGur9LtgxXHdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35545 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbcIBAvm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Sep 2016 20:51:42 -0400
Received: by mail-qk0-f175.google.com with SMTP id v123so103399755qkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 01 Sep 2016 17:51:41 -0700 (PDT)
In-Reply-To: <CALe9h7e7ePnRe+cmFO4DZTwCbJJErVbwpHH4YzGur9LtgxXHdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 1, 2016 at 6:33 AM, John Spray <jspray@redhat.com> wrote:
> Given our current push toward bluestore as the long term plan, I'm
> wondering if anyone would object to me switching off the use of btrfs
> in the CephFS test suites?
>
> I think the motivation for this historically was to maximise coverage
> of the FileStore pieces that XFS doesn't exercise, but that probably
> matters less these days, and the (much larger) rados suite covers
> btrfs.
>
> My motivation is to get rid of the intermittent assert(0 ==
> "unexpected error") OSD crashes that crop up in our testing every once
> in a while and are attributed to btrfs.

I like the idea. +1

-- 
Patrick Donnelly
