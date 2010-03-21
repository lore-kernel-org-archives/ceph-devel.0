From: Sage Weil <sage@newdream.net>
Subject: Re: [patch] ceph: cleanup: remove dead code
Date: Sat, 20 Mar 2010 20:59:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1003202059420.15445@cobra.newdream.net>
References: <20100320130127.GA32626@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20100320130127.GA32626@bicker>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <error27@gmail.com>
Cc: ceph-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sat, 20 Mar 2010, Dan Carpenter wrote:

> "xattr" is never NULL here.  We took care of that in the previous
> if statement block.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 37d6ce6..65b0e9b 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -185,12 +185,6 @@ static int __set_xattr(struct ceph_inode_info *ci,
>  		ci->i_xattrs.names_size -= xattr->name_len;
>  		ci->i_xattrs.vals_size -= xattr->val_len;
>  	}
> -	if (!xattr) {
> -		pr_err("__set_xattr ENOMEM on %p %llx.%llx xattr %s=%s\n",
> -		       &ci->vfs_inode, ceph_vinop(&ci->vfs_inode), name,
> -		       xattr->val);
> -		return -ENOMEM;
> -	}
>  	ci->i_xattrs.names_size += name_len;
>  	ci->i_xattrs.vals_size += val_len;
>  	if (val)

Applied, thanks!
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
