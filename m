From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/6] crush: assume weight_set != null imples weight_set_size > 0
Date: Fri, 28 Jul 2017 14:41:28 +0200
Message-ID: <1501245690-2362-5-git-send-email-idryomov@gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33393 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbdG1Mln (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 08:41:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id q189so16146365wmd.0
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 05:41:42 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c13sm8263773wrc.7.2017.07.28.05.41.41
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 05:41:41 -0700 (PDT)
In-Reply-To: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Reflects ceph.git commit 5e8fa3e06b68fae1582c9230a3a8d1abc6146286.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/crush/mapper.c | 2 +-
 net/ceph/osdmap.c       | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 746b145bfd11..417df675c71b 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -306,7 +306,7 @@ static __u32 *get_choose_arg_weights(const struct crush_bucket_straw2 *bucket,
 				     const struct crush_choose_arg *arg,
 				     int position)
 {
-	if (!arg || !arg->weight_set || arg->weight_set_size == 0)
+	if (!arg || !arg->weight_set)
 		return bucket->item_weights;
 
 	if (position >= arg->weight_set_size)
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index eb57a06373ca..2586e5546143 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -295,6 +295,10 @@ static int decode_choose_args(void **p, void *end, struct crush_map *c)
 			ret = decode_choose_arg(p, end, arg);
 			if (ret)
 				goto fail;
+
+			if (arg->ids_size &&
+			    arg->ids_size != c->buckets[bucket_index]->size)
+				goto e_inval;
 		}
 
 		insert_choose_arg_map(&c->choose_args, arg_map);
-- 
2.4.3

