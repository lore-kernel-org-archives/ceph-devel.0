Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCC4C48BE6
	for <ceph-devel@archiver.kernel.org>; Mon, 14 Jun 2021 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402FB61356
	for <ceph-devel@archiver.kernel.org>; Mon, 14 Jun 2021 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhFNOkR (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhFNOkQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jun 2021 10:40:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA0C061574;
        Mon, 14 Jun 2021 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h0gXs9FUEuqUOtEiLlkxnioJrZVuEfW5y8S7VSG0DmA=; b=h7FEq0+wZrmt3ClriW0D/sTC0O
        73n1HoLin6EZWZgAIhgQ7Nwj8GU5YVi0Bb2BirC2WYgJdGj/Yi1DNGz498GTllkeCWcVHKosK5w3M
        M35q0YARuwepIYJphideY2lSgFExQtJFW8Eg0bHmLkoahw7/9kEGaQaaeSwsDje1WNPOCiYDjkRX5
        7jpYoDh7wM0oFMH1EpmBGwR2SL4EP3g4zvuSMFt+N/QjLTWB642sJ7tE9WqaHxZCP+EoUr5zSvki4
        8BHzqymfLJuRfPui4E+QW+aNcCcpBNi9ZjrqTtmvct1MxY9uNTihdnpLNvchO6xNMog/OkaUrzc+q
        8vfccwcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsniv-005WQ3-UX; Mon, 14 Jun 2021 14:38:00 +0000
Date:   Mon, 14 Jun 2021 15:37:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
Message-ID: <YMdpxbYafHnE0F8N@casper.infradead.org>
References: <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
 <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:20:25PM +0100, David Howells wrote:
> @@ -135,8 +145,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
>  		write_sequnlock(&vnode->cb_lock);
>  	}
>  
> -	ASSERT(PageUptodate(page));
> -
>  	if (PagePrivate(page)) {
>  		priv = page_private(page);
>  		f = afs_page_dirty_from(page, priv);

Why are you removing this assertion?  Does AFS now support dirty,
partially-uptodate pages?  If so, a subsequent read() to that
page is going to need to be careful to only read the parts of the page
from the server that haven't been written ...
