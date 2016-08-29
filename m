From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 1/1] ceph: do not modify fi->frag in need_reset_readdir()
Date: Mon, 29 Aug 2016 09:34:11 +0800
Message-ID: <D44BDF11-B00F-40F3-9446-7E5228C00A6B@redhat.com>
References: <20160828164712.24840-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160828164712.24840-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org


> On Aug 29, 2016, at 00:47, Nicolas Iooss <nicolas.iooss_linux@m4x.org> wrote:
> 
> Commit f3c4ebe65ea1 ("ceph: using hash value to compose dentry offset")
> modified "if (fpos_frag(new_pos) != fi->frag)" to "if (fi->frag |=
> fpos_frag(new_pos))" in need_reset_readdir(), thus replacing a
> comparison operator with an assignment one.
> 
> This looks like a typo which is reported by clang when building the
> kernel with some warning flags:
> 
>    fs/ceph/dir.c:600:22: error: using the result of an assignment as a
>    condition without parentheses [-Werror,-Wparentheses]
>            } else if (fi->frag |= fpos_frag(new_pos)) {
>                       ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
>    fs/ceph/dir.c:600:22: note: place parentheses around the assignment
>    to silence this warning
>            } else if (fi->frag |= fpos_frag(new_pos)) {
>                                ^
>                       (                             )
>    fs/ceph/dir.c:600:22: note: use '!=' to turn this compound
>    assignment into an inequality comparison
>            } else if (fi->frag |= fpos_frag(new_pos)) {
>                                ^~
>                                !=
> 
> Fixes: f3c4ebe65ea1 ("ceph: using hash value to compose dentry offset")
> Cc: stable@vger.kernel.org # 4.7.x
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> ---
> fs/ceph/dir.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index c64a0b794d49..df4b3e6fa563 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -597,7 +597,7 @@ static bool need_reset_readdir(struct ceph_file_info *fi, loff_t new_pos)
> 	if (is_hash_order(new_pos)) {
> 		/* no need to reset last_name for a forward seek when
> 		 * dentries are sotred in hash order */
> -	} else if (fi->frag |= fpos_frag(new_pos)) {
> +	} else if (fi->frag != fpos_frag(new_pos)) {
> 		return true;
> 	}
> 	rinfo = fi->last_readdir ? &fi->last_readdir->r_reply_info : NULL;


Applied, thanks

Yan, Zheng



> -- 
> 2.9.3
> 
