From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: fix a comment typo
Date: Wed, 30 Sep 2015 11:44:58 +0800
Message-ID: <E1975EBF-13AA-4FE6-9A4D-82C2ED286CAC@redhat.com>
References: <4fb037c2ae2e494be58dc752483fb2f852a4cd70.1443612355.git.geliangtang@163.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4fb037c2ae2e494be58dc752483fb2f852a4cd70.1443612355.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


> On Sep 30, 2015, at 11:36, Geliang Tang <geliangtang@163.com> wrote:
> 
> Just fix a typo in the code comment.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
> fs/ceph/cache.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 834f9f3..a4766de 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -88,7 +88,7 @@ static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
> 	const struct ceph_inode_info* ci = cookie_netfs_data;
> 	uint16_t klen;
> 
> -	/* use ceph virtual inode (id + snaphot) */
> +	/* use ceph virtual inode (id + snapshot) */
> 	klen = sizeof(ci->i_vino);
> 	if (klen > maxbuf)
> 		return 0;

Applied, thank you.

Yan, Zheng


> -- 
> 1.9.1
> 
> 
