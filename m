From: Mike A <mike.almateia@gmail.com>
Subject: All Flash installation with BlueStore, RDMA, NVDIMM and SPDK
Date: Tue, 1 Aug 2017 22:32:45 +0300
Message-ID: <6ED16C68-6101-44B9-B0DE-CC6E06B6EF27@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33865 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdHATcv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Aug 2017 15:32:51 -0400
Received: by mail-lf0-f49.google.com with SMTP id g25so11234034lfh.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 Aug 2017 12:32:50 -0700 (PDT)
Received: from mbp-mihail.lan (broadband-178-140-226-63.moscow.rt.ru. [178.140.226.63])
        by smtp.gmail.com with ESMTPSA id q3sm3914667ljb.39.2017.08.01.12.32.48
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 12:32:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello

Our goal it is make fast storage as possible.=20
By now our configuration of 6 servers look like that:
* 2 x CPU Intel Gold 6150 20 core 2.4Ghz
* 2 x 16 Gb NVDIMM DDR4 DIMM
* 6 x 16 Gb RAM DDR4
* 6 x Intel DC P4500 4Tb NVMe 2.5"
* 2 x Mellanox ConnectX-4 EN Lx 25Gb dualport

What a support status in ceph of RDMA, NVDIMM access throughout libpmem =
and SPDK software?
Some issues or buggy support?

Thanks for answers.

=E2=80=94=20
Mike, runs!

