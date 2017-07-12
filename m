From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: latency compare between 2t NVME SSD P3500 and bluestore
Date: Wed, 12 Jul 2017 17:15:29 +0800
Message-ID: <CAMwhyqVYiWuAVg_+HJ7xjsNs=BNkH-g5BtHGTDDP4j-5sSGXLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36421 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbdGLJPa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 05:15:30 -0400
Received: by mail-ua0-f175.google.com with SMTP id g40so10473056uaa.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 02:15:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Cephers,

I did some experiment today to compare the latency between one
P3500(2T nvme SSD) and bluestore(fio + libfio_objectstore.so):

For iodepth = 1, the random write latency of bluestore is 276.91us,
compare with 14.71 of SSD, big overhead.

I also test iodepth = 16, Still, there is a big overhead.(143 us -> 642 us)

What is your opinion?

Thanks
Pan
