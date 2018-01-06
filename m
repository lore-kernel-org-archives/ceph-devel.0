From: Oleg Kolosov <olekol@gmail.com>
Subject: Read a single shard in EC
Date: Sat, 6 Jan 2018 21:03:25 +0200
Message-ID: <CAODUPsHZhyafs6E8n31nBcLVjLEjiMUTEju2XbCjdWLDwsOwog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:37111 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeAFTD0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jan 2018 14:03:26 -0500
Received: by mail-oi0-f54.google.com with SMTP id y184so1180739oie.4
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jan 2018 11:03:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I was wondering if it's possible to read a single shard in an erasure code?

I saw this was implemented in Luminous:

core: osd/ECTransaction: only read partial stripes when below
*original* object size (issue#19882, pr#15712, Sage Weil)

If yes, how can it be done?

Thanks,
Oleg
