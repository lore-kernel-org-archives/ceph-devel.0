From: Jan Kara <jack@suse.cz>
Subject: Re: [f2fs-dev] [PATCH 07/15] f2fs: Use find_get_pages_tag() for
 looking up single page
Date: Mon, 18 Sep 2017 09:52:07 +0200
Message-ID: <20170918075207.GA32516@quack2.suse.cz>
References: <20170914131819.26266-1-jack@suse.cz>
 <20170914131819.26266-8-jack@suse.cz>
 <2cd84505-3d52-61dc-4a8d-099a58467cc1@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <2cd84505-3d52-61dc-4a8d-099a58467cc1@kernel.org>
Sender: owner-linux-mm@kvack.org
To: Chao Yu <chao@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-f2fs-devel@lists.sourceforge.net, "Yan, Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On Fri 15-09-17 21:43:03, Chao Yu wrote:
> On 2017/9/14 21:18, Jan Kara wrote:
> > __get_first_dirty_index() wants to lookup only the first dirty page
> > after given index. There's no point in using pagevec_lookup_tag() for
> > that. Just use find_get_pages_tag() directly.
> > 
> > CC: Jaegeuk Kim <jaegeuk@kernel.org>
> > CC: linux-f2fs-devel@lists.sourceforge.net
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for the review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
