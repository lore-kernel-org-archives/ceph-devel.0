From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: set io_pages bdi hint
Date: Wed, 4 Jan 2017 11:25:19 +0800
Message-ID: <C3DA23CD-10FF-491D-BD31-0C1D8673105E@redhat.com>
References: <1483076488-2690-1-git-send-email-andreas.gerstmayr@catalysts.cc>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761265AbdADDZe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 3 Jan 2017 22:25:34 -0500
In-Reply-To: <1483076488-2690-1-git-send-email-andreas.gerstmayr@catalysts.cc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, andreas.gerstmayr@gmail.com, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>


> On 30 Dec 2016, at 13:37, Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc> wrote:
> 
> This patch sets the io_pages bdi hint based on the rsize mount option.
> Without this patch large buffered reads (request size > max readahead)
> are processed sequentially in chunks of the readahead size (i.e. read
> requests are sent out up to the readahead size, then the
> do_generic_file_read() function waits until the first page is received).
> 
> This patch removes this cap and enables parallel reads up to the
> specified maximum read size mount option (rsize).
> 
> Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
> ---
> 
> Feedback is appreciated. Maybe we should apply a sensible default value
> for rsize instead of unlimited?
> 
> Please note: This patch depends on commit #9491ae4, which is not yet
> merged in the testing branch of the ceph-client repository (this commit
> is included in kernel version 4.10-rc1).
> 
> 
> fs/ceph/super.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 6bd20d7..3c50477 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -952,6 +952,13 @@ static int ceph_register_bdi(struct super_block *sb,
> 		fsc->backing_dev_info.ra_pages =
> 			VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
> 
> +	if (fsc->mount_options->rsize)
> +		fsc->backing_dev_info.io_pages =
> +			(fsc->mount_options->rsize + PAGE_SIZE - 1)
> +			>> PAGE_SHIFT;
> +	else
> +		fsc->backing_dev_info.io_pages = ULONG_MAX;
> +

unlimited by default does not seem like a good idea. I think we should set CEPH_RSIZE_DEFAULT to reasonable value (such as 64M)


Regards
Yan, Zheng

> 	err = bdi_register(&fsc->backing_dev_info, NULL, "ceph-%ld",
> 			   atomic_long_inc_return(&bdi_seq));
> 	if (!err)
> -- 
> 1.8.3.1
> 

