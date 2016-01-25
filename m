From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/9] libceph: mon_client update
Date: Mon, 25 Jan 2016 12:29:32 +0100
Message-ID: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33992 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbcAYLaJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:09 -0500
Received: by mail-wm0-f67.google.com with SMTP id b14so10684166wmb.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:08 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.06
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

The original motivation for this series was adding support for
subscribing to osdmap updates with onetime=false (i.e. continuously),
needed for better full handling in osd_client (patches 1-3).

Patches 4-9 are misc fixes in session management area, added in the
process of untying session management from subs management.

Thanks,

                Ilya


Ilya Dryomov (9):
  libceph: move debugfs initialization into __ceph_open_session()
  libceph: decouple hunting and subs management
  libceph: revamp subs code, switch to SUBSCRIBE2 protocol
  libceph: pick a different monitor when reconnecting
  libceph: monc ping rate is 10s
  libceph: monc hunt rate is 3s with backoff up to 30s
  libceph: introduce and switch to reopen_session()
  libceph: reschedule tick in mon_fault()
  libceph: behave in mon_fault() if cur_mon < 0

 fs/ceph/mds_client.c               |   3 +-
 fs/ceph/super.c                    |   2 +-
 include/linux/ceph/ceph_features.h |   2 +
 include/linux/ceph/ceph_fs.h       |   4 +-
 include/linux/ceph/libceph.h       |   8 +-
 include/linux/ceph/mon_client.h    |  31 ++-
 net/ceph/ceph_common.c             |   4 +-
 net/ceph/debugfs.c                 |  17 +-
 net/ceph/mon_client.c              | 457 ++++++++++++++++++++-----------------
 net/ceph/osd_client.c              |   3 +-
 10 files changed, 304 insertions(+), 227 deletions(-)

-- 
2.4.3

