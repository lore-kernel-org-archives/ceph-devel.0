Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10DFC2D0A3
	for <ceph-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798C3221E9
	for <ceph-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvvQc7Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgKLP7R (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 12 Nov 2020 10:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgKLP7N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:59:13 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BA4221E9;
        Thu, 12 Nov 2020 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605196752;
        bh=NYsRACMkU10s2aj+rx0uQSdbBP8Yt7WT/evgDxpTAyY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=fvvQc7DizzA7FRak0Ss65IVGVcDIAqdTq2wTYlceFQ+VGrXrQ+EUJaCVVtr+VOuLC
         UrGK1v7Ehslf309FwG8nKcGkFNs7Uf299COnhKqTXBshuv1Gu9Sp1Zs0RufLtpeY+F
         1aFbzZ7pNTrjWfV+mbAKMR/QA/G9vRLxTKAtwPkE=
Message-ID: <cf0b22ada6eea3a23b84a945208066aeadd822b3.camel@kernel.org>
Subject: Re: Is there a way to make Cephfs kernel client to send data to
 Ceph cluster smoothly with buffer io
From:   Jeff Layton <jlayton@kernel.org>
To:     Sage Meng <lkkey80@gmail.com>, ceph-devel@vger.kernel.org
Date:   Thu, 12 Nov 2020 10:59:11 -0500
In-Reply-To: <CAF8vKShnH+xas+kLAcXL-Cxt6C3TF7TbP4Wfm0h48pEGCmsR+w@mail.gmail.com>
References: <CAF8vKShnH+xas+kLAcXL-Cxt6C3TF7TbP4Wfm0h48pEGCmsR+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Thu, 2020-11-12 at 23:17 +0800, Sage Meng wrote:
> Hi All,
> 
>       Cephfs kernel client is influenced by kernel page cache when we
> write data to it,  outgoing data will be huge when os starts to flush
> page cache. So Is there a way to make Cephfs kernel client to send
> data to ceph cluster smoothly when buffer io is used ? Better a way
> that only influence Ceph IO not the whole system IO.

Not really.

The ceph client just does what the VM subsys asks it to do. If the VM
says "write out these pages", then it'll do it -- otherwise they'll just
sit there dirty.

Usually you need to tune things like the dirty_ratio and
dirty_background_ratio to smooth this sort of thing out, but those are
system-wide knobs.

Another alternative is to strategically fsync or syncfs from time to
time, but that's sort of outside the scope of the kernel client.
-- 
Jeff Layton <jlayton@kernel.org>

