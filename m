From: John Spray <jspray@redhat.com>
Subject: Switching cephfs suites from btrfs to xfs
Date: Thu, 1 Sep 2016 11:33:10 +0100
Message-ID: <CALe9h7e7ePnRe+cmFO4DZTwCbJJErVbwpHH4YzGur9LtgxXHdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35183 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932676AbcIAKdc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Sep 2016 06:33:32 -0400
Received: by mail-qk0-f170.google.com with SMTP id v123so79677782qkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 01 Sep 2016 03:33:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Given our current push toward bluestore as the long term plan, I'm
wondering if anyone would object to me switching off the use of btrfs
in the CephFS test suites?

I think the motivation for this historically was to maximise coverage
of the FileStore pieces that XFS doesn't exercise, but that probably
matters less these days, and the (much larger) rados suite covers
btrfs.

My motivation is to get rid of the intermittent assert(0 ==
"unexpected error") OSD crashes that crop up in our testing every once
in a while and are attributed to btrfs.

Thoughts?

John
