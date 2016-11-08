From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: fix printing wrong return variable in
 ceph_direct_read_write()
Date: Tue, 8 Nov 2016 22:21:30 +0800
Message-ID: <80D4752E-4A7F-428F-9FDA-A4E6916FF717@redhat.com>
References: <CAGkCoNJ3ie=5artOKOnNdtpx=gj=jvA26SS2XVzLBg644Zui=A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGkCoNJ3ie=5artOKOnNdtpx=gj=jvA26SS2XVzLBg644Zui=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


> On 8 Nov 2016, at 17:16, Zhi Zhang <zhang.david2011@gmail.com> wrote:
> 
> Fix printing wrong return variable for invalidate_inode_pages2_range
> in ceph_direct_read_write().
> 
> Signed-off-by: Zhi Zhang <zhang.david2011@gmail.com>
> ---
> fs/ceph/file.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 18630e8..0136195 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -906,7 +906,7 @@ void ceph_sync_write_wait(struct inode *inode)
>                                       pos >> PAGE_SHIFT,
>                                       (pos + count) >> PAGE_SHIFT);
>               if (ret2 < 0)
> -                       dout("invalidate_inode_pages2_range returned
> %d\n", ret);
> +                       dout("invalidate_inode_pages2_range returned
> %d\n", ret2);
> 
>               flags = CEPH_OSD_FLAG_ORDERSNAP |
>                       CEPH_OSD_FLAG_ONDISK |
> 
> 

Applied, Thanks

Yan, Zheng

> Regards,
> Zhi Zhang (David)
> Contact: zhang.david2011@gmail.com
>             zhangz.david@outlook.com
