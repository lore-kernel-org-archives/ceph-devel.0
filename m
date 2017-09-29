From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 03/15] ceph: Use pagevec_lookup_range_tag()
Date: Fri, 29 Sep 2017 09:20:56 +0800
Message-ID: <BA15B4B8-3646-4382-8BA4-6D3B773FDDD5@redhat.com>
References: <20170927160334.29513-1-jack@suse.cz>
 <20170927160334.29513-4-jack@suse.cz>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170927160334.29513-4-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



> On 28 Sep 2017, at 00:03, Jan Kara <jack@suse.cz> wrote:
> 
> We want only pages from given range in ceph_writepages_start(). Use
> pagevec_lookup_range_tag() instead of pagevec_lookup_tag() and remove
> unnecessary code.
> 
> CC: Ilya Dryomov <idryomov@gmail.com>
> CC: "Yan, Zheng" <zyan@redhat.com>
> CC: ceph-devel@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> fs/ceph/addr.c | 19 +++----------------
> 1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b3e3edc09d80..e57e9d37bf2d 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -871,13 +871,10 @@ static int ceph_writepages_start(struct address_space *mapping,
> get_more_pages:
> 		pvec_pages = min_t(unsigned, PAGEVEC_SIZE,
> 				   max_pages - locked_pages);
> -		if (end - index < (u64)(pvec_pages - 1))
> -			pvec_pages = (unsigned)(end - index) + 1;
> -
> -		pvec_pages = pagevec_lookup_tag(&pvec, mapping, &index,
> -						PAGECACHE_TAG_DIRTY,
> +		pvec_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
> +						end, PAGECACHE_TAG_DIRTY,
> 						pvec_pages);
> -		dout("pagevec_lookup_tag got %d\n", pvec_pages);
> +		dout("pagevec_lookup_range_tag got %d\n", pvec_pages);
> 		if (!pvec_pages && !locked_pages)
> 			break;
> 		for (i = 0; i < pvec_pages && locked_pages < max_pages; i++) {
> @@ -895,16 +892,6 @@ static int ceph_writepages_start(struct address_space *mapping,
> 				unlock_page(page);
> 				continue;
> 			}
> -			if (page->index > end) {
> -				dout("end of range %p\n", page);
> -				/* can't be range_cyclic (1st pass) because
> -				 * end == -1 in that case. */
> -				stop = true;
> -				if (ceph_wbc.head_snapc)
> -					done = true;
> -				unlock_page(page);
> -				break;
> -			}
> 			if (strip_unit_end && (page->index > strip_unit_end)) {
> 				dout("end of strip unit %p\n", page);
> 				unlock_page(page);
> -- 
> 2.12.3
> 

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
