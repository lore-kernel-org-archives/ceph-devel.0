From: Max Yehorov <myehorov@skytap.com>
Subject: rbd-nbd 2T limit
Date: Wed, 8 Mar 2017 19:38:07 -0800
Message-ID: <CAJDfisnEsBkYUXkVMnGPy9vu6DWYC3PZHFW7jOYm5bc_Dv-56w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34986 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdCIDkN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 22:40:13 -0500
Received: by mail-wr0-f180.google.com with SMTP id g10so36289597wrg.2
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 19:38:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I was reading through release notes for 10.2.6 and there was a ticket

rbd: rbd-nbd: disallow mapping images >2TB in size (issue#17219,
pr#11870, Mykola Golub)

default nbd block size is 1k, valid values are from 512 to PAGE_SIZE

rbd_nbd.cc sets blocksize to 512 here:
https://github.com/ceph/ceph/blob/master/src/tools/rbd_nbd/rbd-nbd.cc#L635

Why 512 was chosen for rbd_nbd?
krbd also uses 512 sector size. Is there a reason to use 512 block
size vs 4k AF?
