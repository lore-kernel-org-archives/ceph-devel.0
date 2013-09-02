From: Wido den Hollander <wido@42on.com>
Subject: Re: libvirt: Using rbd_create3 to create format 2 images
Date: Mon, 02 Sep 2013 16:58:12 +0200
Message-ID: <5224A784.4030606@42on.com>
References: <5220691A.1080604@42on.com> <5220B988.9060906@inktank.com> <5220E6B6.7030008@42on.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020400020205060207090203"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:60785 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580Ab3IBO6P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Sep 2013 10:58:15 -0400
In-Reply-To: <5220E6B6.7030008@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020400020205060207090203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/30/2013 08:38 PM, Wido den Hollander wrote:
> On 08/30/2013 05:26 PM, Josh Durgin wrote:
>> On 08/30/2013 02:42 AM, Wido den Hollander wrote:
>>> Hi,
>>>
>>> I created the attached patch to have libvirt create images with format 2
>>> by default, this would simplify the CloudStack code and could also help
>>> other projects.
>>>
>>> The problem with libvirt is that there is no mechanism to supply
>>> information like order, features, stripe unit and count to the
>>> rbd_create3 method, so it's now hardcoded in libvirt.
>>>
>>> Any comments on this patch before I fire it of to the libvirt guys?
>>
>> Seems ok to me. They might want you to detect whether the function is
>> there and compile without it if librbd doesn't support it (rbd_create3
>> first appeared in bobtail).
>>
>
> Good one. Although I don't think anybody is still running Argonaut I'll
> do a version check of librbd and switch to rbd_create if needed.
>
>
What do you think of the attached patch Josh?

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on

--------------020400020205060207090203
Content-Type: text/x-patch;
 name="0001-rbd-Use-rbd_create3-to-create-RBD-format-2-images-by.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-rbd-Use-rbd_create3-to-create-RBD-format-2-images-by.pa";
 filename*1="tch"

From 68e212483a43196626413f2e487e2d6bb9c69726 Mon Sep 17 00:00:00 2001
From: Wido den Hollander <wido@widodh.nl>
Date: Fri, 30 Aug 2013 10:50:25 +0200
Subject: [PATCH] rbd: Use rbd_create3 to create RBD format 2 images by
 default

This new RBD format supports snapshotting and cloning. By having
libvirt create images in format 2 end-users of the created images
can benefit of the new RBD format.

Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/storage/storage_backend_rbd.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/storage/storage_backend_rbd.c b/src/storage/storage_backend_rbd.c
index d9e1789..2d4edc2 100644
--- a/src/storage/storage_backend_rbd.c
+++ b/src/storage/storage_backend_rbd.c
@@ -443,6 +443,11 @@ static int virStorageBackendRBDCreateVol(virConnectPtr conn,
     ptr.cluster = NULL;
     ptr.ioctx = NULL;
     int order = 0;
+    #if LIBRBD_VERSION_CODE > 259
+    uint64_t features = 3;
+    uint64_t stripe_count = 1;
+    uint64_t stripe_unit = 4194304;
+    #endif
     int ret = -1;
 
     VIR_DEBUG("Creating RBD image %s/%s with size %llu",
@@ -467,7 +472,12 @@ static int virStorageBackendRBDCreateVol(virConnectPtr conn,
         goto cleanup;
     }
 
+    #if LIBRBD_VERSION_CODE > 259
+    if (rbd_create3(ptr.ioctx, vol->name, vol->capacity, features, &order,
+                    stripe_count, stripe_unit) < 0) {
+    #else
     if (rbd_create(ptr.ioctx, vol->name, vol->capacity, &order) < 0) {
+    #endif
         virReportError(VIR_ERR_INTERNAL_ERROR,
                        _("failed to create volume '%s/%s'"),
                        pool->def->source.name,
-- 
1.7.9.5


--------------020400020205060207090203--
