From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: fix end offset in truncate_inode_pages_range call
Date: Tue, 02 Jul 2019 09:48:16 -0400
Message-ID: <85689b9674e96c15602f6a1829142273868250df.camel@kernel.org>
References: <20190701171634.20290-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190701171634.20290-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: zhengbin <zhengbin13@huawei.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 2019-07-01 at 18:16 +0100, Luis Henriques wrote:
> Commit e450f4d1a5d6 ("ceph: pass inclusive lend parameter to
> filemap_write_and_wait_range()") fixed the end offset parameter used to
> call filemap_write_and_wait_range and invalidate_inode_pages2_range.
> Unfortunately it missed truncate_inode_pages_range, introducing a
> regression that is easily detected by xfstest generic/130.
> 
> The problem is that when doing direct IO it is possible that an extra page
> is truncated from the page cache when the end offset is page aligned.
> This can cause data loss if that page hasn't been sync'ed to the OSDs.
> 
> While there, change code to use PAGE_ALIGN macro instead.
> 
> Fixes: e450f4d1a5d6 ("ceph: pass inclusive lend parameter to filemap_write_and_wait_range()")
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 183c37c0a8fc..7a57db8e2fa9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1007,7 +1007,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
>  			 * may block.
>  			 */
>  			truncate_inode_pages_range(inode->i_mapping, pos,
> -					(pos+len) | (PAGE_SIZE - 1));
> +						   PAGE_ALIGN(pos + len) - 1);
>  
>  			req->r_mtime = mtime;
>  		}

Luis, should this be sent to stable? It seems like a data corruption
problem...

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
