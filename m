From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 01/61] afs: Make afs_zap_data() static
Date: Mon, 04 May 2020 18:07:26 +0100
Message-ID: <158861204690.340223.9682983562368438550.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Make afs_zap_data() static as it's only used in the file in which it is
defined.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c    |    2 +-
 fs/afs/internal.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 281470fe1183..67ccfbab683c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -568,7 +568,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
  * mark the data attached to an inode as obsolete due to a write on the server
  * - might also want to ditch all the outstanding writes and dirty pages
  */
-void afs_zap_data(struct afs_vnode *vnode)
+static void afs_zap_data(struct afs_vnode *vnode)
 {
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 80255513e230..03487f1bef07 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1017,7 +1017,6 @@ extern struct inode *afs_iget(struct super_block *, struct key *,
 			      struct afs_iget_data *, struct afs_status_cb *,
 			      struct afs_cb_interest *,
 			      struct afs_vnode *);
-extern void afs_zap_data(struct afs_vnode *);
 extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
 extern int afs_getattr(const struct path *, struct kstat *, u32, unsigned int);
