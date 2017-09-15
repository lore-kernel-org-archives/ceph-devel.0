From: Two Spirit <twospirit6905@gmail.com>
Subject: snapshots
Date: Fri, 15 Sep 2017 10:28:21 -0700
Message-ID: <CAKRxpuukift+7ovzeDnTbNtAzKM6=sBEmoQyLbQUebLJ9rwCQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:48124 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdIOR2W (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 13:28:22 -0400
Received: by mail-io0-f177.google.com with SMTP id e189so10208029ioa.4
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 10:28:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

few questions

1) Is the idea of snapshotting about 100TB of data doable with Ceph?

2) How long would such a task take? Are we talking seconds, minutes,
hours, days, weeks?

3) what does "stop i/o" mean. Does the filesystem unavailable to the
user during the snapshot time, or is this administratively unavailable
to the user, or does ceph stop io somewhere while in parallel the data
can be read/written to?
