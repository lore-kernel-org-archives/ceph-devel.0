From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] block: rbd: constify rbd_attr_group and rbd_opts_tokens
Date: Thu, 22 Jun 2017 17:34:14 +0530
Message-ID: <a70b3cd481092b32ea362a885c4a54c4f50118e2.1498132969.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@gmail.com, sage@redhat.com, elder@kernel.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
  43100	   2161	     64	  45325	   b10d	drivers/block/rbd.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  43292	   1969	     64	  45325	   b10d	drivers/block/rbd.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 454bf9c..2fb1912 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -802,7 +802,7 @@ enum {
 	Opt_err
 };
 
-static match_table_t rbd_opts_tokens = {
+static const match_table_t rbd_opts_tokens = {
 	{Opt_queue_depth, "queue_depth=%d"},
 	/* int args above */
 	/* string args above */
@@ -4670,7 +4670,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
 	NULL
 };
 
-static struct attribute_group rbd_attr_group = {
+static const struct attribute_group rbd_attr_group = {
 	.attrs = rbd_attrs,
 };
 
-- 
1.9.1
