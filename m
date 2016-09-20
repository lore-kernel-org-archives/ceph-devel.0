From: Douglas Fuller <dfuller@redhat.com>
Subject: A design for CephFS forward scrub with multiple MDS
Date: Tue, 20 Sep 2016 13:16:06 -0400
Message-ID: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34208 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbcITRQJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 13:16:09 -0400
Received: by mail-yw0-f179.google.com with SMTP id g192so16595660ywh.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 10:16:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: John Spray <jspray@redhat.com>, Gregory Farnum <gfarnum@redhat.com>

This serves to assemble some discussions we’ve had recently surrounding performing CephFS forward scrub in the case of multiple, active MDSs. I have been doing some implementation work recently in this area and it became a large enough departure from current practice that it’s probably time to revisit the design altogether. This message is intended to summarize the discussions I’ve had so far and to serve as a straw man for any changes that may be needed. It contains a couple questions as well.

Currently, CephFS forward scrub proceeds straightforwardly by enqueuing inodes onto a stack as they are found, completing each parent directory once all of its children have been scrubbed. In a multi-MDS system, this will need to be extended to handle subtrees present on other MDSs.

The proposed design is as follows:

We scrub a local subtree as we would in the single-MDS case: follow the directory hierarchy downward, pushing found items onto a stack and completing directories once all their children are complete. When a subtree boundary is encountered, send a message to the authoritative MDS for that subtree requesting that it be scrubbed. When subtree scrubbing is complete, send a message to the requesting MDS with the completion information and relevant rstats for the parent directory inode (NB: do we have to block the scrubbing of all ancestors, then?).

When popping an inode from the scrub stack, it’s important to note that its authority may have been changed by some intervening export. The scrubbing MDS will drop any file inode for which it is no longer authoritative, assuming this would be handled by the correct MDS. For directory inodes, forward a request to the authoritative MDS to scrub the directory. This may result in attempts to scrub the same inodes more than once (though we track this and can avoid most of the work), it seems necessary in order to guarantee no directories are missed due to splits or exports (NB: this is correct, right?).

Outbound scrub requests will need to be tracked and restarted in the case of MDS failure.

It may be the case that, in the case of a badly thrashing directory hierarchy, that many unnecessary sub-scrub requests may be created and duplicate work attempted. We can short-circuit the duplicate work by noting (as we do in the single-MDS case) when we have already scrubbed an inode and bailing when we attempt to do it again. I’m not sure that extra or unnecessary requests are avoidable or if they will pose a serious performance concern.

Additions, criticisms, clarifications, tomatoes, and other reactions would be appreciated.

Cheers,
—Doug