From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Bluestore aio_nr?
Date: Tue, 19 Sep 2017 00:44:44 +0800
Message-ID: <CAEYCsVJNnY7yV=VjfdP7B3jtVMz5v=8a9MmVPqS0kyhdKf0Tvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:44919 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932658AbdIRQop (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 12:44:45 -0400
Received: by mail-io0-f182.google.com with SMTP id v36so3641126ioi.1
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 09:44:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hi,
     I just hit an OSD cannot start due to insufficient aio_nr.  Each
OSD is with a separate SSD partition as db.block
     Further checking showing 6144 AIO contexts were required per OSD,
 could anyone explain a little bit on where the 6144 aio contexts goes
to?

     It looks to me like the bdev_aio_max_queue_depth is default to
1024, but  how can we have 6 bdev to get 6144?

Xiaoxi
