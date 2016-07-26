From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: Correctly return NXIO errors from ceph_llseek.
Date: Tue, 26 Jul 2016 14:47:41 +0800
Message-ID: <C53CE781-3B20-4151-B73E-4B1D5580A84A@redhat.com>
References: <20160721174310.21805-1-phil.turnbull@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160721174310.21805-1-phil.turnbull@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Turnbull <phil.turnbull@oracle.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, open list <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org


> On Jul 22, 2016, at 01:43, Phil Turnbull <phil.turnbull@oracle.com> wrote:
> 
> ceph_llseek does not correctly return NXIO errors because the 'out' path
> always returns 'offset'.
> 
> Fixes: 06222e491e66 ("fs: handle SEEK_HOLE/SEEK_DATA properly in all fs's that define their own llseek")
> Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
> ---
> fs/ceph/file.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index ce2f5795e44b..13adb5b2ef29 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1448,16 +1448,14 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
> {
> 	struct inode *inode = file->f_mapping->host;
> 	loff_t i_size;
> -	int ret;
> +	loff_t ret;
> 
> 	inode_lock(inode);
> 
> 	if (whence == SEEK_END || whence == SEEK_DATA || whence == SEEK_HOLE) {
> 		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
> -		if (ret < 0) {
> -			offset = ret;
> +		if (ret < 0)
> 			goto out;
> -		}
> 	}
> 
> 	i_size = i_size_read(inode);
> @@ -1473,7 +1471,7 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
> 		 * write() or lseek() might have altered it
> 		 */
> 		if (offset == 0) {
> -			offset = file->f_pos;
> +			ret = file->f_pos;
> 			goto out;
> 		}
> 		offset += file->f_pos;
> @@ -1493,11 +1491,11 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
> 		break;
> 	}
> 
> -	offset = vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
> +	ret = vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
> 
> out:
> 	inode_unlock(inode);
> -	return offset;
> +	return ret;
> }
> 
> static inline void ceph_zero_partial_page(

applied, thanks

Yan, Zheng

> -- 
> 2.9.0.rc2
> 
