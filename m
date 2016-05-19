From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/6] libceph: get rid of CEPH_MAX_OID_NAME_LEN limit
Date: Thu, 19 May 2016 16:06:36 +0200
Message-ID: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33571 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbcESOHM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 10:07:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so21356592wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 07:07:12 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-165-81.net.upcbroadband.cz. [94.112.165.81])
        by smtp.gmail.com with ESMTPSA id b124sm3586833wmb.1.2016.05.19.07.07.05
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 07:07:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I pushed wip-oid, to get rid of the annoying CEPH_MAX_OID_NAME_LEN
limit on the length of an object name that libceph can work with, which
translated into the limit of ~100 chars on the length of an rbd image
name.  The new image name limit is ~4000 chars.  (The exact number
depends on how many mon IPs and map options were specified - mons
+ options + image name string must fit into a single page.)

We should define a sensible limit and start enforcing it on rbd
create/clone/etc and on open/rbd map.  Limits from the lower layers

   4096 - strlen(".rbd") on create for format 1
   4096 - strlen("rbd_id.") on create for format 2
   ~4000 on map

aren't something we want to rely on or support.

Thanks,

                Ilya


Ilya Dryomov (6):
  libceph: make ceph_osdc_put_request() accept NULL
  libceph: grab snapc in ceph_osdc_alloc_request()
  libceph: move message allocation out of ceph_osdc_alloc_request()
  libceph: change how osd_op_reply message size is calculated
  libceph: variable-sized ceph_object_id
  rbd: use header_oid instead of header_name

 drivers/block/rbd.c             |  83 ++++++++++++++-------------
 fs/ceph/addr.c                  |  23 ++++----
 fs/ceph/file.c                  |   9 ++-
 fs/ceph/ioctl.c                 |   2 +-
 include/linux/ceph/osd_client.h |   1 +
 include/linux/ceph/osdmap.h     |  62 ++++++++++++---------
 net/ceph/debugfs.c              |   2 +-
 net/ceph/osd_client.c           | 120 ++++++++++++++++++++++------------------
 net/ceph/osdmap.c               |  93 ++++++++++++++++++++++++++++++-
 9 files changed, 266 insertions(+), 129 deletions(-)

-- 
2.4.3

