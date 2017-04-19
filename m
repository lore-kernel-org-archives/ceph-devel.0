From: Greg Procunier <greg.procunier@gmail.com>
Subject: Ceph, RDMA and 40gbit Cisco CNA
Date: Wed, 19 Apr 2017 16:17:25 -0400
Message-ID: <CALd5Md0Q0b70q4n5s5uw+r-yy50cxU1P_EdCb8x9ZRZy4rGSEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33228 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765441AbdDSUR0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Apr 2017 16:17:26 -0400
Received: by mail-qk0-f176.google.com with SMTP id h67so30247775qke.0
        for <ceph-devel@vger.kernel.org>; Wed, 19 Apr 2017 13:17:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I was wondering if anyone could provide some guidance of if Ceph can
leverage the RDMA capabilities of the Cisco VIC 1340 / 1387 40gbit
converged network adapter.
From the product page
(http://www.cisco.com/c/en/us/products/interfaces-modules/ucs-virtual-interface-card-1387/index.html
) I see this card supports the following features:

Remote direct memory access (RDMA)
Data Plane Development Kit (DPDK)

So I am hopeful, but looking for a more definitive answer from folks
who are in the know.

Cheers
