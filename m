From: Ridge Chen <ridge.chen@gmail.com>
Subject: OSDs marked OUT wrongly after monitor failover
Date: Thu, 27 Oct 2016 10:36:05 +0800
Message-ID: <CAOb-7Ewpqg1XhCE5HY2P0HcFaZi8CLOzAy=KAFTqisWYiuJXdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36542 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933677AbcJ0Cgg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 22:36:36 -0400
Received: by mail-qt0-f170.google.com with SMTP id 12so14067175qtm.3
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 19:36:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Experts,

Recently we find an issue with our ceph cluster, the version is 0.94.6.

We want to add additional RAM to the ceph nodes, so we need to stop
the ceph service on the nodes first. When we did that on the first
node, we found the OSDs on that node marked OUT and backfill started
(DOWN is expected in this case). The first node is somewhat special
that it is also the location of the leader monitor.

Then checked the monitor log and found the following:

cluster [INF] osd.0 out (down for 3375169.141844)

Looks like the monitor (who just become leader) has wrong
"down_pending_out" records and computes out a  a very long DOWN time ,
finally decides to mark them OUT.

After researching the related code, the reason could be that:

1. "down_pending_out" is set a month ago for those OSDs because of a
network issue.
2. The down OSDs up and join the cluster again. "down_pending_out" is
cleared in the "OSDMonitor::tick()" method. But only happened on
leader monitor.
3. When we stop the ceph service on the first node. The monitor group
failover. The new leader monitor will recognize the OSDs kept in DOWN
status for a a very long time, and mark them OUT wrongly.


What do you think of this?

Regards
Ridge
