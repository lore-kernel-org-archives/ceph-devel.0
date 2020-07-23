From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: super.h: delete a duplicated word
Date: Thu, 23 Jul 2020 13:22:56 -0400
Message-ID: <cba36614f44285feca178f1936fec8d1eef4b8ac.camel@kernel.org>
References: <20200720001259.21668-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720001259.21668-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sun, 2020-07-19 at 17:12 -0700, Randy Dunlap wrote:
> Drop the repeated word "the" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> ---
>  fs/ceph/super.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/fs/ceph/super.h
> +++ linux-next-20200717/fs/ceph/super.h
> @@ -353,7 +353,7 @@ struct ceph_inode_info {
>  	unsigned i_dirty_caps, i_flushing_caps;     /* mask of dirtied fields */
>  
>  	/*
> -	 * Link to the the auth cap's session's s_cap_dirty list. s_cap_dirty
> +	 * Link to the auth cap's session's s_cap_dirty list. s_cap_dirty
>  	 * is protected by the mdsc->cap_dirty_lock, but each individual item
>  	 * is also protected by the inode's i_ceph_lock. Walking s_cap_dirty
>  	 * requires the mdsc->cap_dirty_lock. List presence for an item can

Thanks, merged into testing branch. If you have more of these, then it
might be good to bundle them up into a fs/ceph-wide patch. There is no
shortage of grammatical errors in fs/ceph so there could be a lot of
these.
-- 
Jeff Layton <jlayton@kernel.org>
