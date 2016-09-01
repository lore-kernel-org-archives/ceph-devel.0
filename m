From: Sage Weil <sage@newdream.net>
Subject: Re: Switching cephfs suites from btrfs to xfs
Date: Thu, 1 Sep 2016 14:16:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609011415390.19032@piezo.us.to>
References: <CALe9h7e7ePnRe+cmFO4DZTwCbJJErVbwpHH4YzGur9LtgxXHdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38796 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbcIAOQH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Sep 2016 10:16:07 -0400
In-Reply-To: <CALe9h7e7ePnRe+cmFO4DZTwCbJJErVbwpHH4YzGur9LtgxXHdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 1 Sep 2016, John Spray wrote:
> Given our current push toward bluestore as the long term plan, I'm
> wondering if anyone would object to me switching off the use of btrfs
> in the CephFS test suites?

Sounds good to me!

sage

> I think the motivation for this historically was to maximise coverage
> of the FileStore pieces that XFS doesn't exercise, but that probably
> matters less these days, and the (much larger) rados suite covers
> btrfs.
> 
> My motivation is to get rid of the intermittent assert(0 ==
> "unexpected error") OSD crashes that crop up in our testing every once
> in a while and are attributed to btrfs.
> 
> Thoughts?
> 
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
