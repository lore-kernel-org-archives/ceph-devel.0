From: huang jun <hjwsm1989@gmail.com>
Subject: question about backfill on erasure pool
Date: Tue, 13 Dec 2016 17:58:41 +0800
Message-ID: <CABAwU-b6m6xfLXvLwfR4DXMxW4kwzyvVYpKPm_NzRxzDWoROVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36282 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbcLMJ6n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 04:58:43 -0500
Received: by mail-qt0-f180.google.com with SMTP id w33so101583768qtc.3
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 01:58:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
i have a question about pg backfill on erasure pool.
pg0 in erasure pool, which k:m=2:1,
at first, pg0 on osd [1,2,3], after osd.4 added,
the pg0 is now distribute to osd [1,2,4],
for replicated pool, it will do backfill from primary(osd.1) to osd.4,
for erasure code pool, the primary osd.1 needs to read the data chunks
from osd.1 and osd.2,
then decode and push the parity chunk to osd.4,
in the above case, the osd.3 is up and contain the parity chunk,
why dont let osd.3 push the parity chunk to osd.4?
