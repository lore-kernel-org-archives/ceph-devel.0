From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] rbd: Use min_t() to fix comparison of distinct pointer types warning
Date: Wed,  8 May 2013 22:02:33 +0200
Message-ID: <1368043353-21896-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: ceph-devel.vger.kernel.org

drivers/block/rbd.c: In function =E2=80=98zero_pages=E2=80=99:
drivers/block/rbd.c:1102: warning: comparison of distinct pointer types=
 lacks a cast

Remove the hackish casts and use min_t() to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/block/rbd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 22ffd5d..1318c6b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1098,8 +1098,8 @@ static void zero_pages(struct page **pages, u64 o=
ffset, u64 end)
 		unsigned long flags;
 		void *kaddr;
=20
-		page_offset =3D (size_t)(offset & ~PAGE_MASK);
-		length =3D min(PAGE_SIZE - page_offset, (size_t)(end - offset));
+		page_offset =3D offset & ~PAGE_MASK;
+		length =3D min_t(size_t, PAGE_SIZE - page_offset, end - offset);
 		local_irq_save(flags);
 		kaddr =3D kmap_atomic(*page);
 		memset(kaddr + page_offset, 0, length);
--=20
1.7.0.4
