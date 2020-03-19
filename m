From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: fix memory leak in ceph_cleanup_snapid_map
Date: Thu, 19 Mar 2020 10:41:13 -0400
Message-ID: <e00d01582d39f1036bd73fb66e45e56c8c07016d.camel@kernel.org>
References: <20200319114348.GA72449@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319114348.GA72449@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2020-03-19 at 11:43 +0000, Luis Henriques wrote:
> kmemleak reports the following memory leak:
> 
> unreferenced object 0xffff88821feac8a0 (size 96):
>   comm "kworker/1:0", pid 17, jiffies 4294896362 (age 20.512s)
>   hex dump (first 32 bytes):
>     a0 c8 ea 1f 82 88 ff ff 00 c9 ea 1f 82 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 01 00 00 00 00 ad de  ................
>   backtrace:
>     [<00000000b3ea77fb>] ceph_get_snapid_map+0x75/0x2a0
>     [<00000000d4060942>] fill_inode+0xb26/0x1010
>     [<0000000049da6206>] ceph_readdir_prepopulate+0x389/0xc40
>     [<00000000e2fe2549>] dispatch+0x11ab/0x1521
>     [<000000007700b894>] ceph_con_workfn+0xf3d/0x3240
>     [<0000000039138a41>] process_one_work+0x24d/0x590
>     [<00000000eb751f34>] worker_thread+0x4a/0x3d0
>     [<000000007e8f0d42>] kthread+0xfb/0x130
>     [<00000000d49bd1fa>] ret_from_fork+0x3a/0x50
> 
> A kfree was missing in commit 75c9627efb72 ("ceph: map snapid to anonymous
> bdev ID"), while looping the 'to_free' list of ceph_snapid_map objects.
> 
> Fixes: 75c9627efb72 ("ceph: map snapid to anonymous bdev ID")
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> Hi!
> 
> A bit of mailing-list archaeology shows that v1 of this patch actually
> included this kfree [1], and was lost on v2 [2].
> 
> [1] https://patchwork.kernel.org/patch/10114319/
> [2] https://patchwork.kernel.org/patch/10749907/
> 
> Cheers,
> --
> Luis
> 
> fs/ceph/snap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index ccfcc66aaf44..923be9399b21 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -1155,5 +1155,6 @@ void ceph_cleanup_snapid_map(struct ceph_mds_client *mdsc)
>  			pr_err("snapid map %llx -> %x still in use\n",
>  			       sm->snap, sm->dev);
>  		}
> +		kfree(sm);
>  	}
>  }

Good catch. This looks correct to me.

Hmmm...we'll leak one of these for every snapid we encounter. Any
objection to marking this for stable?
-- 
Jeff Layton <jlayton@kernel.org>
