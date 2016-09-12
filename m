From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 04/47] block-rbd: Refactor two calls for memory allocations in
 rbd_dev_image_id()
Date: Mon, 12 Sep 2016 20:45:49 +0200
Message-ID: <dd52b320-58e3-48f7-f909-49bd3f388a5e@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Sep 2016 14:48:41 +0200

* Pass the sizes for memory allocations to the corresponding functions
  directly without storing the calculated values in an
  intermediate variable.

* Delete the local variable "size" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d61a066..c1da844 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5833,7 +5833,6 @@ again:
 static int rbd_dev_image_id(struct rbd_device *rbd_dev)
 {
 	int ret;
-	size_t size;
 	char *object_name;
 	void *response;
 	char *image_id;
@@ -5854,17 +5853,16 @@ static int rbd_dev_image_id(struct rbd_device *rbd_dev)
 	 * First, see if the format 2 image id file exists, and if
 	 * so, get the image's persistent id from it.
 	 */
-	size = sizeof (RBD_ID_PREFIX) + strlen(rbd_dev->spec->image_name);
-	object_name = kmalloc(size, GFP_NOIO);
+	object_name = kmalloc(sizeof(RBD_ID_PREFIX)
+			      + strlen(rbd_dev->spec->image_name),
+			      GFP_NOIO);
 	if (!object_name)
 		return -ENOMEM;
 	sprintf(object_name, "%s%s", RBD_ID_PREFIX, rbd_dev->spec->image_name);
 	dout("rbd id object name is %s\n", object_name);
 
 	/* Response will be an encoded string, which includes a length */
-
-	size = sizeof (__le32) + RBD_IMAGE_ID_LEN_MAX;
-	response = kzalloc(size, GFP_NOIO);
+	response = kzalloc(sizeof(__le32) + RBD_IMAGE_ID_LEN_MAX, GFP_NOIO);
 	if (!response) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.10.0
