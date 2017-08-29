From: zengran zhang <z13121369189@gmail.com>
Subject: question about bluefs log sync
Date: Tue, 29 Aug 2017 20:52:46 +0800
Message-ID: <CALi+v18qS_hU0P9_iMxABwZFx5HcdeGbAo00yHBk42i_RJTWJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:38508 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdH2Mwr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 08:52:47 -0400
Received: by mail-io0-f193.google.com with SMTP id m40so3517573ioi.5
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 05:52:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

hi Sage,
    I want to ask when will the bluefs log be compacted? I only sure
it will be compacted when umount the bluefs...
I see the log be compact when rocksdb call Dir.Fsync(), but want to
know how to trigger this...

    thanks & regards
