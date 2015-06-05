From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ceph: use standard Opt_err
Date: Fri,  5 Jun 2015 21:12:46 +0200
Message-ID: <1433531567-3948-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

ceph used -1 for the last match_table_t option.
Use Opt_err enum like other FS

match_token() is based on the pattern (NULL)
so behavior should remain the same.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
This is untested. If this one is ok, I can send the same update
for rbd and net/ceph.

 fs/ceph/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 4e99053..35ef692 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -137,7 +137,8 @@ enum {
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 	Opt_acl,
 #endif
-	Opt_noacl
+	Opt_noacl,
+	Opt_err
 };
 
 static match_table_t fsopt_tokens = {
@@ -169,7 +170,7 @@ static match_table_t fsopt_tokens = {
 	{Opt_acl, "acl"},
 #endif
 	{Opt_noacl, "noacl"},
-	{-1, NULL}
+	{Opt_err, NULL}
 };
 
 static int parse_fsopt_token(char *c, void *private)
-- 
2.4.2
