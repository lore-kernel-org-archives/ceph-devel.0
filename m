Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB511C3DA7A
	for <ceph-devel@archiver.kernel.org>; Fri,  6 Jan 2023 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjAFTpi (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjAFTpO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jan 2023 14:45:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361CE81C1B;
        Fri,  6 Jan 2023 11:45:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C18B561F35;
        Fri,  6 Jan 2023 19:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D61DC433F0;
        Fri,  6 Jan 2023 19:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673034310;
        bh=t0QJHS7GzsG7gBvvc1iRFnu9kKXmKbMthB+oLe/zMrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClubDpXF/Vrt9mJSv/Ng0sby1fhChk0b4adVRKYL+dSg27G2D42WT90pQ0K9CaKWD
         6phQju/a5jjJfNFxNt5xPqB4Lq2BnJZ2OqW5Wxal8t/23vn6iwsqmRI6znewtj+AJv
         A1mdxD7nM31PQAT7eX/MukbOucerLccq8T0NH+yTLMRaG+1xSa0J3HF3WcuBci7C5V
         e2B3B95K42UuxU1yUPdkpI5BjgZtSzAyTlIULrcYN1tPGVQzA7B4q+zKItBTQLNDUK
         885Mw+JMhoEf08DwlguDGtF97yUFvab1yV9PhnURgtKzGMd/yIdixJAsmnajsYnvgX
         cCQrLvS713LkQ==
From:   SeongJae Park <sj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] add folio_headpage() macro
Date:   Fri,  6 Jan 2023 19:45:07 +0000
Message-Id: <20230106194507.152468-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y7h0xNGlj0qzFlua@casper.infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Fri, 6 Jan 2023 19:21:40 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jan 06, 2023 at 05:40:25PM +0000, SeongJae Park wrote:
> > The standard idiom for getting head page of a given folio is
> > '&folio->page'.  It is efficient and safe even if the folio is NULL,
> > because the offset of page field in folio is zero.  However, it makes
> > the code not that easy to understand at the first glance, especially the
> > NULL safety.  Also, sometimes people forget the idiom and use
> > 'folio_page(folio, 0)' instead.  To make it easier to read and remember,
> > add a new macro function called 'folio_headpage()' with the NULL case
> > explanation.  Then, replace the 'folio_page(folio, 0)' calls with
> > 'folio_headpage(folio)'.
> 
> No.  Everywhere that uses &folio->page is a place that needs to be fixed.
> It shouldn't have a nice convenience macro.  It should make you mildly
> uncomfortable.

It's true that it's just a mild uncomfortableness.  I will respect your opinion
here.  Thanks for the input.


Thanks,
SJ
