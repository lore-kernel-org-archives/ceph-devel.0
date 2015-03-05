From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 1/1 linux-next] ceph: remove redundant declaration
Date: Thu, 5 Mar 2015 13:44:52 +0800
Message-ID: <CAAM7YAmNGE5dDHUVVfmdcZ=yYMRgyYC4wD=oyQNXmHvYkFuRrA@mail.gmail.com>
References: <1425405470-9002-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425405470-9002-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Mar 4, 2015 at 1:57 AM, Fabian Frederick <fabf@skynet.be> wrote:
> ceph_aops was already defined extern in addr.c section
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  fs/ceph/super.h |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 04c8124..02ca99c 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -881,7 +881,6 @@ extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
>
>  /* file.c */
>  extern const struct file_operations ceph_file_fops;
> -extern const struct address_space_operations ceph_aops;
>
>  extern int ceph_open(struct inode *inode, struct file *file);
>  extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
> --
> 1.7.9.5
>

Added to our testing branch

Thanks
Yan, Zheng

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
