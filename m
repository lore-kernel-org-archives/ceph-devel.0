Return-Path: <SRS0=Fqvp=DN=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F3EC41604
	for <ceph-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7A7206CB
	for <ceph-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sUlepyq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJFOwg (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFOwg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Oct 2020 10:52:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A1C061755
        for <ceph-devel@vger.kernel.org>; Tue,  6 Oct 2020 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oec1CGwqELypNA1ej9IuVU/OSeJYgIiL7MqIj7n6QmE=; b=sUlepyq/ntExqVvyy6p2JvZoN4
        vTZmgV5VUhlFTJVvlQ75Ku9X2M6489hMet8kX8vUWp/oOm4QD7PBEOl7AnocTn5k+djMrfQw0TvVr
        Eo45LgQemhab9MVj5bhcuEue0SiFGZopXU0vafIoJGqquO4D4iwRQ5QviOSmu60VMh0ChheXX2ryZ
        WAfhbJ6igUBwBrZ+2bE/0qg93EGHsrMrBJl+TwBvNGCJgBCPk0MCPNGOyjQNrmWaiqr9QwEHYRm11
        8IBOtML3xcLUjhHVt0GPfKw38hbeacvz+8dQrz9z0Gho0pT4Rh6zsKQYO3rbhyTvcJ2atswsVqhSx
        SAurL8Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPoKQ-0007NF-FN; Tue, 06 Oct 2020 14:52:34 +0000
Date:   Tue, 6 Oct 2020 15:52:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com, ukernel@gmail.com,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] ceph: don't SetPageError on readpage errors
Message-ID: <20201006145234.GR20115@casper.infradead.org>
References: <20201006141307.309650-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006141307.309650-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:13:07AM -0400, Jeff Layton wrote:
> PageError really only has meaning within a particular subsystem. Nothing
> looks at this bit in the core kernel code, and ceph itself doesn't care
> about it. Don't bother setting the PageError bit on error.

I wondered if fscache might be interested, but it seems like it doesn't
particularly care.  It's still interested in PageError for backing
store pages, but not for the filesystem being cached.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/addr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 97827f68a3e7..137c0a5a2a0d 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -241,7 +241,6 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
>  	if (err == -ENOENT)
>  		err = 0;
>  	if (err < 0) {
> -		SetPageError(page);
>  		ceph_fscache_readpage_cancel(inode, page);
>  		if (err == -EBLOCKLISTED)
>  			fsc->blocklisted = true;
> -- 
> 2.26.2
> 
