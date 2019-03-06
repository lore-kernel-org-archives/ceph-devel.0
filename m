From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 2/2] ceph: quota: fix quota subdir mounts
Date: Wed, 06 Mar 2019 18:21:35 +0000
Message-ID: <87va0vamog.fsf@suse.com>
References: <20190301175752.17808-1-lhenriques@suse.com>
        <20190301175752.17808-3-lhenriques@suse.com>
        <CAAM7YAmPSoEaJ6tXUtp+f56SV-Tqr6VKP4RquV0FA+LYkR8Rxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAmPSoEaJ6tXUtp+f56SV-Tqr6VKP4RquV0FA+LYkR8Rxg@mail.gmail.com>
        (Zheng Yan's message of "Mon, 4 Mar 2019 15:40:22 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

"Yan, Zheng" <ukernel@gmail.com> writes:

> On Sat, Mar 2, 2019 at 3:13 AM Luis Henriques <lhenriques@suse.com> wrote:
>>
>> The CephFS kernel client doesn't enforce quotas that are set in a
>> directory that isn't visible in the mount point.  For example, given the
>> path '/dir1/dir2', if quotas are set in 'dir1' and the mount is done in with
>>
>>   mount -t ceph <server>:<port>:/dir1/ /mnt
>>
>> then the client can't access the 'dir1' inode from the quota realm dir2
>> belongs to.
>>
>> This patch fixes this by simply doing an MDS LOOKUPINO Op and grabbing a
>> reference to it (so that it doesn't disappear again).  This also requires an
>> extra field in ceph_snap_realm so that we know we have to release that
>> reference when destroying the realm.
>>
>
> This may cause circle reference if somehow an inode owned by snaprealm
> get moved into mount subdir (other clients do rename).  how about
> holding these inodes in mds_client?

Ok, before proceeded any further I wanted to make sure that what you
were suggesting was something like the patch below.  It simply keeps a
list of inodes in ceph_mds_client until the filesystem is umounted,
iput()ing them at that point.

I'm sure I'm missing another place where the reference should be
dropped, but I couldn't figure it out yet.  It can't be
ceph_destroy_inode; drop_inode_snap_realm is a possibility, but what if
the inode becomes visible in the meantime?  Well, I'll continue thinking
about it.

Function get_quota_realm() should have a similar construct to lookup
inodes.  But it's a bit more tricky, because ceph_quota_is_same_realm()
requires snap_rwsem to be held for the 2 invocations of
get_quota_realm.

Cheers,
-- 
Luis

From a429a4c167186781bd235a25d72be893baf9e029 Mon Sep 17 00:00:00 2001
From: Luis Henriques <lhenriques@suse.com>
Date: Wed, 6 Mar 2019 17:58:04 +0000
Subject: [PATCH] ceph: quota: fix quota subdir mounts (II)

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/mds_client.c | 14 ++++++++++++++
 fs/ceph/mds_client.h |  2 ++
 fs/ceph/quota.c      | 34 ++++++++++++++++++++++++++++++----
 fs/ceph/super.h      |  2 ++
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 163fc74bf221..72c5ce5e4209 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3656,6 +3656,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->max_sessions = 0;
 	mdsc->stopping = 0;
 	atomic64_set(&mdsc->quotarealms_count, 0);
+	INIT_LIST_HEAD(&mdsc->quotarealms_inodes_list);
+	spin_lock_init(&mdsc->quotarealms_inodes_lock);
 	mdsc->last_snap_seq = 0;
 	init_rwsem(&mdsc->snap_rwsem);
 	mdsc->snap_realms = RB_ROOT;
@@ -3726,9 +3728,21 @@ static void wait_requests(struct ceph_mds_client *mdsc)
  */
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
+	struct ceph_inode_info *ci;
+
 	dout("pre_umount\n");
 	mdsc->stopping = 1;
 
+	spin_lock(&mdsc->quotarealms_inodes_lock);
+	while(!list_empty(&mdsc->quotarealms_inodes_list)) {
+		ci = list_first_entry(&mdsc->quotarealms_inodes_list,
+				      struct ceph_inode_info,
+				      i_quotarealms_inode_item);
+		list_del(&ci->i_quotarealms_inode_item);
+		iput(&ci->vfs_inode);
+	}
+	spin_unlock(&mdsc->quotarealms_inodes_lock);
+
 	lock_unlock_sessions(mdsc);
 	ceph_flush_dirty_caps(mdsc);
 	wait_requests(mdsc);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 729da155ebf0..58968fb338ec 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -329,6 +329,8 @@ struct ceph_mds_client {
 	int                     stopping;      /* true if shutting down */
 
 	atomic64_t		quotarealms_count; /* # realms with quota */
+	struct list_head	quotarealms_inodes_list;
+	spinlock_t		quotarealms_inodes_lock;
 
 	/*
 	 * snap_rwsem will cover cap linkage into snaprealms, and
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 9455d3aef0c3..7d4dec9eea47 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -22,7 +22,16 @@ void ceph_adjust_quota_realms_count(struct inode *inode, bool inc)
 static inline bool ceph_has_realms_with_quotas(struct inode *inode)
 {
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
-	return atomic64_read(&mdsc->quotarealms_count) > 0;
+	struct super_block *sb = mdsc->fsc->sb;
+
+	if (atomic64_read(&mdsc->quotarealms_count) > 0)
+		return true;
+	/* if root is the real CephFS root, we don't have quota realms */
+	if (sb->s_root->d_inode &&
+	    (sb->s_root->d_inode->i_ino == CEPH_INO_ROOT))
+		return false;
+	/* otherwise, we can't know for sure */
+	return true;
 }
 
 void ceph_handle_quota(struct ceph_mds_client *mdsc,
@@ -166,6 +175,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		return false;
 
 	down_read(&mdsc->snap_rwsem);
+restart:
 	realm = ceph_inode(inode)->i_snap_realm;
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
@@ -176,9 +186,25 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		spin_lock(&realm->inodes_with_caps_lock);
 		in = realm->inode ? igrab(realm->inode) : NULL;
 		spin_unlock(&realm->inodes_with_caps_lock);
-		if (!in)
-			break;
-
+		if (!in) {
+			up_read(&mdsc->snap_rwsem);
+			in = ceph_lookup_inode(inode->i_sb, realm->ino);
+			down_read(&mdsc->snap_rwsem);
+			if (IS_ERR(in)) {
+				pr_warn("Can't lookup inode %llx (err: %ld)\n",
+					realm->ino, PTR_ERR(in));
+				break;
+			}
+			spin_lock(&mdsc->quotarealms_inodes_lock);
+			list_add(&ceph_inode(in)->i_quotarealms_inode_item,
+				 &mdsc->quotarealms_inodes_list);
+			spin_unlock(&mdsc->quotarealms_inodes_lock);
+			spin_lock(&realm->inodes_with_caps_lock);
+			realm->inode = in;
+			spin_unlock(&realm->inodes_with_caps_lock);
+			ceph_put_snap_realm(mdsc, realm);
+			goto restart;
+		}
 		ci = ceph_inode(in);
 		spin_lock(&ci->i_ceph_lock);
 		if (op == QUOTA_CHECK_MAX_FILES_OP) {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index ce51e98b08ec..cc7766aeb73b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -375,6 +375,8 @@ struct ceph_inode_info {
 	struct list_head i_snap_realm_item;
 	struct list_head i_snap_flush_item;
 
+	struct list_head i_quotarealms_inode_item;
+
 	struct work_struct i_wb_work;  /* writeback work */
 	struct work_struct i_pg_inv_work;  /* page invalidation work */
 
