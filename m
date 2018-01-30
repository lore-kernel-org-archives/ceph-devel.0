From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: improving efficiency of syncfs
Date: Tue, 30 Jan 2018 15:05:50 +0800
Message-ID: <B0E2B060-6C05-4851-8B19-6B4AFA1F4509@redhat.com>
References: <1517277750-144449-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeA3HGA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Jan 2018 02:06:00 -0500
In-Reply-To: <1517277750-144449-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: idryomov@gmail.com, sage@redhat.com, ceph-devel@vger.kernel.org



> On 30 Jan 2018, at 10:02, Chengguang Xu <cgxu519@icloud.com> wrote:
> 
> write_inode() could be called variety of reasons, in the case of syncfs(2)
> there is no need to wait for flush getting completed in write_inode(),
> ->sync_fs is for guaranteeing flush completion for all inodes at that point.
> 
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
> fs/ceph/caps.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index a14b2c9..fd6ce29 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2160,7 +2160,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
> 	u64 flush_tid;
> 	int err = 0;
> 	int dirty;
> -	int wait = wbc->sync_mode == WB_SYNC_ALL;
> +	int wait = (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync);
> 
> 	dout("write_inode %p wait=%d\n", inode, wait);
> 	if (wait) {
> -- 
> 1.8.3.1
> 

Applied, thanks

Yan, Zheng

