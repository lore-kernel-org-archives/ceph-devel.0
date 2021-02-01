Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C9C433E6
	for <ceph-devel@archiver.kernel.org>; Mon,  1 Feb 2021 19:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A981264DA8
	for <ceph-devel@archiver.kernel.org>; Mon,  1 Feb 2021 19:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBATCY (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBATCT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:02:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17BFF60231;
        Mon,  1 Feb 2021 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612206099;
        bh=GjgQWTPwMBbunWHSvGA0HIOrHZnm8yM7vHKrYYvgF5M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HJsIyed6+R8ohltTtac9e2uni0+4Ie8NGXwvQOG+a9yObVq/CI7gaSJzR3CVs+rJW
         mGhv9O+tObmKM3/TTLIEBA3z7WCMIV7qyOsAIkfBydr3LOpnrG44dTHmLvcv6s1uK4
         dMOdxzetagV7+W0qIhJHH53BBDoeN2399skinae+7U1UN2cTv9DAepKFyJ7e9h0vjE
         uuRflOITu1y3/SdkOd/C3WekpfwWMAqyt3u2r6Dgve2QdvgY4nYIHf8oZCqw6ROB3t
         2fawDqwBJUuv/nWQPlmMCvqFCgVNd4zIqfvB0VaAjQopb748sKrjr6ixag52K3hRW8
         Flbdz+79p0V8A==
Message-ID: <8e9e8cb8b102e3d19639d43567f57c7039b12eab.camel@kernel.org>
Subject: Re: [PATCH] ceph: Replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
From:   Jeff Layton <jlayton@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Feb 2021 14:01:37 -0500
In-Reply-To: <1612165930-110076-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1612165930-110076-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2021-02-01 at 15:52 +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
> 
> ./fs/ceph/debugfs.c:347:0-23: WARNING: congestion_kb_fops should be
> defined with DEFINE_DEBUGFS_ATTRIBUTE.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/ceph/debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> index 66989c8..617327e 100644
> --- a/fs/ceph/debugfs.c
> +++ b/fs/ceph/debugfs.c
> @@ -344,8 +344,8 @@ static int congestion_kb_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> 
> -DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> -			congestion_kb_set, "%llu\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
> +			  congestion_kb_set, "%llu\n");
>  
> 
>  
> 
>  void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)

Looks reasonable. Merged into ceph-client/testing branch.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

