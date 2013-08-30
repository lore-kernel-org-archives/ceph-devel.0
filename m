From: Wido den Hollander <wido@42on.com>
Subject: libvirt: Using rbd_create3 to create format 2 images
Date: Fri, 30 Aug 2013 11:42:50 +0200
Message-ID: <5220691A.1080604@42on.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080003090709070803000900"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:57818 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632Ab3H3Jmx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Aug 2013 05:42:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@inktank.com>

This is a multi-part message in MIME format.
--------------080003090709070803000900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I created the attached patch to have libvirt create images with format 2 
by default, this would simplify the CloudStack code and could also help 
other projects.

The problem with libvirt is that there is no mechanism to supply 
information like order, features, stripe unit and count to the 
rbd_create3 method, so it's now hardcoded in libvirt.

Any comments on this patch before I fire it of to the libvirt guys?

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on

--------------080003090709070803000900
Content-Type: text/x-patch;
 name="0001-rbd-Use-rbd_create3-to-create-RBD-format-2-images-by.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-rbd-Use-rbd_create3-to-create-RBD-format-2-images-by.pa";
 filename*1="tch"

From 2731f7c131d938ed5029bf8343877fcc4d950a0f Mon Sep 17 00:00:00 2001
From: Wido den Hollander <wido@widodh.nl>
Date: Fri, 30 Aug 2013 10:50:25 +0200
Subject: [PATCH] rbd: Use rbd_create3 to create RBD format 2 images by
 default

This new RBD format supports snapshotting and cloning. By having
libvirt create images in format 2 end-users of the created images
can benefit of the new RBD format.

Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/storage/storage_backend_rbd.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/storage/storage_backend_rbd.c b/src/storage/storage_backend_rbd.c
index d9e1789..e5d720e 100644
--- a/src/storage/storage_backend_rbd.c
+++ b/src/storage/storage_backend_rbd.c
@@ -443,6 +443,9 @@ static int virStorageBackendRBDCreateVol(virConnectPtr conn,
     ptr.cluster = NULL;
     ptr.ioctx = NULL;
     int order = 0;
+    uint64_t features = 3;
+    uint64_t stripe_count = 1;
+    uint64_t stripe_unit = 4194304;
     int ret = -1;
 
     VIR_DEBUG("Creating RBD image %s/%s with size %llu",
@@ -467,7 +470,8 @@ static int virStorageBackendRBDCreateVol(virConnectPtr conn,
         goto cleanup;
     }
 
-    if (rbd_create(ptr.ioctx, vol->name, vol->capacity, &order) < 0) {
+    if (rbd_create3(ptr.ioctx, vol->name, vol->capacity, features, &order,
+                    stripe_count, stripe_unit) < 0) {
         virReportError(VIR_ERR_INTERNAL_ERROR,
                        _("failed to create volume '%s/%s'"),
                        pool->def->source.name,
-- 
1.7.9.5


--------------080003090709070803000900--
