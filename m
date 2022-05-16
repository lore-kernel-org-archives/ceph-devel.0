Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3101C433FE
	for <ceph-devel@archiver.kernel.org>; Mon, 16 May 2022 06:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbiEPGAL (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 16 May 2022 02:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiEPGAI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2022 02:00:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C96B1B7BA;
        Sun, 15 May 2022 23:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=g+o8sodhtoWcxq2TQAmheHP3R7
        VBkKEY71gl0g0vVRzaD9BUIKs7lsqzoyS1A15NtFbMmOcvL0y9XtEGDxCXqrliXOL/1iNEGqvOqa4
        uEMz3Sv6Q/WPq3hMpI4CW3qRMcGGHd9g73x2orGxE9Eiw4v6vqRJna7pui+5LMxp5QolNOWgxrh4X
        AF3ZLNBNaBIStxL+qP6Eqwbc0JwAJVTuEAaVmEOq373MS9rCI8R1iB5EYOg259HP2u/izJua9rAcm
        wFCkSLLgzknUpGmkLLKE8Yqh5xILqQLftUPTgJ8KD4ROaFRuRnD+nUtE5HPykWilKxGg9uqp0me2M
        TJ30Acjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqTm0-0066N7-ST; Mon, 16 May 2022 06:00:04 +0000
Date:   Sun, 15 May 2022 23:00:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: change test in inode_insert5 for adding to the sb
 list
Message-ID: <YoHoZCeCjZmKg19U@infradead.org>
References: <20220331225632.247244-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331225632.247244-1-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
