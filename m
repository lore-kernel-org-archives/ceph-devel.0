From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: Avoid to propagate the invalid page point
Date: Mon, 21 Dec 2015 12:12:52 +0800
Message-ID: <801FE0B8-0193-429D-8BB0-E505DDF22E36@redhat.com>
References: <1450493699-20983-1-git-send-email-mnfhuang@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450493699-20983-1-git-send-email-mnfhuang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Minfei Huang <mnfhuang@gmail.com>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, mhuang@redhat.com
List-Id: ceph-devel.vger.kernel.org


> On Dec 19, 2015, at 10:54, Minfei Huang <mnfhuang@gmail.com> wrote:
> 
> The variant pagep will still get the invalid page point, although ceph
> fails in function ceph_update_writeable_page.
> 
> To fix this issue, Assigne the page to pagep until there is no failure
> in function ceph_update_writeable_page.
> 
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
> fs/ceph/addr.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b7d218a..6491079 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1149,7 +1149,6 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
> 		page = grab_cache_page_write_begin(mapping, index, 0);
> 		if (!page)
> 			return -ENOMEM;
> -		*pagep = page;
> 
> 		dout("write_begin file %p inode %p page %p %d~%d\n", file,
> 		     inode, page, (int)pos, (int)len);

applied, thanks

Yan, Zheng

> -- 
> 2.6.3
> 
