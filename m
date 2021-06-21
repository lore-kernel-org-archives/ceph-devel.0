Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8EC48BE5
	for <ceph-devel@archiver.kernel.org>; Mon, 21 Jun 2021 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF0460FDA
	for <ceph-devel@archiver.kernel.org>; Mon, 21 Jun 2021 14:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFUOyI (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUOyH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jun 2021 10:54:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9DC061574;
        Mon, 21 Jun 2021 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E5UtLj3YvE+3pbwbOhdxSbthFE/nQMzXTvlgUtUaz0A=; b=WrgMDakfQkZ2nkppn4qLsDXgC2
        ZZ/NiJTOlED2t/bDaix2G/7oeu4m9FKk7SX5nJUgArPJrugNDxSVR6MLOwAWHh7fS73gODhiHIRBF
        ncxXH1nbOMKvToqdsgvHHQEGUPYiLVXpMAflgPpHZtDtCtQVIQwHmRdfMheZcFRjkW7va7RE9GWWZ
        yJ3Z9NoqOq6JnJjVq6+dFCQFtjjOpIqPV8Xgdz0RZtC2fWGWSidfKkSQHB4oZRW9dZaLcTOUOTfeJ
        OO7D0Jt2IQkBLiPGPzLNPW7gG2Wpe/j5J8gPTPzp4Xr0VhIzkv8sbJ69jtwpRqSRYGWvRyjD36VXH
        /mDIem5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLGD-00DCT3-5t; Mon, 21 Jun 2021 14:51:03 +0000
Date:   Mon, 21 Jun 2021 15:50:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Andrew W Elble <aweits@rit.edu>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] netfs: fix test for whether we can skip read when
 writing beyond EOF
Message-ID: <YNCnSQyKWqV8SkRs@casper.infradead.org>
References: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
 <162391826758.1173366.11794946719301590013.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162391826758.1173366.11794946719301590013.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:24:27AM +0100, David Howells wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> It's not sufficient to skip reading when the pos is beyond the EOF.
> There may be data at the head of the page that we need to fill in
> before the write.
> 
> Add a new helper function that corrects and clarifies the logic of
> when we can skip reads, and have it only zero out the part of the page
> that won't have data copied in for the write.
> 
> Finally, don't set the page Uptodate after zeroing. It's not up to date
> since the write data won't have been copied in yet.
> 
> [DH made the following changes:
> 
>  - Prefixed the new function with "netfs_".
> 
>  - Don't call zero_user_segments() for a full-page write.
> 
>  - Altered the beyond-last-page check to avoid a DIV instruction and got
>    rid of then-redundant zero-length file check.
> ]
> 
> Fixes: e1b1240c1ff5f ("netfs: Add write_begin helper")
> Reported-by: Andrew W Elble <aweits@rit.edu>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: ceph-devel@vger.kernel.org
> Link: https://lore.kernel.org/r/20210613233345.113565-1-jlayton@kernel.org/
> Link: https://lore.kernel.org/r/162367683365.460125.4467036947364047314.stgit@warthog.procyon.org.uk/ # v1

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
