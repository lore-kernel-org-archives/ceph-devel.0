From: Ding Dinghua <dingdinghua85@gmail.com>
Subject: More ondisk_finisher thread?
Date: Tue, 4 Aug 2015 17:59:31 +0800
Message-ID: <CANf+_kKpR6prfna20CtRfq=6QF+vpvCJu2NaO73RwuF=X+HMwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34428 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbbHDJ7c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 05:59:32 -0400
Received: by ykax123 with SMTP id x123so3439156yka.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 02:59:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi:
   Now we are doing some ceph performance tuning work, our setup has
ten ceph nodes, and SSD as journal, HDD for filestore, and ceph
version is 0.80.9.
   We run fio in virtual maching with random 4KB write workload, we
find that It took about 1ms in average for ondisk_finisher, while
journal write only took 0.4ms, so I think it's unreasonable.
    Since ondisk callback will be called with pg lock held, If pg lock
has been grabbed by another thread(for example, osd->op_wq), all
ondisk callback will be delayed, then all write op will be delayed.
     I found that op_commit must be called with pg lock, so what about
increase the ondisk_finisher thread number, so ondisk callback can be
less likely to be delayed.

-- 
Ding Dinghua
