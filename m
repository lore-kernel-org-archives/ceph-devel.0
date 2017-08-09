From: Oleg Kolosov <olekol@gmail.com>
Subject: Rados bench decreasing performance for large data
Date: Wed, 9 Aug 2017 14:44:58 +0300
Message-ID: <CAODUPsE80Dan4YULo26OeEJtyghCUT9r-ux1qOOaT3A_w6gv0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35337 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbdHILpA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 07:45:00 -0400
Received: by mail-oi0-f45.google.com with SMTP id e124so58916251oig.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 04:44:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I've began experimenting with rados bench and I've noticed bizarre
behavior for jerasure and lrc plugins. I'm writing very large amounts
of data: ~2000 objects of size 64MB.
When reading the data with 9 parallel client, I'm noticing a linear
increase in latency around the middle of the read experiment (latency
was steady up to that point).
Is that an expected behavior?
How can it be explained?

Thanks,
Oleg
