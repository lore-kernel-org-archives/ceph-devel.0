From: Oleg Kolosov <olekol@gmail.com>
Subject: LRC has slower recovery than Jerasure
Date: Mon, 11 Sep 2017 23:29:04 +0300
Message-ID: <CAODUPsGPdZ7AL1nYpTP5OE8iqWpcgj=Durm_f_4C=y12tbmnYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:36355 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdIKU3F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Sep 2017 16:29:05 -0400
Received: by mail-io0-f174.google.com with SMTP id d16so34412122ioj.3
        for <ceph-devel@vger.kernel.org>; Mon, 11 Sep 2017 13:29:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I'm working on a new implementation of a new erasure code. During my
development, I began testing the performance of my code & ceph LRC
plugin vs jerasure.
When setting up a cluster with failure domain being only leaf cells
(osd) I saw the expected behaviour - recovery of LRC is faster than
jerasure.
Next I divided my cluster into 5 hosts, each containing 8 osds, and
placed each local group under a different host (using ruleset-steps).
Jerasure still had osd as failure domain. At this point I noticed that
LRC has slower recovery. I've tried a configuration of k=4, l=3 and
total of 9 shards.

I don't think it's collisions in crush, since it shouldn't have such a
heavy effect.
My suspicion is some sort of a throttle. I've tried to set the following:
         osd recovery max active = 500
        osd recovery op priority = 32

But I didn't see any significant improvement.

Can you think of a reason LRC would recover slower than jerasure when
it's constrained to domains as I've described?

Thanks,
Oleg
