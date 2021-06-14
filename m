Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3CEC2B9F4
	for <ceph-devel@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8B8613B2
	for <ceph-devel@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhFNM4s (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhFNM4r (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jun 2021 08:56:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B0C061766
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jun 2021 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YiH7i2CX6XKrcqWaZJeYKcShlu0hPOmt1QbvEnDRzVU=; b=Gj3qYEkR3p0pA2QAJ2yE8jmznZ
        GIJQlVt46TJeeMV1BAWq5psQTiDSMtgijJ+pAclFdztSMmC4RT0X30s3cpbL2miCFB4cqEZJtk8Ya
        sBIWUWRZN4A4choHtnMCgw0qiWnqHLypXiIhZHowBfw7+ZrFoXlCQME8Y36DCo8os3A5WcK3VE5cc
        dHN6tcqc9/FEsnXk8enOmGPE/jJXypTRQhzmXSZ+VdtZk4oSdRhqcr1aRAFoySBj5A44PgXWXcvPw
        UWT61ub47F2Z00ULMdIs3ybGWgACQ8saZfeHU4nJ/lwrveovBON731GmVScFUTFy37Ltx9jPgFAUi
        JNzp2JvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsm6b-005Qyl-6c; Mon, 14 Jun 2021 12:54:20 +0000
Date:   Mon, 14 Jun 2021 13:54:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        idryomov@gmail.com, pfmeec@rit.edu, ceph-devel@vger.kernel.org,
        Andrew W Elble <aweits@rit.edu>
Subject: Re: [PATCH] netfs: fix test for whether we can skip read when
 writing beyond EOF
Message-ID: <YMdReUyU60dkNWEb@casper.infradead.org>
References: <20210613233345.113565-1-jlayton@kernel.org>
 <398005.1623673532@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398005.1623673532@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, Jun 14, 2021 at 01:25:32PM +0100, David Howells wrote:
> +	/* Full page write */
> +	if (offset == 0 && len >= thp_size(page))
> +		return true;
> +
> +	/* pos beyond last page in the file */
> +	if (pos - offset >= i_size)
> +		goto zero_out;
> +
> +	/* Write that covers from the start of the page  to EOF or beyond */

spurious double space between page and to.

> @@ -1090,13 +1119,8 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	 * within the cache granule containing the EOF, in which case we need
>  	 * to preload the granule.
>  	 */
> -	size = i_size_read(inode);
>  	if (!ops->is_cache_enabled(inode) &&
> -	    ((pos_in_page == 0 && len == thp_size(page)) ||
> -	     (pos >= size) ||
> -	     (pos_in_page == 0 && (pos + len) >= size))) {
> -		netfs_clear_thp(page);
> -		SetPageUptodate(page);
> +	    netfs_prep_noread_page(page, pos, len)) {

I don't like the name ... netfs_skip_page_read()?

