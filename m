From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 05/15] f2fs: Use pagevec_lookup_range_tag()
Date: Fri, 15 Sep 2017 21:33:05 +0800
Message-ID: <e98f9561-8d71-6011-d686-d9173f55dc2c@kernel.org>
References: <20170914131819.26266-1-jack@suse.cz>
 <20170914131819.26266-6-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170914131819.26266-6-jack@suse.cz>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>, linux-mm@kvack.org
Cc: linux-f2fs-devel@lists.sourceforge.net, "Yan, Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On 2017/9/14 21:18, Jan Kara wrote:
> We want only pages from given range in f2fs_write_cache_pages(). Use
> pagevec_lookup_range_tag() instead of pagevec_lookup_tag() and remove
> unnecessary code.
> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
