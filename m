From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ceph: fix symbol versioning for ceph_monc_do_statfs
Date: Mon, 13 Jun 2016 15:04:56 +0200
Message-ID: <1465823125-171114-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Beulich <jbeulich@suse.com>, Michal Marek <mmarek@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Alex Elder <elder@linaro.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The genksyms helper in the kernel cannot parse a type definition
like "typeof(((type *)0)->keyfld)" that is used in the DEFINE_RB_FUNCS
helper, causing the following EXPORT_SYMBOL() statement to be ignored
when computing the crcs, and triggering a warning about this:

WARNING: "ceph_monc_do_statfs" [fs/ceph/ceph.ko] has no CRC

To work around the problem, we can rewrite the type to reference
an undefined 'extern' symbol instead of a NULL pointer. This is
evidently ok for genksyms, and it no longer complains about the
line when calling it with 'genksyms -w'.

I've looked briefly into extending genksyms instead, but it seems
really hard to do. Jan Beulich introduced basic support for 'typeof'
a while ago in dc53324060f3 ("genksyms: fix typeof() handling"),
but that is not sufficient for the expression we have here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: fcd00b68bbe2 ("libceph: DEFINE_RB_FUNCS macro")
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Michal Marek <mmarek@suse.cz>
---
 include/linux/ceph/libceph.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 690985daad1c..6b79a6ba39ca 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -214,8 +214,9 @@ static void erase_##name(struct rb_root *root, type *t)			\
 }
 
 #define DEFINE_RB_LOOKUP_FUNC(name, type, keyfld, nodefld)		\
+extern type __lookup_##name##_key;					\
 static type *lookup_##name(struct rb_root *root,			\
-			   typeof(((type *)0)->keyfld) key)		\
+			   typeof(__lookup_##name##_key.keyfld) key)	\
 {									\
 	struct rb_node *n = root->rb_node;				\
 									\
-- 
2.7.0
