From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fs/ceph: don't return a value from void function
Date: Fri, 02 Aug 2019 12:32:37 -0400
Message-ID: <89f2fdcbd007dcf6bb2b01772a17eb63459cac9d.camel@kernel.org>
References: <20190802010658.18150-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802010658.18150-1-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john.hubbard@gmail.com
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, 2019-08-01 at 18:06 -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> This fixes a build warning to that effect.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> I ran into this while working on unrelated changes, to
> convert ceph over to put_user_page().
> 
> This patch is against the latest linux.git.
> 
> thanks,
> John Hubbard
> NVIDIA
> 
> 
>  fs/ceph/debugfs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 2eb88ed22993..facb387c2735 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -294,7 +294,6 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>  
>  void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>  {
> -	return 0;
>  }
>  
>  void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)

Thanks. Merged into ceph-client/testing branch, we'll see about getting
this to Linus before v5.3 ships.
-- 
Jeff Layton <jlayton@kernel.org>
