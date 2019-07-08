From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ceph: fix uninitialized return code
Date: Mon,  8 Jul 2019 15:48:08 +0200
Message-ID: <20190708134821.587398-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Luis Henriques <lhenriques@suse.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: ceph-devel.vger.kernel.org

clang points out a -Wsometimed-uninitized bug in the modified
ceph_real_mount() function:

fs/ceph/super.c:850:6: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (!fsc->sb->s_root) {
            ^~~~~~~~~~~~~~~~
fs/ceph/super.c:885:9: note: uninitialized use occurs here
        return err;
               ^~~
fs/ceph/super.c:850:2: note: remove the 'if' if its condition is always true
        if (!fsc->sb->s_root) {
        ^~~~~~~~~~~~~~~~~~~~~~
fs/ceph/super.c:843:9: note: initialize the variable 'err' to silence this warning
        int err;
               ^
                = 0

Set it to zero if the condition is false.

Fixes: 108f95bfaa56 ("vfs: Convert ceph to use the new mount API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 0d23903ddfa5..d663aa1286f6 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -876,6 +876,8 @@ static int ceph_real_mount(struct fs_context *fc, struct ceph_fs_client *fsc)
 			goto out;
 		}
 		fsc->sb->s_root = root;
+	} else {
+		err = 0;
 	}
 
 	fc->root = dget(fsc->sb->s_root);
-- 
2.20.0
