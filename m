Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA245C433B4
	for <ceph-devel@archiver.kernel.org>; Thu, 22 Apr 2021 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF0B60FE3
	for <ceph-devel@archiver.kernel.org>; Thu, 22 Apr 2021 11:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhDVLn5 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 22 Apr 2021 07:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236150AbhDVLnx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 385C160FE3;
        Thu, 22 Apr 2021 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619091798;
        bh=wEdMlp991eprr5DTVUnUaPpvWGgEwHWFbHw/5rvrfpc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aQqUKdHvmNA8ejF8WxoSfCica/q85aMZNK85VTAefAZsR2PeMwuW+kVtjFpk33gRy
         u4RKaOrv0vR5O0WOsW362veus1OqJwW57xLDWiHoxxvLkhUaobFrfEVQO22UVyswlW
         dG6W0SUH0qANpqieOJqLj02/eB3iaVapVkIZ9HYtiS5lLYeCvGWoFsF2TZPkHc86xW
         W5F2LAE9e8myXJlSbbUBOj2Y9UeKsE+MHy/fnrpO6iA7OIbTvEaIvoBkyLbMyfZPoE
         kGcx/w6VjCGYYvyYSxcDFWtSFe0Sr8ntTAiYc9eXkk5a9G/7Tadx5diDunM20lN9XQ
         hJ1vhbSxQi/Ag==
Message-ID: <fca235a3e2f0fe2a96d0482c3586372a9580c98b.camel@kernel.org>
Subject: Re: Hole punch races in Ceph
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Date:   Thu, 22 Apr 2021 07:43:16 -0400
In-Reply-To: <20210422111557.GE26221@quack2.suse.cz>
References: <20210422111557.GE26221@quack2.suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Thu, 2021-04-22 at 13:15 +0200, Jan Kara wrote:
> Hello,
> 
> I'm looking into how Ceph protects against races between page fault and
> hole punching (I'm unifying protection for this kind of races among
> filesystems) and AFAICT it does not. What I have in mind in particular is a
> race like:
> 
> CPU1					CPU2
> 
> ceph_fallocate()
>   ...
>   ceph_zero_pagecache_range()
> 					ceph_filemap_fault()
> 					  faults in page in the range being
> 					  punched
>   ceph_zero_objects()
> 
> And now we have a page in punched range with invalid data. If
> ceph_page_mkwrite() manages to squeeze in at the right moment, we might
> even associate invalid metadata with the page I'd assume (but I'm not sure
> whether this would be harmful). Am I missing something?
> 
> 								Honza

No, I don't think you're missing anything. If ceph_page_mkwrite happens
to get called at an inopportune time then we'd probably end up writing
that page back into the punched range too. What would be the best way to
fix this, do you think?

One idea:

We could lock the pages we're planning to punch out first, then
zero/punch out the objects on the OSDs, and then do the hole punch in
the pagecache? Would that be sufficient to close the race?

-- 
Jeff Layton <jlayton@kernel.org>

