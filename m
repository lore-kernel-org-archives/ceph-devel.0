From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: cache: Replace zero-length array with
 flexible-array member
Date: Thu, 13 Feb 2020 11:24:23 -0500
Message-ID: <85db1f27d661fb24bd825b241f9d5ca3a94a1efa.camel@kernel.org>
References: <20200213160004.GA4334@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200213160004.GA4334@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2020-02-13 at 10:00 -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/ceph/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 270b769607a2..2f5cb6bc78e1 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -32,7 +32,7 @@ struct ceph_fscache_entry {
>  	size_t uniq_len;
>  	/* The following members must be last */
>  	struct ceph_fsid fsid;
> -	char uniquifier[0];
> +	char uniquifier[];
>  };
>  
>  static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {

Meh, ok. Merged into the ceph-client/testing branch. Should make v5.7
barring unforseen issues.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
