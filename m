From: Brett Niver <bniver@redhat.com>
Subject: MDS balancer modes / docs
Date: Mon, 21 Nov 2016 09:47:41 -0500
Message-ID: <CAMdDSN2Ybqa3jLhW7j6fu7qt+35K7LoFuJsn=UNC=oZuyJgsbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34506 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753869AbcKUOrn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2016 09:47:43 -0500
Received: by mail-oi0-f50.google.com with SMTP id y198so23767544oia.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2016 06:47:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Jewel docs say:

mds bal mode

Description:

The method for calculating MDS load.

1 = Hybrid.
2 = Request rate and latency.
3 = CPU load.

Type:

32-bit Integer

Default: 0

-----------------------------
which is confusing in and of itself,but code seems to use :
0: hybrid
1: request rate and queue length (latency)
2: cpu load.

doc bug, or do we subtract one somewhere? :-).

Thanks,
Brett
