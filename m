From: John Spray <john.spray@redhat.com>
Subject: [PATCH 0/7] ceph kernel client ENOSPC handling
Date: Tue,  4 Nov 2014 14:34:22 +0000
Message-ID: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f67.google.com ([74.125.82.67]:50421 "EHLO
	mail-wg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbaKDOe6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 09:34:58 -0500
Received: by mail-wg0-f67.google.com with SMTP id b13so3401262wgh.6
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 06:34:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

This series implements the kclient equivalents of recent
userspace changes for http://tracker.ceph.com/issues/7317

We modify the client's behaviour on the OSD map full flag
to cancel ops instead of blocking them, and we add a new
'osd epoch barrier' concept in the client-server protocol
to ensure that nobody else can touch a file who had
an operation cancelled until they have the subsequent
OSD map, to ensure ordering.  The epoch barrier will also
be important in the future for stricter client eviction.

John Spray (7):
  ceph: update ceph_msg_header structure
  ceph: remove unused `map_waiters` from osdc client
  ceph: add ceph_osdc_cancel_writes
  ceph: handle full condition by cancelling ops
  ceph: update CAPRELEASE message format
  ceph: handle new osdmap barrier field in CLIENTCAPS
  ceph: include osd epoch barrier in debugfs

 fs/ceph/caps.c                  | 110 +++++++++++++++++++++++++++++++++++--
 fs/ceph/debugfs.c               |   3 ++
 fs/ceph/mds_client.c            | 116 +++++++++++++++++++++++++++++++++++++++-
 fs/ceph/mds_client.h            |  18 ++++++-
 fs/ceph/super.h                 |   3 +-
 include/linux/ceph/msgr.h       |   3 +-
 include/linux/ceph/osd_client.h |   9 +++-
 net/ceph/osd_client.c           |  68 ++++++++++++++++++++++-
 8 files changed, 319 insertions(+), 11 deletions(-)

-- 
1.9.3

