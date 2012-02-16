From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 04/11] ceph: Push file_update_time() into
 ceph_page_mkwrite()
Date: Thu, 16 Feb 2012 13:04:37 -0600
Message-ID: <1329419077.3121.38.camel@doink>
References: <1329399979-3647-1-git-send-email-jack@suse.cz>
	 <1329399979-3647-5-git-send-email-jack@suse.cz>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1329399979-3647-5-git-send-email-jack@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Jan Kara <jack@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Eric Sandeen <sandeen@redhat.com>, Dave Chinner <david@fromorbit.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 2012-02-16 at 14:46 +0100, Jan Kara wrote:
> CC: Sage Weil <sage@newdream.net>
> CC: ceph-devel@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>


This will update the timestamp even if a write
fault fails, which is different from before.

Hard to avoid though.

Looks good to me.

Signed-off-by: Alex Elder <elder@dreamhost.com>

>  fs/ceph/addr.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 173b1d2..12b139f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1181,6 +1181,9 @@ static int ceph_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf)
>  	loff_t size, len;
>  	int ret;
>  
> +	/* Update time before taking page lock */
> +	file_update_time(vma->vm_file);
> +
>  	size = i_size_read(inode);
>  	if (off + PAGE_CACHE_SIZE <= size)
>  		len = PAGE_CACHE_SIZE;



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
