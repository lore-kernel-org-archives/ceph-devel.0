Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C6C12002
	for <ceph-devel@archiver.kernel.org>; Wed, 21 Jul 2021 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D5861249
	for <ceph-devel@archiver.kernel.org>; Wed, 21 Jul 2021 14:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhGUN2U (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 21 Jul 2021 09:28:20 -0400
Received: from verein.lst.de ([213.95.11.211]:58868 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234380AbhGUN2S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:28:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B6F767373; Wed, 21 Jul 2021 16:08:52 +0200 (CEST)
Date:   Wed, 21 Jul 2021 16:08:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] rbd: resurrect setting of disk->private_data in
 rbd_init_disk()
Message-ID: <20210721140852.GA9523@lst.de>
References: <20210721130950.3359-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721130950.3359-1-idryomov@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Oops, sorry. Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
