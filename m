From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/13] afs: Wait on PG_fscache before modifying/releasing a
 page
Date: Mon, 13 Jul 2020 17:38:44 +0100
Message-ID: <159465832417.1377938.3571599385208729791.stgit@warthog.procyon.org.uk>
References: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

PG_fscache is going to be used to indicate that a page is being written to
the cache, and that the page should not be modified or released until it's
finished.

Make afs_invalidatepage() and afs_releasepage() wait for it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c  |    7 +++++++
 fs/afs/write.c |    9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8baafe655433..2f9a7369b77b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -580,6 +580,13 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 
 	/* deny if page is being written to the cache and the caller hasn't
 	 * elected to wait */
+#ifdef CONFIG_AFS_FSCACHE
+	if (PageFsCache(page)) {
+		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
+			return false;
+	}
+#endif
+
 	if (PagePrivate(page)) {
 		priv = page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("rel"),
diff --git a/fs/afs/write.c b/fs/afs/write.c
index d9de0dc877ca..73e2f4c93512 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -125,6 +125,10 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 		SetPageUptodate(page);
 	}
 
+#ifdef CONFIG_AFS_FSCACHE
+	wait_on_page_fscache(page);
+#endif
+
 	/* page won't leak in error case: it eventually gets cleaned off LRU */
 	*pagep = page;
 
@@ -849,6 +853,11 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
+#ifdef CONFIG_AFS_FSCACHE
+	if (PageFsCache(vmf->page) &&
+	    wait_on_page_bit_killable(vmf->page, PG_fscache) < 0)
+		return VM_FAULT_RETRY;
+#endif
 
 	if (PageWriteback(vmf->page) &&
 	    wait_on_page_bit_killable(vmf->page, PG_writeback) < 0)
