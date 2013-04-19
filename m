From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH -next] ceph: fix printk format warnings in file.c
Date: Fri, 19 Apr 2013 15:01:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304191501160.13036@cobra.newdream.net>
References: <20130419181924.a035efe6d5e73fe0db9ddb84@canb.auug.org.au> <5171B507.4030808@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <5171B507.4030808@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Applied, thanks!

sage

On Fri, 19 Apr 2013, Randy Dunlap wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warnings by using %zd for 'ssize_t' variables:
> 
> fs/ceph/file.c:751:2: warning: format '%ld' expects argument of type 'long int', but argument 11 has type 'ssize_t' [-Wformat]
> fs/ceph/file.c:762:2: warning: format '%ld' expects argument of type 'long int', but argument 11 has type 'ssize_t' [-Wformat]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	Sage Weil <sage@inktank.com>
> Cc:	ceph-devel@vger.kernel.org
> ---
>  fs/ceph/file.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20130419.orig/fs/ceph/file.c
> +++ linux-next-20130419/fs/ceph/file.c
> @@ -748,7 +748,7 @@ retry_snap:
>  		goto out;
>  	}
>  
> -	dout("aio_write %p %llx.%llx %llu~%ld getting caps. i_size %llu\n",
> +	dout("aio_write %p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
>  	     inode, ceph_vinop(inode), pos, count, inode->i_size);
>  	if (fi->fmode & CEPH_FILE_MODE_LAZY)
>  		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> @@ -759,7 +759,7 @@ retry_snap:
>  	if (err < 0)
>  		goto out;
>  
> -	dout("aio_write %p %llx.%llx %llu~%ld got cap refs on %s\n",
> +	dout("aio_write %p %llx.%llx %llu~%zd got cap refs on %s\n",
>  	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
>  
>  	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
