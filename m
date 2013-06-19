From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: avoid meaningless calling ceph_caps_revoking if
 sync_mode == WB_SYNC_ALL.
Date: Wed, 19 Jun 2013 08:57:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306190857320.27900@cobra.newdream.net>
References: <201306191512024406391@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201306191512024406391@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Applied, thanks!

sage

On Wed, 19 Jun 2013, majianpeng wrote:

> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  fs/ceph/addr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 3e68ac1..25fa8b8 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -677,8 +677,8 @@ static int ceph_writepages_start(struct address_space *mapping,
>  	 * integrity write (e.g., O_SYNC write or fsync()), or if our
>  	 * cap is being revoked.
>  	 */
> -	do_sync = wbc->sync_mode == WB_SYNC_ALL;
> -	if (ceph_caps_revoking(ci, CEPH_CAP_FILE_BUFFER))
> +	if ((wbc->sync_mode == WB_SYNC_ALL) ||
> +		ceph_caps_revoking(ci, CEPH_CAP_FILE_BUFFER))
>  		do_sync = 1;
>  	dout("writepages_start %p dosync=%d (mode=%s)\n",
>  	     inode, do_sync,
> -- 
> 1.8.3.rc1.44.gb387c77
> N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
