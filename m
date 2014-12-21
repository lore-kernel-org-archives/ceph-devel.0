From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ceph: Use %zu to format size_t in ceph_fill_inline_data()
Date: Sun, 21 Dec 2014 11:56:19 +0100
Message-ID: <1419159379-11407-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: ceph-devel.vger.kernel.org

On 32-bit, where size_t is unsigned int:

fs/ceph/addr.c: In function =E2=80=98ceph_fill_inline_data=E2=80=99:
fs/ceph/addr.c:1419: warning: format =E2=80=98%lu=E2=80=99 expects type=
 =E2=80=98long unsigned int=E2=80=99, but argument 10 has type =E2=80=98=
size_t=E2=80=99

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f5013d92a7e6b73d..c81c0e004588b9e2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1416,7 +1416,7 @@ void ceph_fill_inline_data(struct inode *inode, s=
truct page *locked_page,
 		}
 	}
=20
-	dout("fill_inline_data %p %llx.%llx len %lu locked_page %p\n",
+	dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
 	     inode, ceph_vinop(inode), len, locked_page);
=20
 	if (len > 0) {
--=20
1.9.1
