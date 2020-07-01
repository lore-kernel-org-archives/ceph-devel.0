From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] libceph/ceph: cleanups and move more into ceph.ko
Date: Wed,  1 Jul 2020 11:54:42 -0400
Message-ID: <20200701155446.41141-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732241AbgGAPys (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:54:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

This is just a small set of cleanups, with a final patch that moves a
chunk of cephfs-specific code out of libceph.ko and into ceph.ko. There
should be no functional changes here.

Jeff Layton (4):
  libceph: just have osd_req_op_init return a pointer
  libceph: refactor osdc request initialization
  libceph: rename __ceph_osdc_alloc_messages to ceph_osdc_alloc_num_messages
  libceph/ceph: move ceph_osdc_new_request into ceph.ko

 fs/ceph/Makefile                |   2 +-
 fs/ceph/addr.c                  |   1 +
 fs/ceph/file.c                  |   1 +
 fs/ceph/osdc.c                  | 113 +++++++++++++++++++
 fs/ceph/osdc.h                  |  16 +++
 include/linux/ceph/osd_client.h |  19 ++--
 net/ceph/osd_client.c           | 185 ++++++--------------------------
 7 files changed, 173 insertions(+), 164 deletions(-)
 create mode 100644 fs/ceph/osdc.c
 create mode 100644 fs/ceph/osdc.h

-- 
2.26.2
