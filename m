Return-Path: <SRS0=BUMQ=CD=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2FC433DF
	for <ceph-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE3320665
	for <ceph-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IvE75/ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHYU2u (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:28:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2308 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYU2t (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Aug 2020 16:28:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4574420000>; Tue, 25 Aug 2020 13:27:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 13:28:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 25 Aug 2020 13:28:49 -0700
Received: from [10.2.53.36] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 20:28:48 +0000
Subject: Re: [PATCH] ceph: drop special-casing for ITER_PIPE in ceph_sync_read
To:     Jeff Layton <jlayton@kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <idryomov@gmail.com>, <ukernel@gmail.com>,
        <viro@zeniv.linux.org.uk>
References: <20200825201326.286242-1-jlayton@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1143a189-7953-d523-bfd2-0fed8da83ac8@nvidia.com>
Date:   Tue, 25 Aug 2020 13:28:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825201326.286242-1-jlayton@kernel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598387266; bh=rd5FxNQI8kCc8bo8sI2nGwxro6PJHojMneLC0WJveGg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IvE75/ZYtufuhbbZmVQOt8VPirxA7mFQo0GSmL6brUacC3VrfG43hmXE5unmrvRUE
         Q/CdjYeRFIcrk5jcZEZLHaY7FfKH/jZOLsKEpkrEppFw7TnfzEHiC4qp3CA1Art3TX
         Cf/XPIWY15C8Rh/m44NuLVdusFoTsvnH+QJXSscVWCAadN99QTdxdnZlbpRPP8U3dE
         Q5qpqI8z9e8oZ57A6gYzWVPiSrf4Mu/XlDv7qeLy/o4YnbTNfTfe2e5irF4MhUXJnw
         utjW4zSJ76Lvi+UQ1qyY+nYNMHSO4nbqeyBGerpwVzV4D+Y/SNt7+ykmMhLAAms8Yd
         s0V1w2Hdx1Tzg==
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On 8/25/20 1:13 PM, Jeff Layton wrote:
> From: John Hubbard <jhubbard@nvidia.com>
>

I think that's meant to be, "From: Jeff Layton <jlayton@kernel.org>".
This looks much nicer than what I came up with. :)

> This special casing was added in 7ce469a53e71 (ceph: fix splice
> read for no Fc capability case). The confirm callback for ITER_PIPE
> expects that the page is Uptodate or a pagecache page and and returns
> an error otherwise.
> 
> A simpler workaround is just to use the Uptodate bit, which has no
> meaning for anonymous pages. Rip out the special casing for ITER_PIPE
> and just SetPageUptodate before we copy to the iter.
> 
> Cc: "Yan, Zheng" <ukernel@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/ceph/file.c | 71 +++++++++++++++++---------------------------------
>   1 file changed, 24 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index fb3ea715a19d..ed8fbfe3bddc 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -863,6 +863,8 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
>   		size_t page_off;
>   		u64 i_size;
>   		bool more;
> +		int idx;
> +		size_t left;
>   
>   		req = ceph_osdc_new_request(osdc, &ci->i_layout,
>   					ci->i_vino, off, &len, 0, 1,
> @@ -876,29 +878,13 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
>   
>   		more = len < iov_iter_count(to);
>   
> -		if (unlikely(iov_iter_is_pipe(to))) {
> -			ret = iov_iter_get_pages_alloc(to, &pages, len,
> -						       &page_off);


+1 for removing a call to iov_iter_get_pages_alloc()! My list is shorter now.


thanks,
-- 
John Hubbard
NVIDIA
