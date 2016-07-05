From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 3/4] ceph: allow dentry_lease_is_valid to work under RCU walk
Date: Tue,  5 Jul 2016 12:27:48 -0400
Message-ID: <1467736069-27140-4-git-send-email-jlayton@redhat.com>
References: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, zyan@redhat.com
Cc: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: ceph-devel.vger.kernel.org

Under rcuwalk, we need to take extra care when dereferencing d_parent.
We want to do that once and pass a pointer to dentry_lease_is_valid.

Also, we must ensure that that function can handle the case where we're
racing with d_release. Check whether "di" is NULL under the d_lock, and
just return 0 if so.

Finally, we still need to kick off a renewal job if the lease is getting
close to expiration. If that's the case, then just drop out of rcuwalk
mode since that could block.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 904dc671580f..60dcca163ba0 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1133,7 +1133,8 @@ void ceph_invalidate_dentry_lease(struct dentry *dentry)
  * Check if dentry lease is valid.  If not, delete the lease.  Try to
  * renew if the least is more than half up.
  */
-static int dentry_lease_is_valid(struct dentry *dentry)
+static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags,
+				 struct inode *dir)
 {
 	struct ceph_dentry_info *di;
 	struct ceph_mds_session *s;
@@ -1141,12 +1142,11 @@ static int dentry_lease_is_valid(struct dentry *dentry)
 	u32 gen;
 	unsigned long ttl;
 	struct ceph_mds_session *session = NULL;
-	struct inode *dir = NULL;
 	u32 seq = 0;
 
 	spin_lock(&dentry->d_lock);
 	di = ceph_dentry(dentry);
-	if (di->lease_session) {
+	if (di && di->lease_session) {
 		s = di->lease_session;
 		spin_lock(&s->s_gen_ttl_lock);
 		gen = s->s_cap_gen;
@@ -1159,12 +1159,19 @@ static int dentry_lease_is_valid(struct dentry *dentry)
 			valid = 1;
 			if (di->lease_renew_after &&
 			    time_after(jiffies, di->lease_renew_after)) {
-				/* we should renew */
-				dir = d_inode(dentry->d_parent);
-				session = ceph_get_mds_session(s);
-				seq = di->lease_seq;
-				di->lease_renew_after = 0;
-				di->lease_renew_from = jiffies;
+				/*
+				 * We should renew. If we're in RCU walk mode
+				 * though, we can't do that so just return
+				 * -ECHILD.
+				 */
+				if (flags & LOOKUP_RCU) {
+					valid = -ECHILD;
+				} else {
+					session = ceph_get_mds_session(s);
+					seq = di->lease_seq;
+					di->lease_renew_after = 0;
+					di->lease_renew_from = jiffies;
+				}
 			}
 		}
 	}
@@ -1224,12 +1231,16 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	} else if (d_really_is_positive(dentry) &&
 		   ceph_snap(d_inode(dentry)) == CEPH_SNAPDIR) {
 		valid = 1;
-	} else if (dentry_lease_is_valid(dentry) ||
-		   dir_lease_is_valid(dir, dentry)) {
-		if (d_really_is_positive(dentry))
-			valid = ceph_is_any_caps(d_inode(dentry));
-		else
-			valid = 1;
+	} else {
+		valid = dentry_lease_is_valid(dentry, flags, dir);
+		if (valid == -ECHILD)
+			return valid;
+		if (valid || dir_lease_is_valid(dir, dentry)) {
+			if (d_really_is_positive(dentry))
+				valid = ceph_is_any_caps(d_inode(dentry));
+			else
+				valid = 1;
+		}
 	}
 
 	if (!valid) {
-- 
2.5.5

