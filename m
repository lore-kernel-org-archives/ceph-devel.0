From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 06/15] f2fs: Simplify page iteration loops
Date: Fri, 15 Sep 2017 21:37:59 +0800
Message-ID: <3c0acdd7-c8ae-9548-c354-0275fa3f8176@kernel.org>
References: <20170914131819.26266-1-jack@suse.cz>
 <20170914131819.26266-7-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170914131819.26266-7-jack@suse.cz>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>, linux-mm@kvack.org
Cc: linux-f2fs-devel@lists.sourceforge.net, "Yan, Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On 2017/9/14 21:18, Jan Kara wrote:
> In several places we want to iterate over all tagged pages in a mapping.
> However the code was apparently copied from places that iterate only
> over a limited range and thus it checks for index <= end, optimizes the
> case where we are coming close to range end which is all pointless when
> end == ULONG_MAX. So just remove this dead code.
> 
> CC: Jaegeuk Kim <jaegeuk@kernel.org>
> CC: linux-f2fs-devel@lists.sourceforge.net
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
