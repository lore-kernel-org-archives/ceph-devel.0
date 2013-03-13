From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 2/2] ceph: use i_release_count to indicate dir's completeness
Date: Wed, 13 Mar 2013 12:50:58 +0800
Message-ID: <514005B2.1050404@intel.com>
References: <1363005756-15270-1-git-send-email-zheng.z.yan@intel.com> <6BA8014BFDE2474F80D729BDF3C9D3E5@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64391 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935Ab3CMEvA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Mar 2013 00:51:00 -0400
In-Reply-To: <6BA8014BFDE2474F80D729BDF3C9D3E5@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On 03/13/2013 09:24 AM, Greg Farnum wrote:
> On Monday, March 11, 2013 at 5:42 AM, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> Current ceph code tracks directory's completeness in two places.
>> ceph_readdir() checks i_release_count to decide if it can set the
>> I_COMPLETE flag in i_ceph_flags. All other places check the I_COMPLETE
>> flag. This indirection introduces locking complexity.
>>
>> This patch adds a new variable i_complete_count to ceph_inode_info.
>> Set i_release_count's value to it when marking a directory complete.
>> By comparing the two variables, we know if a directory is complete
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
>> ---
>> fs/ceph/caps.c | 4 ++--
>> fs/ceph/dir.c | 25 +++++++++++++------------
>> fs/ceph/inode.c | 13 +++++++------
>> fs/ceph/mds_client.c | 10 +++-------
>> fs/ceph/super.h | 41 +++++++++++++++++++----------------------
>> 5 files changed, 44 insertions(+), 49 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 76634f4..124e8a1 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -490,7 +490,7 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
>> ci->i_rdcache_gen++;
>>
>> /*
>> - * if we are newly issued FILE_SHARED, clear I_COMPLETE; we
>> + * if we are newly issued FILE_SHARED, mark dir not complete; we
>> * don't know what happened to this directory while we didn't
>> * have the cap.
>> */
>> @@ -499,7 +499,7 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
>> ci->i_shared_gen++;
>> if (S_ISDIR(ci->vfs_inode.i_mode)) {
>> dout(" marking %p NOT complete\n", &ci->vfs_inode);
>> - ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
>> + __ceph_dir_clear_complete(ci);
>> }
>> }
>> }
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 76821be..11966c4 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -107,7 +107,7 @@ static unsigned fpos_off(loff_t p)
>> * falling back to a "normal" sync readdir if any dentries in the dir
>> * are dropped.
>> *
>> - * I_COMPLETE tells indicates we have all dentries in the dir. It is
>> + * Complete dir indicates that we have all dentries in the dir. It is
>> * defined IFF we hold CEPH_CAP_FILE_SHARED (which will be revoked by
>> * the MDS if/when the directory is modified).
>> */
>> @@ -198,8 +198,8 @@ more:
>> filp->f_pos++;
>>
>> /* make sure a dentry wasn't dropped while we didn't have parent lock */
>> - if (!ceph_i_test(dir, CEPH_I_COMPLETE)) {
>> - dout(" lost I_COMPLETE on %p; falling back to mds\n", dir);
>> + if (!ceph_dir_is_complete(dir)) {
>> + dout(" lost dir complete on %p; falling back to mds\n", dir);
>> err = -EAGAIN;
>> goto out;
>> }
>> @@ -258,7 +258,7 @@ static int ceph_readdir(struct file *filp, void *dirent, filldir_t filldir)
>> if (filp->f_pos == 0) {
>> /* note dir version at start of readdir so we can tell
>> * if any dentries get dropped */
>> - fi->dir_release_count = ci->i_release_count;
>> + fi->dir_release_count = atomic_read(&ci->i_release_count);
>>
>> dout("readdir off 0 -> '.'\n");
>> if (filldir(dirent, ".", 1, ceph_make_fpos(0, 0),
>> @@ -284,7 +284,7 @@ static int ceph_readdir(struct file *filp, void *dirent, filldir_t filldir)
>> if ((filp->f_pos == 2 || fi->dentry) &&
>> !ceph_test_mount_opt(fsc, NOASYNCREADDIR) &&
>> ceph_snap(inode) != CEPH_SNAPDIR &&
>> - (ci->i_ceph_flags & CEPH_I_COMPLETE) &&
>> + __ceph_dir_is_complete(ci) &&
>> __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1)) {
>> spin_unlock(&ci->i_ceph_lock);
>> err = __dcache_readdir(filp, dirent, filldir);
>> @@ -350,7 +350,8 @@ more:
>>
>> if (!req->r_did_prepopulate) {
>> dout("readdir !did_prepopulate");
>> - fi->dir_release_count--; /* preclude I_COMPLETE */
>> + /* preclude from marking dir complete */
>> + fi->dir_release_count--;
>> }
>>
>> /* note next offset and last dentry name */
>> @@ -428,9 +429,9 @@ more:
>> * the complete dir contents in our cache.
>> */
>> spin_lock(&ci->i_ceph_lock);
>> - if (ci->i_release_count == fi->dir_release_count) {
>> + if (atomic_read(&ci->i_release_count) == fi->dir_release_count) {
>> dout(" marking %p complete\n", inode);
>> - ci->i_ceph_flags |= CEPH_I_COMPLETE;
>> + __ceph_dir_set_complete(ci, fi->dir_release_count);
>> ci->i_max_offset = filp->f_pos;
>> }
>> spin_unlock(&ci->i_ceph_lock);
>> @@ -605,7 +606,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>> fsc->mount_options->snapdir_name,
>> dentry->d_name.len) &&
>> !is_root_ceph_dentry(dir, dentry) &&
>> - (ci->i_ceph_flags & CEPH_I_COMPLETE) &&
>> + __ceph_dir_is_complete(ci) &&
>> (__ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1))) {
>> spin_unlock(&ci->i_ceph_lock);
>> dout(" dir %p complete, -ENOENT\n", dir);
>> @@ -909,7 +910,7 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
>> */
>>
>> /* d_move screws up d_subdirs order */
>> - ceph_i_clear(new_dir, CEPH_I_COMPLETE);
>> + ceph_dir_clear_complete(new_dir);
>>
>> d_move(old_dentry, new_dentry);
>>
>> @@ -1079,7 +1080,7 @@ static void ceph_d_prune(struct dentry *dentry)
>> if (IS_ROOT(dentry))
>> return;
>>
>> - /* if we are not hashed, we don't affect I_COMPLETE */
>> + /* if we are not hashed, we don't affect dir's completeness */
>> if (d_unhashed(dentry))
>> return;
>>
>> @@ -1087,7 +1088,7 @@ static void ceph_d_prune(struct dentry *dentry)
>> * we hold d_lock, so d_parent is stable, and d_fsdata is never
>> * cleared until d_release
>> */
>> - ceph_i_clear(dentry->d_parent->d_inode, CEPH_I_COMPLETE);
>> + ceph_dir_clear_complete(dentry->d_parent->d_inode);
>> }
>>
>> /*
>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>> index 2b3fee7..d8db2df 100644
>> --- a/fs/ceph/inode.c
>> +++ b/fs/ceph/inode.c
>> @@ -302,7 +302,8 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>> ci->i_version = 0;
>> ci->i_time_warp_seq = 0;
>> ci->i_ceph_flags = 0;
>> - ci->i_release_count = 0;
>> + ci->i_complete_count = 0;
>> + atomic_set(&ci->i_release_count, 1);
>> ci->i_symlink = NULL;
>>
>> memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
>> @@ -720,9 +721,9 @@ static int fill_inode(struct inode *inode,
>> ceph_snap(inode) == CEPH_NOSNAP &&
>> (le32_to_cpu(info->cap.caps) & CEPH_CAP_FILE_SHARED) &&
>> (issued & CEPH_CAP_FILE_EXCL) == 0 &&
>> - (ci->i_ceph_flags & CEPH_I_COMPLETE) == 0) {
>> + !__ceph_dir_is_complete(ci)) {
>> dout(" marking %p complete (empty)\n", inode);
>> - ci->i_ceph_flags |= CEPH_I_COMPLETE;
>> + __ceph_dir_set_complete(ci, atomic_read(&ci->i_release_count));
>> ci->i_max_offset = 2;
>> }
>> no_change:
>> @@ -856,7 +857,7 @@ static void ceph_set_dentry_offset(struct dentry *dn)
>> di = ceph_dentry(dn);
>>
>> spin_lock(&ci->i_ceph_lock);
>> - if ((ceph_inode(inode)->i_ceph_flags & CEPH_I_COMPLETE) == 0) {
>> + if (!__ceph_dir_is_complete(ci)) {
>> spin_unlock(&ci->i_ceph_lock);
>> return;
>> }
>> @@ -1060,8 +1061,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
>> /*
>> * d_move() puts the renamed dentry at the end of
>> * d_subdirs. We need to assign it an appropriate
>> - * directory offset so we can behave when holding
>> - * I_COMPLETE.
>> + * directory offset so we can behave when dir is
>> + * complete.
>> */
>> ceph_set_dentry_offset(req->r_old_dentry);
>> dout("dn %p gets new offset %lld\n", req->r_old_dentry, 
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index ab899c8..edf90a5 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -2030,20 +2030,16 @@ out:
>> }
>>
>> /*
>> - * Invalidate dir I_COMPLETE, dentry lease state on an aborted MDS
>> + * Invalidate dir's completeness, dentry lease state on an aborted MDS
>> * namespace request.
>> */
>> void ceph_invalidate_dir_request(struct ceph_mds_request *req)
>> {
>> struct inode *inode = req->r_locked_dir;
>> - struct ceph_inode_info *ci = ceph_inode(inode);
>>
>> - dout("invalidate_dir_request %p (I_COMPLETE, lease(s))\n", inode);
>> - spin_lock(&ci->i_ceph_lock);
>> - ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
>> - ci->i_release_count++;
>> - spin_unlock(&ci->i_ceph_lock);
>> + dout("invalidate_dir_request %p (complete, lease(s))\n", inode);
>>
>> + ceph_dir_clear_complete(inode);
>> if (req->r_dentry)
>> ceph_invalidate_dentry_lease(req->r_dentry);
>> if (req->r_old_dentry)
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index e5f1875..dde77ac 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -244,7 +244,8 @@ struct ceph_inode_info {
>> u32 i_time_warp_seq;
>>
>> unsigned i_ceph_flags;
>> - unsigned long i_release_count;
>> + int i_complete_count;
>> + atomic_t i_release_count;
> 
> What makes it safe to treat i_complete_count as an int instead of an atomic? As far as I can tell it's not consistently used under any locks, but maybe I'm missing something that the VFS is giving me. :/
> -Greg

The code only assigns value to i_complete_count, the instruction is inherent atomic.

Regards
Yan, Zheng
