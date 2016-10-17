From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/28] ceph: avoid false positive maybe-uninitialized warning
Date: Tue, 18 Oct 2016 00:08:54 +0200
Message-ID: <20161017220903.1746743-1-arnd@arndb.de>
References: <20161017220342.1627073-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017220342.1627073-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Nikolay Borisov <n.borisov.lkml@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

A recent rework removed the initialization of the local 'root'
variable that is returned from ceph_real_mount:

fs/ceph/super.c: In function 'ceph_mount':
fs/ceph/super.c:1016:38: error: 'root' may be used uninitialized in this function [-Werror=maybe-uninitialized]

It's not obvious to me what the correct fix is, so this just
returns the saved root as we did before.

Fixes: ce2728aaa82b ("ceph: avoid accessing / when mounting a subpath")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a29ffce..79a4be8 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -821,7 +821,8 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
 	dout("mount start %p\n", fsc);
 	mutex_lock(&fsc->client->mount_mutex);
 
-	if (!fsc->sb->s_root) {
+	root = dget(fsc->sb->s_root);
+	if (!root) {
 		const char *path;
 		err = __ceph_open_session(fsc->client, started);
 		if (err < 0)
-- 
2.9.0
