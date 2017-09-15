From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 07/15] f2fs: Use find_get_pages_tag() for
 looking up single page
Date: Fri, 15 Sep 2017 21:43:03 +0800
Message-ID: <2cd84505-3d52-61dc-4a8d-099a58467cc1@kernel.org>
References: <20170914131819.26266-1-jack@suse.cz>
 <20170914131819.26266-8-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170914131819.26266-8-jack@suse.cz>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Jan Kara <jack@suse.cz>, linux-mm@kvack.org
Cc: linux-f2fs-devel@lists.sourceforge.net, "Yan, Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On 2017/9/14 21:18, Jan Kara wrote:
> __get_first_dirty_index() wants to lookup only the first dirty page
> after given index. There's no point in using pagevec_lookup_tag() for
> that. Just use find_get_pages_tag() directly.
> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
