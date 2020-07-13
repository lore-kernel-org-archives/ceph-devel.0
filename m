From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/13] afs: Fix interruption of operations
Date: Mon, 13 Jul 2020 17:37:07 +0100
Message-ID: <159465822787.1377938.10874079234418111929.stgit@warthog.procyon.org.uk>
References: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The afs filesystem driver allows unstarted operations to be cancelled by
signal, but most of these can easily be restarted (mkdir for example).  The
primary culprits for reproducing this are those applications that use
SIGALRM to display a progress counter.

File lock-extension operation is marked uninterruptible as we have a
limited time in which to do it, and the release op is marked
uninterruptible also as if we fail to unlock a file, we'll have to wait 20
mins before anyone can lock it again.

The store operation logs a warning if it gets interruption, e.g.:

	kAFS: Unexpected error from FS.StoreData -4

because it's run from the background - but it can also be run from
fdatasync()-type things.  However, store options aren't marked
interruptible at the moment.

Fix this in the following ways:

 (1) Mark store operations as uninterruptible.  It might make sense to
     relax this for certain situations, but I'm not sure how to make sure
     that background store ops aren't affected by signals to foreground
     processes that happen to trigger them.

 (2) In afs_get_io_locks(), where we're getting the serialisation lock for
     talking to the fileserver, return ERESTARTSYS rather than EINTR
     because a lot of the operations (e.g. mkdir) are restartable if we
     haven't yet started sending the op to the server.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_operation.c |    4 ++--
 fs/afs/write.c        |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index c264839b2fd0..24fd163c6323 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -71,7 +71,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 		swap(vnode, vnode2);
 
 	if (mutex_lock_interruptible(&vnode->io_lock) < 0) {
-		op->error = -EINTR;
+		op->error = -ERESTARTSYS;
 		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [I 0]");
 		return false;
@@ -80,7 +80,7 @@ static bool afs_get_io_locks(struct afs_operation *op)
 
 	if (vnode2) {
 		if (mutex_lock_interruptible_nested(&vnode2->io_lock, 1) < 0) {
-			op->error = -EINTR;
+			op->error = -ERESTARTSYS;
 			op->flags |= AFS_OPERATION_STOP;
 			mutex_unlock(&vnode->io_lock);
 			op->flags &= ~AFS_OPERATION_LOCK_0;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index abfc8d3dc20c..60918b80b729 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -449,6 +449,7 @@ static int afs_store_data(struct address_space *mapping,
 	op->store.first_offset = offset;
 	op->store.last_to = to;
 	op->mtime = vnode->vfs_inode.i_mtime;
+	op->flags |= AFS_OPERATION_UNINTR;
 	op->ops = &afs_store_data_operation;
 
 try_next_key:
