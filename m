From: Ugis <ugis22@gmail.com>
Subject: rbd delete operation hangs, ops blocked
Date: Sat, 6 Jun 2015 08:53:03 +0300
Message-ID: <CAE63xUOybtrxaJCb0UyGfgcWnFfDUBjm=QrNPZ15rGGBb8-AYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37110 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbFFFxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Jun 2015 01:53:04 -0400
Received: by igbsb11 with SMTP id sb11so28611371igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jun 2015 22:53:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I had recent problem with flapping hdd and in result I need to delete
broken rbd.
Problem is all operations towards this rbd stuck. I even cannot delete
rbd - it sits on 6% done and I found this line in one of osds logs:
2015-06-06 08:03:31.770812 7fe5002c2700  0 log_channel(default) log
[WRN] : slow request 30720.717642 seconds old, received at 2015-06-05
23:31:31.032740: osd_op(client.2457394.0:8430
rbd_data.18b3c2ae8944a.00000000000020e5 [delete] 4.fac8e26
ack+ondisk+write+known_if_redirected e136905) currently reached_pg

How can I remove broken rbd? Fast way would be desirable, but any way
will do that eventually helps to delete that rbd.

Ugis
