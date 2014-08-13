From: Viral Mehta <viral.vkm@gmail.com>
Subject: Fwd: crush_addition_is_unsafe
Date: Wed, 13 Aug 2014 19:08:13 +0530
Message-ID: <CANX6DanR++1xm9_kQ3dzz7eB0SdGdhCUfrddrm3OqEzG7=a87w@mail.gmail.com>
References: <CANX6Damfw3SQZmWhC+C0258utdJHRM2Qnx6pZXYHnGFdXtYu_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:55265 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaHMNiN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Aug 2014 09:38:13 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so14349410pdj.7
        for <ceph-devel@vger.kernel.org>; Wed, 13 Aug 2014 06:38:13 -0700 (PDT)
In-Reply-To: <CANX6Damfw3SQZmWhC+C0258utdJHRM2Qnx6pZXYHnGFdXtYu_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Does this make sense ? I can prepare a patch.


diff --git a/src/crush/builder.c b/src/crush/builder.c
index c319620..5700a88 100644
--- a/src/crush/builder.c
+++ b/src/crush/builder.c
@@ -651,7 +651,7 @@ int crush_add_tree_bucket_item(struct
crush_bucket_tree *bucket, int item, int w
        for (j=1; j<depth; j++) {
                node = parent(node);

-                if
(!crush_addition_is_unsafe(bucket->node_weights[node], weight))
+                if
(crush_addition_is_unsafe(bucket->node_weights[node], weight))
                         return -ERANGE;

                bucket->node_weights[node] += weight;


-- 
VKM
