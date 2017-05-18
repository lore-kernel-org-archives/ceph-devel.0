From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: check i_nlink while converting a file handle to
 dentry
Date: Thu, 18 May 2017 21:36:44 +0800
Message-ID: <DEB2EE75-52B1-4C4D-9F05-E0458CB10FB3@redhat.com>
References: <20170517112107.31025-1-lhenriques@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170517112107.31025-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org


> On 17 May 2017, at 19:21, Luis Henriques <lhenriques@suse.com> wrote:
> 
> Converting a file handle to a dentry can be done call after the inode
> unlink.  This means that __fh_to_dentry() requires an extra check to
> verify the number of links is not 0.
> 
> The issue can be easily reproduced using xfstest generic/426, which does
> something like:
> 
>  name_to_handle_at(&fh)
>  echo 3 > /proc/sys/vm/drop_caches
>  unlink()
>  open_by_handle_at(&fh)
> 
> The call to open_by_handle_at() should fail, as the file doesn't exist
> anymore.
> 
> Cc: stable@vger.kernel.org
> Link: http://tracker.ceph.com/issues/19958
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
> fs/ceph/export.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> index e8f11fa565c5..7df550c13d7f 100644
> --- a/fs/ceph/export.c
> +++ b/fs/ceph/export.c
> @@ -91,6 +91,10 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
> 		ceph_mdsc_put_request(req);
> 		if (!inode)
> 			return ERR_PTR(-ESTALE);
> +		if (inode->i_nlink == 0) {
> +			iput(inode);
> +			return ERR_PTR(-ESTALE);
> +		}
> 	}

maybe we should do this check in MDS

Regards
Yan, Zheng

> 
> 	return d_obtain_alias(inode);
