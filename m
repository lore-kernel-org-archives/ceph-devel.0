From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v2 04/17] ceph: fix compat_ioctl for ceph_dir_operations
Date: Thu, 13 Sep 2018 08:48:33 +0800
Message-ID: <CAAM7YAnmTOMUdB4jVTzXv7C3dh58ekThm=U-GMJ9-_zzWti53w@mail.gmail.com>
References: <20180912150142.157913-1-arnd@arndb.de> <20180912150142.157913-4-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180912150142.157913-4-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, stable@vger.kernel.org, Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Chengguang Xu <cgxu519@gmx.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Sep 12, 2018 at 11:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The ceph_ioctl function is used both for files and directories, but only
> the files support doing that in 32-bit compat mode.
>
> For consistency, add the same compat handler to the dir operations
> as well.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ceph/dir.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 82928cea0209..da73f29d7faa 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1489,6 +1489,7 @@ const struct file_operations ceph_dir_fops = {
>         .open = ceph_open,
>         .release = ceph_release,
>         .unlocked_ioctl = ceph_ioctl,
> +       .compat_ioctl = ceph_ioctl,
>         .fsync = ceph_fsync,
>         .lock = ceph_lock,
>         .flock = ceph_flock,
> --
> 2.18.0
>

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
