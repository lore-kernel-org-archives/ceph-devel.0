From: Elita Lobo <loboelita@gmail.com>
Subject: Osds shift within Placement group
Date: Sun, 24 Sep 2017 15:32:22 +0530
Message-ID: <CAA8xDw32j8wHmT7==k2UsMGs-sfgY4b9f1__6StySVtUWScmdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:44168 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdIXKCX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Sep 2017 06:02:23 -0400
Received: by mail-yw0-f180.google.com with SMTP id r85so3094643ywg.1
        for <ceph-devel@vger.kernel.org>; Sun, 24 Sep 2017 03:02:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi ,

We are trying to simulate repair of single/multiple erasures using cl
msr. When we remove one or more osds , we see that other osds shift
positions within the placement group.

Eg -  This is how our original PG looked -
[10,8,11,6,12,13,15,14,3,4,0,24,21,19]
 we had 25 osds available in total and  k=10 and m=4 (n=14) . When we
removed osd 14 and osd 15, some of the osds changed their positions
within the PG.

Resulting PG: [10,8,11,6,21,19,22,23,3,4,0,24,12,13]
Original PG:    [10,8,11,6,12,13,15,14,3,4,0,24,21,19]

As you can see osds 12,13 have exchanged positions with osds 21,19.

Can we avoid this and only let the removed osd be replaced by a
different available osd?
Also can you please explain under what conditions osds will shift within the PG?

Thanks,
Elita
