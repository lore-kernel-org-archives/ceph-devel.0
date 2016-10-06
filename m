From: Timofey Titovets <nefelim4ag@gmail.com>
Subject: OSD: btrfs backend
Date: Thu, 6 Oct 2016 19:47:13 +0300
Message-ID: <CAGqmi76N0zcFjQJCtwWGsuJg62FmMfwU+RxNObNGUiX60-j3EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35436 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942171AbcJFQyY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 12:54:24 -0400
Received: by mail-wm0-f49.google.com with SMTP id f193so301620594wmg.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 09:54:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi, it's mostly theoretical question.

AFAIK some time ago Ceph try to use btrfs transactions, after problem
with that, devs try to use (AFAIK) something like:
1. Write to journal
2. fsync()
3. clone data from journal to object file
4. fsync()
5. make snapshot as a transaction end

So, why not do something like:
1. Clone file (may be use O_TMPFILE for cloned file?)
2. Make changes
3. fsync()
4. renameat2() to swap the files.
5. unlink() old file

AFAIK renameat2() are atomic, so it's can emulate transactions and allow get:
1. Work without use snapshot feature.
2. Don't use journal at all (in theory)

P.S. I'm not a dev, just want get a feedback about idea and get more
detail understanding of ceph osd backend.

Thanks.
-- 
Have a nice day,
Timofey.
