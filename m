From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 11/47] block-rbd: Delete three unnecessary initialisations in
 rbd_dev_image_name()
Date: Mon, 12 Sep 2016 20:54:06 +0200
Message-ID: <a509ccbf-7eba-2f21-0575-6051f2c28a96@users.sourceforge.net>
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
Date: Mon, 12 Sep 2016 18:02:16 +0200

Three local variables will be set to appropriate values a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 145bbcc..90797aa 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5256,9 +5256,9 @@ static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
 	void *p;
 	void *end;
 	size_t size;
-	void *reply_buf = NULL;
-	size_t len = 0;
-	char *image_name = NULL;
+	void *reply_buf;
+	size_t len;
+	char *image_name;
 	int ret;
 
 	rbd_assert(!rbd_dev->spec->image_name);
-- 
2.10.0
