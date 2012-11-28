From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 00/30] cleanup includes
Date: Wed, 28 Nov 2012 13:57:08 +0100
Message-ID: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34449 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754562Ab2K1M5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 07:57:41 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

This patch series removes several twice included header files
from the source files.

Danny Al-Gaaf (30):
  fusetrace_ll.cc: remove twice included sys/time.h
  ceph_fuse.cc: remove twice included sys/stat.h
  ceph_mds.cc: remove twice included sys/stat.h
  ceph_mon.cc: remove twice included sys/stat.h
  ceph_osd.cc: remove twice included sys/stat.h
  ceph_syn.cc: remove twice included sys/stat.h
  client/Client.cc: remove twice included headers
  client/MetaRequest.cc: remove twice included client/Dentry.h
  client/SyntheticClient.cc: remove twice included headers
  common/pipe.c: remove twice included unistd.h
  crushtool.cc: remove twice included sys/stat.h
  monmaptool.cc: remove twice included sys/stat.h
  include/buffer.h: remove twice included stdio.h
  librados/RadosClient.cc: remove twice included sys/stat.h
  mds/Dumper.h: remove twice included msg/Messenger.h
  mds/Migrator.cc: remove twice included Migrator.h
  mds/Resetter.h: remove twice included msg/Messenger.h
  mds/journal.cc: remove twice included common/config.h
  messages/MClientRequest.h: remove twice included sys/types.h
  mon/Monitor.cc: remove twice included osd/OSDMap.h
  mount/canonicalize.c: remove twice included string.h
  os/DBObjectMap.cc: remove twice included headers
  os/DBObjectMap.h: remove twice included <string>
  os/IndexManager.cc: remove twice included FlatIndex.h
  osd/OSD.h: remove twice included OpRequest.h
  osdmaptool.cc: remove twice included sys/stat.h
  rados.cc: remove twice included headers
  remove twice included linux/types.h
  rgw/rgw_rest.cc: remove twice included rgw_formats.h
  tools/common.cc: remove twice included headers

 fusetrace/fusetrace_ll.cc             | 1 -
 qa/workunits/direct_io/test_sync_io.c | 1 -
 src/ceph_fuse.cc                      | 1 -
 src/ceph_mds.cc                       | 1 -
 src/ceph_mon.cc                       | 1 -
 src/ceph_osd.cc                       | 1 -
 src/ceph_syn.cc                       | 1 -
 src/client/Client.cc                  | 6 ------
 src/client/MetaRequest.cc             | 1 -
 src/client/SyntheticClient.cc         | 2 --
 src/common/pipe.c                     | 1 -
 src/crushtool.cc                      | 2 --
 src/include/buffer.h                  | 1 -
 src/librados/RadosClient.cc           | 1 -
 src/mds/Dumper.h                      | 1 -
 src/mds/Migrator.cc                   | 1 -
 src/mds/Resetter.h                    | 1 -
 src/mds/journal.cc                    | 3 ---
 src/messages/MClientRequest.h         | 1 -
 src/mon/Monitor.cc                    | 2 --
 src/monmaptool.cc                     | 1 -
 src/mount/canonicalize.c              | 1 -
 src/os/DBObjectMap.cc                 | 2 --
 src/os/DBObjectMap.h                  | 1 -
 src/os/IndexManager.cc                | 1 -
 src/osd/OSD.h                         | 1 -
 src/osdmaptool.cc                     | 1 -
 src/rados.cc                          | 4 ----
 src/rgw/rgw_rest.cc                   | 2 --
 src/tools/common.cc                   | 2 --
 30 files changed, 46 deletions(-)

-- 
1.8.0

