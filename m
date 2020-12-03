Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F917C63777
	for <ceph-devel@archiver.kernel.org>; Thu,  3 Dec 2020 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F320C22206
	for <ceph-devel@archiver.kernel.org>; Thu,  3 Dec 2020 08:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgLCIyX (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:54:23 -0500
Received: from verein.lst.de ([213.95.11.211]:57654 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgLCIyX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:54:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B9FC867373; Thu,  3 Dec 2020 09:53:39 +0100 (CET)
Date:   Thu, 3 Dec 2020 09:53:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: add a hard-readonly flag to struct gendisk
Message-ID: <20201203085339.GA17110@lst.de>
References: <20201129181926.897775-1-hch@lst.de> <20201129181926.897775-2-hch@lst.de> <yq17dpza6nz.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17dpza6nz.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:04:33PM -0500, Martin K. Petersen wrote:
> 
> Hi Christoph!
> 
> >  - If BLKROSET is used to set a whole-disk device read-only, any
> >    partitions will end up in a read-only state until the user
> >    explicitly clears the flag.
> 
> This no longer appears to be the case with your tweak.

True.

> 
> It's very common for database folks to twiddle the read-only state of
> block devices and partitions. I know that our users will find it very
> counter-intuitive that setting /dev/sda read-only won't prevent writes
> to /dev/sda1.

What I'm worried about it is that this would be a huge change from the
historic behavior.
