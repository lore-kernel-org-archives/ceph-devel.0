From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 11/26] ceph: fix compat_ioctl for ceph_dir_operations
Date: Wed, 17 Apr 2019 22:23:12 +0100
Message-ID: <20190417212312.GY2217@ZenIV.linux.org.uk>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202013.4034148-12-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416202013.4034148-12-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, stable@vger.kernel.org, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, Apr 16, 2019 at 10:19:49PM +0200, Arnd Bergmann wrote:
> The ceph_ioctl function is used both for files and directories, but only
> the files support doing that in 32-bit compat mode.
> 
> For consistency, add the same compat handler to the dir operations
> as well.
> 
> Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ceph/dir.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index a8f429882249..7c060cb22aa3 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1785,6 +1785,7 @@ const struct file_operations ceph_dir_fops = {
>  	.open = ceph_open,
>  	.release = ceph_release,
>  	.unlocked_ioctl = ceph_ioctl,
> +	.compat_ioctl = ceph_ioctl,

Again, broken on s390 (and so's the ceph_file_ops, of course).
It wants compat_ptr() applied to argument...
