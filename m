From: John Spray <jspray@redhat.com>
Subject: Permuting only some things with teuthology-suite --subset
Date: Thu, 16 Feb 2017 23:11:03 +0000
Message-ID: <CALe9h7dmdBKgc6DXdycRC1wXgRDMH560=RuK_ZYKzhJKvFQFKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36848 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPXLZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 18:11:25 -0500
Received: by mail-wm0-f49.google.com with SMTP id c85so77678603wmi.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 15:11:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Evening all,

I'm wondering if this is something that's buried in the existing code,
or if others have thought about it -- I'd like to be able to do the
--subset sampling, but only on some aspects of a suite.  Specifically,
in the fs suite we have some RADOS-level options like xfs vs.
bluestore, forthcoming EC vs. replication, and I'd like to sample
those, while still running all the cephfs-specific permutations
exhaustively.

So if this doesn't already exist I guess it could look something like
--suite fs --subset=1/3, --subset-filter=rados_* (e.g. if I adopted a
naming convention where dirs/files controlling the rados-ish bits wre
named like that).

Any thoughts?

John
