From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Transition vfs to 64-bit timestamps
Date: Wed, 30 May 2018 17:16:53 +0200
Message-ID: <CAK8P3a1_qJRALkxxb1uPnEaf8T5LsL0N1LbDUqxOr4SUDhPk1g@mail.gmail.com>
References: <20180525233528.GA371@deepa-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525233528.GA371@deepa-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, "Dilger, Andreas" <andreas.dilger@intel.com>, anton@tuxera.com, Felipe Balbi <balbi@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, ceph-devel <ceph-devel@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, David Sterba <dsterba@suse.com>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mike Marshall <hubcap@omnibond.com>, Jan Kara <jack@suse.com>
List-Id: ceph-devel.vger.kernel.org

On Sat, May 26, 2018 at 1:35 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:

> The flag patch applies cleanly. I've not seen the timestamps
> update logic change often. The series applies cleanly on 4.17-rc6
> and linux-next tip (top commit: next-20180517).

It just stopped applying cleanly against the latest linux-next tree, due to
a conflict against two patches from the overlayfs-next tree:

b2a285e1dc5d ("Revert "vfs: update ovl inode before relatime check"")
681b186a012d ("Revert "ovl: fix relatime for directories"")

After the conflict resolution below, it works fine again. Not sure what the
best merge strategy would be, at least the bit in ovl_file_accessed()
isn't obvious enough.

       Arnd

diff --cc fs/inode.c
index 6404639e2491,9fe1f941be02..195b974e7a77
--- a/fs/inode.c
+++ b/fs/inode.c
@@@ -1635,10 -1681,11 +1635,10 @@@ static int update_time(struct inode *in
   *    This function automatically handles read only file systems and media,
   *    as well as the "noatime" flag and inode specific "noatime" markers.
   */
 -bool __atime_needs_update(const struct path *path, struct inode *inode,
 -                        bool rcu)
 +bool atime_needs_update(const struct path *path, struct inode *inode)
  {
        struct vfsmount *mnt = path->mnt;
-       struct timespec now;
+       struct timespec64 now;

        if (inode->i_flags & S_NOATIME)
                return false;
@@@ -1661,10 -1708,10 +1661,14 @@@

        now = current_time(inode);

 -      if (!relatime_need_update(mnt, inode, now))
-       if (!relatime_need_update(path, inode,
timespec64_to_timespec(now), rcu))
++      if (!relatime_need_update(mnt, inode, timespec64_to_timespec(now)))
                return false;

-       if (timespec_equal(&inode->i_atime, &now))
+       if (timespec64_equal(&inode->i_atime, &now))
                return false;

        return true;
@@@ -1674,9 -1721,9 +1678,9 @@@ void touch_atime(const struct path *pat
  {
        struct vfsmount *mnt = path->mnt;
        struct inode *inode = d_inode(path->dentry);
-       struct timespec now;
+       struct timespec64 now;

 -      if (!__atime_needs_update(path, inode, false))
 +      if (!atime_needs_update(path, inode))
                return;

        if (!sb_start_write_trylock(inode->i_sb))
diff --cc fs/overlayfs/inode.c
index e31d64206a01,d7cca60f28e6..e0bb217c01e2
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -169,8 +169,8 @@ static void ovl_file_accessed(struct file *file)
        if (!upperinode)
                return;

 -       if ((!timespec_equal(&inode->i_mtime, &upperinode->i_mtime) ||
 -            !timespec_equal(&inode->i_ctime, &upperinode->i_ctime))) {
 +       if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
 +            !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
                inode->i_mtime = upperinode->i_mtime;
                inode->i_ctime = upperinode->i_ctime;
        }
@@@ -439,7 -384,39 +439,7 @@@ struct posix_acl *ovl_get_acl(struct in
        return acl;
  }

- int ovl_update_time(struct inode *inode, struct timespec *ts, int flags)
 -static bool ovl_open_need_copy_up(struct dentry *dentry, int flags)
 -{
 -      /* Copy up of disconnected dentry does not set upper alias */
 -      if (ovl_dentry_upper(dentry) &&
 -          (ovl_dentry_has_upper_alias(dentry) ||
 -           (dentry->d_flags & DCACHE_DISCONNECTED)))
 -              return false;
 -
 -      if (special_file(d_inode(dentry)->i_mode))
 -              return false;
 -
 -      if (!(OPEN_FMODE(flags) & FMODE_WRITE) && !(flags & O_TRUNC))
 -              return false;
 -
 -      return true;
 -}
 -
 -int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags)
 -{
 -      int err = 0;
 -
 -      if (ovl_open_need_copy_up(dentry, file_flags)) {
 -              err = ovl_want_write(dentry);
 -              if (!err) {
 -                      err = ovl_copy_up_flags(dentry, file_flags);
 -                      ovl_drop_write(dentry);
 -              }
 -      }
 -
 -      return err;
 -}
 -
+ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
  {
        if (flags & S_ATIME) {
                struct ovl_fs *ofs = inode->i_sb->s_fs_info;
diff --cc fs/overlayfs/overlayfs.h
index 93c84929d422,9fe10247f9d4..8477d9e4b4fe
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@@ -356,18 -330,10 +356,18 @@@ int ovl_xattr_get(struct dentry *dentry
                  void *value, size_t size);
  ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
  struct posix_acl *ovl_get_acl(struct inode *inode, int type);
- int ovl_update_time(struct inode *inode, struct timespec *ts, int flags);
 -int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags);
+ int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags);
  bool ovl_is_private_xattr(const char *name);
