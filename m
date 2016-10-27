From: John Spray <jspray@redhat.com>
Subject: rocksdb breakage on master?
Date: Thu, 27 Oct 2016 18:37:47 +0100
Message-ID: <CALe9h7e27rDp7V9CCWdyQrAvDZ67kJbQVS5fYV0zdt9B4Lj0MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34108 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935238AbcJ0RiJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 13:38:09 -0400
Received: by mail-lf0-f49.google.com with SMTP id b81so38016055lfe.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 10:38:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Bassam Tabbara <bassamtabbara@hotmail.com>, Kefu Chai <kchai@redhat.com>

I had a totally failing test branch based on recent master:
http://pulpito.ceph.com/jspray-2016-10-27_14:08:19-fs-wip-jcsp-testing-20161026-distro-basic-mira

With OSD coredumps and failures like this:
> Command failed on mira110 with status 132: 'sudo MALLOC_CHECK_=3 adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/coverage ceph-osd --cluster ceph --mkfs --mkkey -i 0 --monmap /home/ubuntu/cephtest/ceph.monmap'

So I tried reverting these two guys:
418bfd7bb5ec1dcec2b011e9df118c33ce38d398 cmake: use external project for rocksdb
5bbcf8547c45eb962507d26649cab2c1dec20dc6 pickup new rocksdb with
support for linux cmake
( from PR https://github.com/ceph/ceph/pull/11385)

...and my current run seems to be passing.

John
