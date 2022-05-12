Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF1FC433F5
	for <ceph-devel@archiver.kernel.org>; Thu, 12 May 2022 06:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350141AbiELGVQ (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 12 May 2022 02:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350261AbiELGVH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2022 02:21:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000DD2EA3F;
        Wed, 11 May 2022 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NKJZCdTXAAt7BpqCsYZ2uJit9L
        tv6BQvpgUDpJ43eQckfX+q5AHjdmV8zpaesgJTagvneNjXmyatkvIAh4JikAS7Fl76FA4S/kpPD52
        5UzFDePzQqzeBtJrlWmXhpGZtZSvT/90Qq7aVGM5GqrxXwrC/SL9t27rGwRX+D1msdikyqOO3g20A
        a/kjjrBSxouEvviq4eC8ziYkTmcNaJFuMz5I+/QWOq36MgLoszAjFr6J/O7p4B/q91OHF+AozRvf4
        SP5mYIsCNWupE1sTw2ErbRjVtqhI61VJ7U+xOHAqOvRHBv5ThZOqEyyetOf88uQtyMWyL4yvxls8E
        ya9Y8AsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np2C9-00ANUx-4J; Thu, 12 May 2022 06:21:05 +0000
Date:   Wed, 11 May 2022 23:21:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        idryomov@gmail.com, xiubli@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2] fs: change test in inode_insert5 for adding to the sb
 list
Message-ID: <YnynUSHEEGvIsAIq@infradead.org>
References: <20220511165339.85614-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511165339.85614-1-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
