Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F4AC4332F
	for <ceph-devel@archiver.kernel.org>; Mon, 25 Apr 2022 02:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiDYCtD (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Sun, 24 Apr 2022 22:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbiDYCs5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Apr 2022 22:48:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6D68FAA;
        Sun, 24 Apr 2022 19:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E7mcWVuhGHOBZP/77G6tVMwjs+9VtbP4nqFG3yJG4iQ=; b=KgYNbt818dLZeD4Avkrd/77N9n
        tWLsarh60PgprcUwyj6NTHgvlxG7wuD8PqS6uW2oVuZ01YDLF/MbGqjiy6NHq4LnMls/x7e/6Fthf
        NqB3BWuMPGZAScAcaH4S3WGWWO/G6HsOfLFvBV/nd+QfQ/5oNj3CimkyOdyE/4BBQSSJ8MsgNiOU4
        8xZ0/uAfriF+B9XYzrnjGQAdwMB82sBskQxpjzSXqrXbkZ7rzSvkJIkSpjbWsHYX44f4sgqVswfkY
        MTzG1KO0Duobr3v77xfhOe7fUFv5N7PG+adQnEUF24+ot04hC5cSue78CFPdXWYY77vShCSFSOSwt
        X2uBqUBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niojN-008N9K-SD; Mon, 25 Apr 2022 02:45:41 +0000
Date:   Mon, 25 Apr 2022 03:45:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        brauner@kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <YmYLVfZC3h8l7XY1@casper.infradead.org>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:09:38AM +0800, Yang Xu wrote:
> This has no functional change. Just create and export inode_sgid_strip
> api for the subsequent patch. This function is used to strip inode's
> S_ISGID mode when init a new inode.

Why would you call this inode_sgid_strip() instead of
inode_strip_sgid()?
