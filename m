From: Oleg Kolosov <olekol@gmail.com>
Subject: Write specific amount in RADOS bench
Date: Tue, 2 Jan 2018 23:55:33 +0200
Message-ID: <CAODUPsFDZ9-31S-2WkJGCGhFavZvNU1Zfz9Knur7cEhXfrLg=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35648 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeABVze (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jan 2018 16:55:34 -0500
Received: by mail-oi0-f46.google.com with SMTP id 184so34147618oii.2
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jan 2018 13:55:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
rados bench has the option of performing writes for a certain amount
of time. For example:
rados bench -p scbench 10 write --no-cleanup

This will write for 10 seconds.

I was wondering if there is an option to perform a specific number of
writes instead of writing for a certain duration?

Thanks,
Oleg
