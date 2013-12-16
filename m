From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 6/7] rbd: wire up is_visible() sysfs callback for rbd bus
Date: Mon, 16 Dec 2013 19:16:32 +0200
Message-ID: <1387214193-18489-7-git-send-email-ilya.dryomov@inktank.com>
References: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:58968 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab3LPRRb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:17:31 -0500
Received: by mail-ee0-f51.google.com with SMTP id b15so2380633eek.24
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:17:30 -0800 (PST)
In-Reply-To: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

In preparation for single-major device number allocation scheme, wire
up attribute_group::is_visible() callback for rbd bus.  This allows us
to make the new single-major attributes conditional.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 01ed7672a076..3fa18b0c5e4d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -408,7 +408,18 @@ static struct attribute *rbd_bus_attrs[] = {
 	&bus_attr_remove.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(rbd_bus);
+
+static umode_t rbd_bus_is_visible(struct kobject *kobj,
+				  struct attribute *attr, int index)
+{
+	return attr->mode;
+}
+
+static const struct attribute_group rbd_bus_group = {
+	.attrs = rbd_bus_attrs,
+	.is_visible = rbd_bus_is_visible,
+};
+__ATTRIBUTE_GROUPS(rbd_bus);
 
 static struct bus_type rbd_bus_type = {
 	.name		= "rbd",
-- 
1.7.10.4

