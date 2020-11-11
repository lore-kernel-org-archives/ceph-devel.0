Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15F5C5517A
	for <ceph-devel@archiver.kernel.org>; Wed, 11 Nov 2020 12:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D16320795
	for <ceph-devel@archiver.kernel.org>; Wed, 11 Nov 2020 12:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJYWeNE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKKMxq (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKMxp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:53:45 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F90206F1;
        Wed, 11 Nov 2020 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605099225;
        bh=EF1MnYauU8ea50H9CTQLZyaZLkGyN9q5UuHsT8auZtM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tJYWeNE4phzm0VK6XWOPKD6i8HQerxVG6MiKTiTGaU4ECj5K6hD05q9Hrw7GTR/Q4
         0G2mcbTi81luH/Aua1ZOxQRTduTF8++OD3FipOAHmCQKQgUUYqjnghQmpqCdrWuEZc
         cQT+6D8e1Pb6uFRZDlKbVBLyIOKxPJbupgJJPak8=
Message-ID: <389065486cd51a9ceebe6edf9d1b3ea84129a62d.camel@kernel.org>
Subject: Re: [PATCH v2] ceph: ensure we have Fs caps when fetching dir link
 count
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com, pdonnell@redhat.com
Date:   Wed, 11 Nov 2020 07:53:43 -0500
In-Reply-To: <877dqsfd9m.fsf@suse.de>
References: <20201110163052.482965-1-jlayton@kernel.org>
         <877dqsfd9m.fsf@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Wed, 2020-11-11 at 09:34 +0000, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > The link count for a directory is defined as inode->i_subdirs + 2,
> > (for "." and ".."). i_subdirs is only populated when Fs caps are held.
> > Ensure we grab Fs caps when fetching the link count for a directory.
> > 
> 
> Maybe this would be worth a stable@ tag too...?
> 
> Cheers,

Usually I reserve stable tags for "real problems" (oopses, etc), that we
want to send to mainline immediately. This is just a subtle case where
the link count in a stat() call ends up looking wrong.

If someone wants to make a case for stable, I'm willing to listen, but
this one doesn't seem worth it.

-- 
Jeff Layton <jlayton@kernel.org>

