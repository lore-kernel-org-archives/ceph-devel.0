From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH RESEND] devices: recognise rbd devices
Date: Wed, 13 Sep 2017 12:02:35 +0200
Message-ID: <1505296955-32764-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36605 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdIMKDH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 06:03:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id g50so7483521wra.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 03:03:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lvm-devel@redhat.com
Cc: Alasdair Kergon <agk@redhat.com>, ceph-devel@vger.kernel.org

Under single_major scheme introduced in kernel 3.14, rbd devices
support up to 16 partitions.  In pre-single_major mode, rbd driver
takes up the whole major.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 WHATS_NEW                 | 1 +
 lib/device/device-types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/WHATS_NEW b/WHATS_NEW
index e6cc18db009b..f5f22eaa7b4a 100644
--- a/WHATS_NEW
+++ b/WHATS_NEW
@@ -1,5 +1,6 @@
 Version 2.02.174 - 
 =================================
+  Recognise RADOS block devices (RBD) in filter.
   Prevent raid1 split with trackchanges in a shared VG.
   Avoid double unlocking of client & lockspace mutexes in lvmlockd.
   Fix leaking of file descriptor for non-blocking filebased locking.
diff --git a/lib/device/device-types.h b/lib/device/device-types.h
index 2834cd11fd3a..57b430173e56 100644
--- a/lib/device/device-types.h
+++ b/lib/device/device-types.h
@@ -64,5 +64,6 @@ static const dev_known_type_t _dev_known_types[] = {
 	{"nvme", 64, "NVM Express"},
 	{"zvol", 16, "ZFS Zvols"},
 	{"VxDMP", 16, "Veritas Dynamic Multipathing"},
+	{"rbd", 16, "RADOS block device (RBD)"},
 	{"", 0, ""}
 };
-- 
2.4.3

