From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 00/33] OSDMAP_ENC, primary_temp, PRIMARY_AFFINITY
Date: Thu, 27 Mar 2014 20:17:46 +0200
Message-ID: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:37415 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0SSX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:23 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3188773eek.20
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:22 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id q49sm5944272eem.34.2014.03.27.11.18.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This is on top of wip-tunables3, which I posted a week ago and brings
the support for the new osdmap encoding (OSDMAP_ENC feature bit),
primary_temp and primary affinity (PRIMARY_AFFINITY feature bit) to the
kernel client, along with some cleanups.  PRIMARY_AFFINITY feature bit
is shared with CRUSH_TUNABLES3, so wip-primary branch contains both
this series and chooseleaf_vary_r stuff.

- 01-16/33, 24-25/33 common ground + misc fixes and cleanups
- 17-23/33 new osdmap encoding + infrastructure
- 26-28/33, 32/33 refactor pg -> (osd set, primary) code paths
- 29-31/33, 33/33 primary_temp and primary affinity logic

Thanks,

                Ilya



Ilya Dryomov (33):
  libceph: refer to osdmap directly in osdmap_show()
  libceph: do not prefix osd lines with \t in debugfs output
  libceph: dump pg_temp mappings to debugfs
  libceph: dump osdmap and enhance output on decode errors
  libceph: split osdmap allocation and decode steps
  libceph: fixup error handling in osdmap_decode()
  libceph: safely decode max_osd value in osdmap_decode()
  libceph: assert length of osdmap osd arrays
  libceph: fix crush_decode() call site in osdmap_decode()
  libceph: fixup error handling in osdmap_apply_incremental()
  libceph: nuke bogus encoding version check in
    osdmap_apply_incremental()
  libceph: fix and clarify ceph_decode_need() sizes
  libceph: rename __decode_pool{,_names}() to decode_pool{,_names}()
  libceph: introduce decode{,_new}_pools() and switch to them
  libceph: switch osdmap_set_max_osd() to krealloc()
  libceph: introduce decode{,_new}_pg_temp() and switch to them
  libceph: introduce get_osdmap_client_data_v()
  libceph: generalize ceph_pg_mapping
  libceph: primary_temp infrastructure
  libceph: primary_temp decode bits
  libceph: primary_affinity infrastructure
  libceph: primary_affinity decode bits
  libceph: enable OSDMAP_ENC feature bit
  libceph: ceph_osd_{exists,is_up,is_down}(osd) definitions
  libceph: ceph_can_shift_osds(pool) and pool type defines
  libceph: introduce pg_to_raw_osds() and raw_to_up_osds() helpers
  libceph: introduce apply_temps() helper
  libceph: switch ceph_calc_pg_acting() to new helpers
  libceph: return primary from ceph_calc_pg_acting()
  libceph: add support for primary_temp mappings
  libceph: add support for osd primary affinity
  libceph: redo ceph_calc_pg_primary() in terms of
    ceph_calc_pg_acting()
  libceph: enable PRIMARY_AFFINITY feature bit

 include/linux/ceph/ceph_features.h |    4 +-
 include/linux/ceph/osdmap.h        |   47 +-
 include/linux/ceph/rados.h         |    9 +-
 net/ceph/debugfs.c                 |   49 +-
 net/ceph/osd_client.c              |   12 +-
 net/ceph/osdmap.c                  |  963 ++++++++++++++++++++++++++----------
 6 files changed, 797 insertions(+), 287 deletions(-)

-- 
1.7.10.4

