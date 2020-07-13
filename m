From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/32] mm: Provide lru_to_last_page() to get last of a page
 list
Date: Mon, 13 Jul 2020 17:31:33 +0100
Message-ID: <159465789337.1376674.4843292427395367970.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Provide a macro, lru_to_last_page(), to find the last page in a page list
(the opposite of lru_to_page()).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/mm.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..9692b9b58b06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -216,6 +216,7 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+#define lru_to_last_page(head) (list_entry((head)->next, struct page, lru))
 
 /*
  * Linux kernel virtual memory manager primitives.
