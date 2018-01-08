From: Ugis <ugis22@gmail.com>
Subject: importance of steps when adding osds
Date: Mon, 8 Jan 2018 15:09:37 +0200
Message-ID: <CAE63xUMo=98kD8V4kj7Oh=0eyhRnH35mAJpM8t7kAiSq3WQn3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:42463 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757385AbeAHNJi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 08:09:38 -0500
Received: by mail-io0-f170.google.com with SMTP id x67so13446245ioi.9
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jan 2018 05:09:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Suggestion first: ceph.com  site could have some best practice rules
for adding new OSDs. Googling regarding this topic reveals that people
have questions like:
- may I add serveral OSDSs at once?
- may I completely change crushmap online so that pgs get completely relocated?
- what config parameters help to reduce backfill load?

Until that still have this theoretical question on CRUSH algorithm.
We have ceph cluster with 5 osd hosts, CRUSH rule orders ceph to put
replicas one copy per host.

If we add 2 osds simultaneously in different hosts - how CRUSH
guarantees that some existing pg that now should be located on those
new 2 osds does not get unavailable? Should be something with epochs I
suppose?

Have found thread mentioning that people have tested completely
remapping pgs http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-July/019577.html
Still it is not clear what are the theoretical constraints on adding
bunches of OSDs (except backfill load). For example if pg gets
relocated several times in a row(in case osds get added not waiting
degradation to resolve) - how long that chain of previously allocated
pgs can be?


Any comments demistifying this are appreciated.

Best regards
Ugis
