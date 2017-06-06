From: Oleg Kolosov <olekol@gmail.com>
Subject: Stopping clusters in developer mode
Date: Tue, 6 Jun 2017 23:43:17 +0300
Message-ID: <CAODUPsFSha2ER_EBgkguGnfaLLtJNf3ZU+Y2bYsNcZckPnZt6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:32981 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdFFUnT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 16:43:19 -0400
Received: by mail-oi0-f41.google.com with SMTP id s3so93158818oia.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 13:43:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
I'm writing an erasure code and would like to test it. I've built it
(make) and brought up a virtual cluster (with vstart.sh). However, I
can't stop an osd.
My problem is that init-ceph exits here:

test -f $LIBEXECDIR/ceph_common.sh || exit 0

ceph_common.sh doesn't exist and I wonder what might be the reason for this.
As I've mentioned, "make" is done successfully.

Thanks
